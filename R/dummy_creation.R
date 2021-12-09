#' @title Creation of dummies variables and others variables
#' @name dummy_creation
#' @description This function is used to generate necessary dummy variables.
#' It can be used to optimise the timetable schedule of HEC students.
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Returns many variables in the Global Environement
#' @importFrom chron times
#' @importFrom fastDummies dummy_cols
#' @importFrom here here
#' @importFrom readxl read_excel
#' @importFrom tidyr pivot_longer
#' @import rlang
#' @import dplyr
#' @import tidyverse
#' @export

dummy_creation = function() {

  # Create list to store necessary variables
  part_1 <- list()
  part_2 <- list()
  raw_input <- list()
  nice_input <- list()
  HEC_dummies_BA <- list()
  unique <- list()
  constraints <- list()
  classes_semester <- list()
  classes_constraints <- list()
  classes_mandatory <- list()
  moments_semester <- list()
  moments_constraints <- list()
  nb_of_moment <- list()
  nb_of_timeslot <- list()
  nb_of_class <- list()
  f.con <- list()  # Set matrix corresponding to coefficients of constraints
  f.obj <- list()  # Set coefficients of the objective function (min total credits)
  f.dir <- list()  # Set unequality/equality signs

  # Loop over the 3 semesters
  for (i in 1:3) {
    # Replication with 55 times the hours slots for the first and last 7 weeks
    weeks <- rep(1,  55)
    # Replication 5 times all the hours slots from 8 to 19
    hours_of_day <- rep(9:19, 5)
    # Replicate 11 times Monday (1), Tuesday, Wednesday, Thursday and Friday (5)
    days_of_week <-
      c(rep(1, 11), rep(2, 11), rep(3, 11), rep(4, 11), rep(5, 11))

    # Create a list with all conditions for hours, day and first/last weeks
    cols_to_make_first <- rlang::parse_exprs(paste0(
      'ifelse(First ==', weeks,
        '& End >=', hours_of_day,
        '& Start <', hours_of_day,
        '& Day ==', days_of_week,',1,0)'))

    cols_to_make_last <- rlang::parse_exprs(paste0(
      'ifelse(Last ==', weeks,
        '& End >=', hours_of_day,
        '& Start <', hours_of_day,
        '& Day ==',days_of_week, ',1,0)'))
    
    df <-  read_excel(here::here("inst/raw-data/Timetable_Master_Management.xlsx")) %>%
      dplyr::mutate(
        Start_nice = as.character(Start_nice), 
        End_nice = as.character(End_nice), 
        Start_nice = chron::times(gsub("1899-12-31 ", "", Start_nice)),
        End_nice = chron::times(gsub("1899-12-31 ", "", End_nice)),
        Day = dplyr::recode_factor(Day,
          "Monday" = 1,
          "Tuesday" = 2,
          "Wednesday" = 3,
          "Thursday" = 4,
          "Friday" = 5),
        First = First_7_Weeks,
        Last = Last_7_Weeks,
        MANDATORY = BA_Mandatory,
        CORE = BA_orientation,
        CORE_credits = CORE * Credits,
        ELECTIVE = ifelse(CORE == 1, 0, 1),
        ELECTIVE_credits = ELECTIVE * Credits,
        Moment = as.factor(paste0(Day, "_",
                    as.factor(ifelse(End <= 12, "AM", "PM"))))) %>%
      filter(Semester == i) %>%
      select(-BA_orientation,
             -BA_Mandatory,-Semester,
             -Last_7_Weeks,
             -First_7_Weeks)

    raw_input[[i]] <- df

    df <- raw_input[[i]] %>%
      group_by(Class) %>%
      filter(MANDATORY == 1) %>%
      select(Class) %>% unique() %>% unlist()

    # Create vector of all mandatory classes (to be pre-ticked in Shiny)
    classes_mandatory[[i]] <- df

    # Remove mandatory for constraints
    df <- raw_input[[i]] %>% select(-MANDATORY)
    raw_input[[i]] <- df

    # Create dummy for first seven weeks
    df_1 <- raw_input[[i]] %>%
      rowwise(.) %>%
      mutate(!!!cols_to_make_first)  %>%
      ungroup %>%
      pivot_longer(cols = starts_with("ifelse(F"))
    part_1[[i]] <- df_1

    # Create dummy for last seven weeks
    df_2 <- raw_input[[i]] %>%
      rowwise(.) %>%
      mutate(!!!cols_to_make_last)  %>%
      ungroup %>%
      pivot_longer(cols = starts_with("ifelse(L"))
    part_2[[i]] <- df_2

    # Combine dummy for first and last seven weeks
    df <-  rbind(part_1[[i]], part_2[[i]]) %>%
      filter(value > 0) %>%
      select(-value) %>%
      fastDummies::dummy_cols(., c("Moment", "name")) %>%
      select(
        -Moment,
        -Start_nice,
        -End_nice,
        -Moment,
        -name,-Start,
        -End,
        -Day,
        -CORE,
        -Professor,
        -Last,
        -First,
        -ELECTIVE)

    HEC_dummies_BA[[i]] <- df

    unique[[i]] <- HEC_dummies_BA[[i]]$Class

    HEC_dummies_BA[[i]] <- HEC_dummies_BA[[i]] %>%
      fastDummies::dummy_cols(., c("Class")) %>%
      select(-Class) %>% t() %>% as.data.frame()

    colnames(HEC_dummies_BA[[i]]) <- unique[[i]]

    const <- row.names(HEC_dummies_BA[[i]])

    constraints[[i]] <-  const

    # Keep only one value over all "classes"
    HEC_dummies_BA[[i]] <- data.frame(sapply(split(
      1:ncol(HEC_dummies_BA[[i]]), colnames(HEC_dummies_BA[[i]])),
          function(j) do.call(pmax, HEC_dummies_BA[[i]][j])))

    row.names(HEC_dummies_BA[[i]]) <- constraints[[i]]

    colnames(HEC_dummies_BA[[i]]) <-
      row.names(HEC_dummies_BA[[i]] %>%
        filter(grepl("Class_", rownames(HEC_dummies_BA[[i]]))))

    colnames(HEC_dummies_BA[[i]]) <-
      gsub("Class_", "", colnames(HEC_dummies_BA[[i]]))

    classes_semester[[i]] <- colnames(HEC_dummies_BA[[i]])
    classes_constraints[[i]] <- vector(length = length(classes_semester[[i]]))

    moments_semester[[i]] <- levels(raw_input[[i]]$Moment)
    moments_semester[[i]] <- sub("1_", "Monday ", moments_semester[[i]])
    moments_semester[[i]] <- sub("2_", "Tuesday ", moments_semester[[i]])
    moments_semester[[i]] <- sub("3_", "Wednesday ", moments_semester[[i]])
    moments_semester[[i]] <- sub("4_", "Thursday ", moments_semester[[i]])
    moments_semester[[i]] <- sub("5_", "Friday ", moments_semester[[i]])
    moments_constraints[[i]] <- vector(length = length(moments_semester[[i]]))

    # Define the number of moments in a week
    nb_of_moment[[i]] <- length(row.names(HEC_dummies_BA[[i]] %>%
        filter(grepl("AM|PM", rownames(HEC_dummies_BA[[i]])))))

    # Define the number of time slots
    nb_of_timeslot[[i]] <- dim(HEC_dummies_BA[[i]] %>%
        filter(grepl("name", rownames(HEC_dummies_BA[[i]]))))[1]

    # Define nb of classes per semester
    nb_of_class[[i]] <- ncol(HEC_dummies_BA[[i]])

    # Set the constraints equals to the dummies
    f.con[[i]] <- HEC_dummies_BA[[i]]

    # Define the objective (here: min total credits)
    f.obj[[i]] <- HEC_dummies_BA[[i]][1,] %>% unname() %>% unlist()

    # Set the direction signs of the constraints matrix
    f.dir[[i]] <- c(
      ">=", # Credits constraint
      ">=", # CORE Credits constraint
      ">=", # ELECTIVE Credits constraint
      rep("<=", nb_of_moment[[i]]), # Chunk of the day
      rep.int("<=", nb_of_timeslot[[i]]), # Time constraints
      rep(">=", nb_of_class[[i]]))

    # Prepare a nice format of the data (hence called nice)
    nice_input[[i]] <- raw_input[[i]]%>%
      mutate(
        Start = as.character(Start_nice),
        End = as.character(End_nice),
        Day = recode_factor(Day,
                            `1` = "Monday",
                            `2` = "Tuesday",
                            `3` = "Wednesday",
                            `4` = "Thursday",
                            `5` = "Friday"),
        Core = recode(CORE,
                      `1` = "Yes",
                      `0` = "No")
      )  %>%
      select(Day, Start, End, Class, Credits, Professor, Core) %>%
      arrange(Day, Start)

    # Assign variables to the GlobalEnv
    assign("unique", unique, .GlobalEnv)
    assign("raw_input", raw_input, .GlobalEnv)
    assign("nice_input", nice_input, .GlobalEnv)
    assign("moments_semester", moments_semester, .GlobalEnv)
    assign("moments_constraints", moments_constraints, .GlobalEnv)
    assign("HEC_dummies_BA", HEC_dummies_BA, .GlobalEnv)
    assign("constraints", constraints, .GlobalEnv)
    assign("classes_semester", classes_semester, .GlobalEnv)
    assign("classes_mandatory", classes_mandatory, .GlobalEnv)
    assign("classes_constraints", classes_constraints, .GlobalEnv)
    assign("nb_of_moment", nb_of_moment, .GlobalEnv)
    assign("nb_of_timeslot", nb_of_timeslot, .GlobalEnv)
    assign("nb_of_class", nb_of_class, .GlobalEnv)
    assign("f.con", f.con, .GlobalEnv)
    assign("f.obj", f.obj, .GlobalEnv)
    assign("f.dir", f.dir, .GlobalEnv)
  }
}
