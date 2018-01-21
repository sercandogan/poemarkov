library(tidyverse)
library(markovchain)
library(readtext)

# Poem List
#' Nazım Hikmet - Yaşamaya Dair
#' Sabahattin Ali - Rüzgar
#' 


poems <- readtext("data/*.txt")


poems$text <- gsub("\n", " ", ruzgar$text) # replace newline characters with space
poems$text <- gsub("[^[:alnum:][:space:]']", "", ruzgar$text) # remove punctuations


terms <- unlist(strsplit(poems$text, ' '))

poem_fit <- markovchainFit(terms, method = "map") # Bayesian Method

poem <- c()
for(i in 1:20){
  n <- sample(2:9,1)
  poem <- c(poem,paste(markovchainSequence(n=n, markovchain=poem_fit$estimate), collapse=' '))
  if(i %% 4 == 0){
    poem <- c(poem, " ")
  }
}
poem
