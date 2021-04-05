# This is the user interface for the shiny app to view histogram of variables

library(shiny)
library(ggplot2)

# load data
data("mtcars")

# Define UI for the application
shinyUI(fluidPage(
  # Title Panel
  titlePanel("Cars Data"),

  # Define U# Sidebar with an input for number of variables
  sidebarLayout(sidebarPanel(h4("Choose Variable"),
    varSelectInput("variable", "Variable:", mtcars)),
    
  mainPanel("Variable Histogram", plotOutput("distPlot"))
)))
