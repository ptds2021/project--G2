library(shiny)
library(dplyr)
library(pkghw4g2)

server <- shinyServer(function(input, output) {
  simulate <- reactive({
    # Get the inputs of user
    input$B
    input$seed
  })

  output$plot <- renderPlot({
    # Plot the output based on the user inputs
    plot(estimate_area(input$B, input$seed))
  })

  output$time <- renderText({
    # Extract the time of the execution
    system.time({
      estimate_area(input$B, input$seed)
    })[3] %>% unname()
  })

  output$area <- renderText({
    # Extract the estimated value
    estimate_area(input$B, input$seed)[1] %>% unlist() %>% unname()
  })

})

shinyApp(ui, server)
