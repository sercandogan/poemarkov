
set.seed(21012012)
library(shiny)
library(twitteR)
library(markovchain)
# for shiny
library(ROAuth)
library(httr)
library(httpuv)
library(base64enc) 
library(openssl)


consumer_key <- ""
consumer_secret <- ""




shinyServer(function(input, output, session) {
  
  
  
  
   action <- eventReactive(
    input$generate,{
      
      username <- input$username
      
      if(username == ""){
        stop("username cannot be empty")
      }
      
      if(grepl("@",username)){
        username <- gsub("@","",username)
      }
      
      
      setup_twitter_oauth(consumer_key = consumer_key, 
                          consumer_secret = consumer_secret)
      
      usertweets <- userTimeline(username, n = 100)
      
      usertweets <- twListToDF(usertweets) # to data frame
      
      # it would be a function here
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
        for(i in 1:input$nrow){
          n <- sample(4:9,1)
          poem <- c(poem,paste(markovchainSequence(n=n, markovchain=poem_fit$estimate), collapse=' '))
        
        }
      
      poem <- c(poem, paste0("-- @", username))
      HTML(paste(poem, collapse = "<br>"))
      
        
      
  })
  
  output$poem <- renderText({ action() })
  
  
  
  
  
})
