#' @title Demonstration of shiny app
#' @name runDemo
#' @description This function is used to demostrate how the shiny app works. 
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Open the app for Master BA students in 2020-2022
#' @import shiny
#' @export
runDemo <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "hectimetables")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `hectimetables`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}