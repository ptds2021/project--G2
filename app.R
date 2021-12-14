library(hectimetables)
library(shinythemes)
library(shinyWidgets)
library(shiny)
hectimetables::dummy_creation()

# Define UI

ui <- navbarPage(
  theme = shinytheme("cerulean"),
  "HEC Lausanne - Timetable suggestions for BA students",
  tabPanel(
    "Semester 1",
    sidebarPanel(
      # ECTS choices
      helpText("Click here to display a custom timetable."),
      actionButton(inputId = "submit_1", label = "Suggest timetable!"),
      hr(),
      helpText("Choose here your preferences."),
      sliderInput(
        inputId = "CORE_credits_1",
        min = 0,
        max = 18,
        value = 18,
        step = 6, ticks = TRUE,
        label = "Mandatory credits"
      ),
      sliderInput(
        inputId = "ELECTIVE_credits_1",
        min = 0,
        max = 24,
        value = 12,
        step = 6, ticks = TRUE,
        label = "Elective credits"
      ),
      #Classes choices
      pickerInput(
        inputId = "Classes_1",
        label = "Classes:",
        choices = classes_semester[[1]],
        selected = classes_mandatory[[1]],
        # Refer to mandatory classes
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ),
      # Moments choices
      pickerInput(
        inputId = "Moments_1",
        label = "Day - AM/PM:",
        choices = moments_semester[[1]],
        selected = moments_semester[[1]],
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ), 
      helpText("Mandatory classes (OMM, QMM, DSIBA) should not be removed."),
      helpText("If nothing is displayed, you
               have inputed impossible preferences based on the constraints. Please check
               the selected classes and half-day periods for incompatibilities."), 
    ),
    # Show a plot of the generated distribution
    mainPanel(mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Visual Timetable (first seven weeks)", plotOutput("timetable_1_graph_F")),
        tabPanel("Visual Timetable (last seven weeks)", plotOutput("timetable_1_graph_L")),
        tabPanel("More detailed Timetable", tableOutput("timetable_1"))
      ),
      style = 'width: 100%'
    ))
  ),
  tabPanel(
    "Semester 2",
    sidebarPanel(
      # ECTS choices
      helpText("Click here to display a custom timetable."),
      actionButton(inputId = "submit_2", label = "Suggest timetable!"),
      hr(),
      helpText("Choose here your preferences."),
      sliderInput(
        inputId = "CORE_credits_2",
        min = 0,
        max = 36,
        value = 12,
        step = 3, ticks = TRUE,
        label = "Mandatory credits"
      ),
      sliderInput(
        inputId = "ELECTIVE_credits_2",
        min = 0,
        max = 24,
        value = 18,
        step = 3, ticks = TRUE,
        label = "Elective credits"
      ),
      #Classes choices
      pickerInput(
        inputId = "Classes_2",
        label = "Classes:",
        choices = classes_semester[[2]],
        selected = classes_mandatory[[2]],
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ),
      # Moments choices
      pickerInput(
        inputId = "Moments_2",
        label = "Day - AM/PM:",
        choices = moments_semester[[2]],
        selected = moments_semester[[2]],
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ), 
      helpText("Mandatory class (Company Project) should not be removed."),
      helpText("If nothing is displayed, you have inputed impossible preferences based on the constraints.
               Please check the selected classes and half-day periods for incompatibilities."), 
    ),
    # Show a plot of the generated distribution
    mainPanel(mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Visual Timetable (first seven weeks)", plotOutput("timetable_2_graph_F")),
        tabPanel("Visual Timetable (last seven weeks)", plotOutput("timetable_2_graph_L")),
        tabPanel("More detailed Timetable", tableOutput("timetable_2"))
      ),
      style = 'width: 100%'
    ))
  ),
  tabPanel(
    "Semester 3",
    sidebarPanel(
      helpText("Click here to display a custom timetable."),
      actionButton(inputId = "submit_3", label = "Suggest timetable!"),
      hr(),
      helpText("Choose here your preferences."),
      # ECTS choices
      sliderInput(
        inputId = "CORE_credits_3",
        min = 0,
        max = 36,
        value = 12,
        step = 3, ticks = TRUE,
        label = "Mandatory credits"
      ),
      sliderInput(
        inputId = "ELECTIVE_credits_3",
        min = 0,
        max = 24,
        value = 18,
        step = 3, ticks = TRUE,
        label = "Elective credits"
      ),
      
      #Classes choices
      pickerInput(
        inputId = "Classes_3",
        label = "Classes:",
        choices = classes_semester[[3]],
        selected = classes_mandatory[[3]],
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ),
      # Moments choices
      pickerInput(
        inputId = "Moments_3",
        label = "Day - AM/PM:",
        choices = moments_semester[[3]],
        selected = moments_semester[[3]],
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 3"
        ),
        multiple = TRUE
      ),
      helpText("If nothing is displayed, you have inputed impossible preferences based on the constraints.
               Please check the selected classes and half-day periods for incompatibilities."), 
    ),
    # Show a plot of the generated distribution
    mainPanel(mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Visual Timetable (first seven weeks)", plotOutput("timetable_3_graph_F")),
        tabPanel("Visual Timetable (last seven weeks)", plotOutput("timetable_3_graph_L")),
        tabPanel("More detailed Timetable", tableOutput("timetable_3"))
      ),
      style = 'width: 100%'
    ))
  )
)

# Define server
server <- function(input, output, session) {
  choice_1 <- eventReactive(input$submit_1,  {
    hectimetables::class_optim(
      1,
      f.obj,
      f.con,
      f.dir,
      input$CORE_credits_1,
      input$ELECTIVE_credits_1,
      input$Moments_1,
      input$Classes_1
    )
  })
  
  output$timetable_1 <-
    renderTable({
      hectimetables::display_text_timetable(1, choice_1())
    })
  output$timetable_1_graph_F <-
    renderPlot({
      hectimetables::display_visual_timetable(1, choice_1(), 1)
    })
  
  output$timetable_1_graph_L <-
    renderPlot({
      hectimetables::display_visual_timetable(1, choice_1(), 2)
    })
  
  choice_2 <- eventReactive(input$submit_2, {
    hectimetables::class_optim(
      2,
      f.obj,
      f.con,
      f.dir,
      input$CORE_credits_2,
      input$ELECTIVE_credits_2,
      input$Moments_2,
      input$Classes_2
    )
  })
  
  output$timetable_2 <-
    renderTable({
      hectimetables::display_text_timetable(2, choice_2())
    })
  output$timetable_2_graph_F <-
    renderPlot({
      hectimetables::display_visual_timetable(2, choice_2(), 1)
    })
  
  output$timetable_2_graph_L <-
    renderPlot({
      hectimetables::display_visual_timetable(2, choice_2(), 2)
    })
  
  choice_3 <- eventReactive(input$submit_3, {
    hectimetables::class_optim(
      3,
      f.obj,
      f.con,
      f.dir,
      input$CORE_credits_3,
      input$ELECTIVE_credits_3,
      input$Moments_3,
      input$Classes_3
    )
  })
  
  output$timetable_3 <-
    renderTable({
      hectimetables::display_text_timetable(3, choice_3())
    })
  
  output$timetable_3_graph_F <-
    renderPlot({
      hectimetables::display_visual_timetable(3, choice_3(), 1)
    })
  
  output$timetable_3_graph_L <-
    renderPlot({
      hectimetables::display_visual_timetable(3, choice_3(), 2)
    })
  
}

shinyApp(ui, server)