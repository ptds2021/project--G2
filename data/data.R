library(dplyr)

timetableHEC_2021_2022 <- read_excel("inst/extdata/Timetable_Master_Management.xlsx")

save(timetableHEC_2021_2022, file = "data/timetableHEC_2021_2022.rda")