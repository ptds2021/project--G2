#' @export
runExample <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "hectimetables")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `hectimetables`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}