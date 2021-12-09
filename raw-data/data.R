library(dplyr)
library(readxl)

HEC_timtables_2020_2022 <- read_excel(file = "Timetable_Master_Management.xlsx")

save(HEC_timtables_2020_2022, file = "HEC_timtables_2020_2022.rda")