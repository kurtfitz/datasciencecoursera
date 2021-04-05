# This is a shiny app to determine

library(shiny)
library(ggplot2)
library(curl)

# Define server logic
shinyServer(function(input, output) {
  
  # load data
  data("mtcars")
  
  # create the initial output
  output$distPlot <- renderPlot({

    ggplot(mtcars, aes(!!input$variable)) + geom_histogram()
    
  }, height = 700)
  })