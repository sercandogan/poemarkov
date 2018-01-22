# poemarkov

Poem generator using markov chain and tweets

## Install

you firstly need to create an app on https://apps.twitter.com/ then change  `consumer_key` and `consumer_secret` on `tweet-poems.R`

For using `twitteR` package on local, you must change your twitter app's callback URL as "http://127.0.0.1:1410/"

##### Shiny App

You can use your `consumer_key` and `consumer_secret` on `app/server.R` 

then you can run your app:
```r
runApp('app')
```

![Screenshot](http://www.github.com/sercandogan/peomarkov/screenshot1.png)

### Deployment

I've deployed as shiny app on shinyapps.io : https://sercandogan.shinyapps.io/poemarkov/


### Inspiration 

http://katiejolly.io/blog/2018-01-05/random-rupi-markov-chain-poems


