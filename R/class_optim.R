#' @title Integer optimization of timetable
#' @name class_optim
#' @description This function is used to perform the integer optimization using lpSolve::lp. 
#' 
#' 
#' 
#' 
#' For more information, please refer to the lpSolve package in R. 
#' @author Group 2 composed of Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Final choice of classes of user (binary vector)
#' @param s Semester to be considered (numerical)
#' @param f.obj Objective function (to be minimized)
#' @param f.con Constraints matrix
#' @param f.dir Sign of equality of constraints (">=", "<=", ...) (numerical vectors)
#' @param core Core credits chosen by the user by semester (numerical value)
#' @param elective Elective credits chosen by the user (numerical value)
#' @param moment Moments chosen by the user (binary vector)
#' @param class Classes chosen by the user (binary vector)
#' @import dplyr
#' @importFrom lpSolve lp
#' @import tidyverse
#' @import shiny
#' @export
class_optim = function(s, f.obj, f.con, f.dir, 
                       core, elective, moment, class){
  
  for (i in 1:length(moments_semester[[s]])) {
    moments_constraints[[s]][i] <- moments_semester[[s]][i] %in% reactive(moment)()}
  
  for (i in 1:length(classes_semester[[s]])) {
    classes_constraints[[s]][i] <- classes_semester[[s]][i] %in% reactive(class)()}

  f.rhs <- c(
    ##reactive(credits)(),                  # Credits constraint
    reactive(core)(),                     # CORE Credits constraint
    reactive(elective)(),                 # ELECTIVE Credits constraint
    length(classes_constraints[[s]])*moments_constraints[[s]], # Chunk of the day constraints
    rep.int(1, nb_of_timeslot[[s]]),      # Time constraints
    classes_constraints[[s]])            # Classes constraints

  choice <- cbind(
    as.numeric(lp("min",
                  f.obj[[s]],
                  f.con[[s]],
                  f.dir[[s]],
                  f.rhs,
                  all.bin = TRUE,
                  presolve = 1)$solution),
    colnames(HEC_dummies_BA[[s]])) %>%
    as.data.frame() %>%
    mutate(Choice = V1, Class = V2)

  return(choice)
}
