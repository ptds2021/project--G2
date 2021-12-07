hectimetables::dummy_creation()
library(shinythemes)
library(shinyWidgets)
library(shiny)

# Define UI
ui <- navbarPage(theme = shinytheme("cerulean"),
                 "HEC Lausanne - Timetable suggestions for Management students",
                 tabPanel(
                   "Semester 1",
                   sidebarPanel(
                     # ECTS choices
                     actionButton(inputId = "submit_1", label = "Suggest timetable"),
                     sliderInput(
                       inputId = "credits_1",
                       min = 0,
                       max = 42,
                       value = 30,
                       label = "Total credits"),
                     sliderInput(
                       inputId = "CORE_credits_1",
                       min = 0,
                       max = 36,
                       value = 18,
                       label = "Mandatory credits"),
                     sliderInput(
                       inputId = "ELECTIVE_credits_1",
                       min = 0,
                       max = 24,
                       value = 12,
                       label = "Elective credits"),
                     #Classes choices
                     pickerInput(
                       inputId = "Classes_1",
                       label = "Classes:",
                       choices = classes_semester[[1]],
                       selected = classes_mandatory[[1]], # Refer to mandatory classes
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE),
                     # Moments choices
                     pickerInput(
                       inputId = "Moments_1",
                       label = "Day - AM/PM:",
                       choices = moments_semester[[1]],
                       selected = moments_semester[[1]],
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE)),
                   # Show a plot of the generated distribution
                   mainPanel(mainPanel(tabsetPanel(type = "tabs",
                                                   tabPanel("Visual Timetable", plotOutput("timetable_1_graph")),
                                                   tabPanel("More detailed Timetable", tableOutput("timetable_1"))), 
                                       style='width: 100%'))),
                 tabPanel(
                   "Semester 2",
                   sidebarPanel(
                     # ECTS choices
                     actionButton(inputId = "submit_2", label = "Suggest timetable"),
                     sliderInput(inputId = "credits_2",
                                 min = 0, max = 42, value = 30, label = "Total credits"),
                     sliderInput(inputId = "CORE_credits_2",
                                 min = 0, max = 36, value = 12, label = "Mandatory credits"),
                     sliderInput(inputId = "ELECTIVE_credits_2",
                                 min = 0, max = 24, value = 18, label = "Elective credits"),
                     #Classes choices
                     pickerInput(
                       inputId = "Classes_2",
                       label = "Classes:",
                       choices = classes_semester[[2]],
                       selected = classes_mandatory[[2]],
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE),
                     # Moments choices
                     pickerInput(
                       inputId = "Moments_2",
                       label = "Day - AM/PM:",
                       choices = moments_semester[[2]],
                       selected = moments_semester[[2]],
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE)),
                   # Show a plot of the generated distribution
                   mainPanel(mainPanel(tabsetPanel(type = "tabs",
                                                   tabPanel("Visual Timetable", plotOutput("timetable_2_graph")),
                                                   tabPanel("More detailed Timetable", tableOutput("timetable_2"))), 
                                       style='width: 100%'))),
                 tabPanel(
                   "Semester 3",
                   sidebarPanel(
                     actionButton(inputId = "submit_3", label = "Suggest timetable"),
                     # ECTS choices
                     sliderInput(inputId = "credits_3",
                                 min = 0, max = 42, value = 30, label = "Total credits"),
                     sliderInput(inputId = "CORE_credits_3",
                                 min = 0, max = 36, value = 12, label = "Mandatory credits"),
                     sliderInput(inputId = "ELECTIVE_credits_3",
                                 min = 0, max = 24, value = 18, label = "Elective credits"),
                     
                     #Classes choices
                     pickerInput(
                       inputId = "Classes_3",
                       label = "Classes:",
                       choices = classes_semester[[3]],
                       selected = classes_mandatory[[3]],
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE),
                     # Moments choices
                     pickerInput(
                       inputId = "Moments_3",
                       label = "Day - AM/PM:",
                       choices = moments_semester[[3]],
                       selected = moments_semester[[3]],
                       options = list(
                         `actions-box` = TRUE, size = 10,
                         `selected-text-format` = "count > 3"),
                       multiple = TRUE)),
                   # Show a plot of the generated distribution
                   mainPanel(mainPanel(tabsetPanel(type = "tabs",
                                                   tabPanel("Visual Timetable", plotOutput("timetable_3_graph")),
                                                   tabPanel("More detailed Timetable", tableOutput("timetable_3"))), 
                                       style='width: 100%'))))
