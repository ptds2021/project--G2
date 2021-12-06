#' @export
#' @description
#' This function shows how to use our beautiful package.
runDemo <- function() {
  appDir <- system.file("shiny-examples", "timetables", package = "hectimetables")
  if (appDir == "") {
    stop(
      "Could not find example directory. Try re-installing timetables.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")

}
