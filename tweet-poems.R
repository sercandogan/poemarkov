library(tidyverse)
library(twitteR)
library(markovchain)

consumer_key <- ""
consumer_secret <- ""


setup_twitter_oauth(consumer_key = consumer_key,
                    consumer_secret = consumer_secret)

usertweets <- userTimeline("sergiostats", n = 250) # my username

usertweets <- twListToDF(usertweets)
usertweets <- gsub('http\\S+\\s*', '', usertweets$text) # remove urls
usertweets <- gsub('\\b+RT', '', usertweets) # remove rt
usertweets <- gsub('#\\S+', '', usertweets) # remove hashtags
usertweets <- gsub('@\\S+', '', usertweets) # remove mentions
usertweets <- gsub('[[:cntrl:]]', '', usertweets) # remove controls characters
usertweets <- gsub('\\d', '', usertweets) # remove special characters
usertweets <- gsub('[[:punct:]]', '', usertweets) # remove punctuations
usertweets <- gsub('^[[:space:]]*', '', usertweets) # remove leading whitespaces
usertweets <- gsub('[[:space:]]*$', '', usertweets) # remove traling whitespaces
usertweets <- gsub(' +', ' ', usertweets) # remove extra whitespaces
usertweets <- gsub('\\p{So}|\\p{Cn}', '', usertweets, perl = TRUE) # remove emojis

words <- unlist(strsplit(usertweets, ' '))

words <- stringr::str_to_lower(words)


poem_fit <- markovchainFit(words, method = "map") # Bayesian method

poem <- c()
for(i in 1:12){
  n <- sample(4:9,1)
  poem <- c(poem,paste(markovchainSequence(n=n, markovchain=poem_fit$estimate), collapse=' '))
}

cat(paste(poem, collapse = "\n"))



