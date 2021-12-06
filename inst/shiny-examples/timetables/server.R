server <- function(input, output, session) {
  
  choice_1 <- eventReactive(input$submit_1,  {
    hectimetables::class_optim(1, f.obj, f.con, f.dir,
                               input$credits_1, 
                               input$CORE_credits_1,
                               input$ELECTIVE_credits_1, 
                               input$Moments_1, 
                               input$Classes_1)})
  
  output$timetable_1 <- renderTable({hectimetables::display_text_timetable(1, choice_1() )})
  output$timetable_1_graph <- renderPlot({hectimetables::display_visual_timetable(1, choice_1() )})
  
  choice_2 <- eventReactive(input$submit_2, {
    hectimetables::class_optim(2, f.obj, f.con, f.dir,
                               input$credits_2, 
                               input$CORE_credits_2,
                               input$ELECTIVE_credits_2, 
                               input$Moments_2, 
                               input$Classes_2)})
  
  output$timetable_2 <- renderTable({hectimetables::display_text_timetable(2, choice_2() )})
  output$timetable_2_graph <- renderPlot({hectimetables::display_visual_timetable(2, choice_2() )})
  
  choice_3 <- eventReactive(input$submit_3, {
    hectimetables::class_optim(3, f.obj, f.con, f.dir,
                               input$credits_3, 
                               input$CORE_credits_3, 
                               input$ELECTIVE_credits_3, 
                               input$Moments_3, 
                               input$Classes_3)})
  
  output$timetable_3 <- renderTable({hectimetables::display_text_timetable(3, choice_3() )})
  output$timetable_3_graph <- renderPlot({hectimetables::display_visual_timetable(3, choice_3() )})
  
}
