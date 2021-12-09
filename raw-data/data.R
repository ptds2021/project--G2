library(dplyr)
library()

sysdata <- readxl::read_excel(here::here("raw-data/Timetable_Master_Management.xlsx"))

save(sysdata, file = "sysdata.rda")