library(shiny)
library(pkghw4g2)

# Define UI
ui <- shinyUI(fluidPage(
  titlePanel("Area Estimator"),
  sidebarLayout(
    sidebarPanel(
      numericInput(
        inputId = "seed",
        value = 10,
        label = "Seed"
      ),
      sliderInput(
        inputId = "B",
        min = 0,
        max = 1000000,
        value = 5000,
        label = "B"
      )
    ),
    mainPanel("Estimated area plotted", plotOutput("plot"),
              "Time of the execution", textOutput("time"),
              "Value of the estimated area", textOutput("area")
    )
  )
))
