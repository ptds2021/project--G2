#############################################
## The following loads the needed packages ##
#############################################

# load the required packages
packages <- c(# general
  "base", "methods", "utils", "grDevices", "here", "tidyr",
  "gdata", "graphics", "stats", "lubridate", "dplyr", "ggplot2",
  "knitr",  # report
  "tinytex", # latex equations
  "ganttrify"
)
purrr::walk(packages, library, character.only = TRUE)
