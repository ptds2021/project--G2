#' Classes offered for BA students at HEC Lausanne, in the year 2020-2022
#'
#' @format A data frame with 98 rows and 13 variables:
#' \describe{
#'   \item{Semester}{First, second or third semester of Master}
#'   \item{Day}{Day the classes takes place}
#'   \item{Class}{Name of the class}
#'   \item{Professor}{Professor in charge of the class}
#'   \item{Credits}{ECTS credits of the class}
#'   \item{First_7_Weeks}{Dummy if the class takes place during the first seven weeks of the semester}
#'   \item{Last_7_Weeks}{Dummy if the class takes place during the last seven weeks of the semester}
#'   \item{Start}{Time (in decimal) when the class starts}
#'   \item{End}{Time (in decimal) when the class ends}
#'   \item{Start_nice}{Time (in POSIXct) when the classes starts}
#'   \item{End_nice}{Time (in POSIXct) when the classes ends}
#'   \item{BA_orientation}{Dummy if the class belongs to the BA track}
#'   \item{BA_Mandatory}{Dummy if the class is mandatory for BA students}
#' }
#' @source \url{https://hecnet.unil.ch/hec/timetables/index_html}
#' @import dplyr
#' @importFrom readxl read_excel

sysdata <- readxl::read_excel(here::here("raw-data/Timetable_Master_Management.xlsx"))

save(sysdata, file = "sysdata.rda")