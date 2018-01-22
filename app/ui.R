library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("paper"),
  
  # Application title
  titlePanel("poemarkov"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h4("poem generator"),
       
       textInput("username", "Username:"),
       
       sliderInput("nrow","Number of rows", min = 1, max = 20, value = 7),
       
       actionButton("generate", "Generate"),
       
       div(
         helpText(
         a(icon("github"), href = "https://www.github.com/sercandogan/poemarkov"),
         a(icon("twitter"), href = "https://twitter.com/sergiostats")
         )
       )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       htmlOutput("poem")
    )
  )
))
