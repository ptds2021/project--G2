#' @title Creation of dummies variables and others variables
#' @name class_optim
#' @description This function is used to perform the integer optimization.
#' It can be used within the ShinyApp settings.
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Final choice of classes of user
#' @param s Semester to be considered (from 1 to 3)
#' @param f.obj Objective function
#' @param f.con Constraints matrix
#' @param f.dir Sign of equality of constraints
#' @param core Core credits chosen by the user#' 
#' @param elective Elective credits chosen by the user
#' @param moment Moments chosen by the user
#' @param class Moments chosen by the user
#' @import dplyr
#' @importFrom lpSolve lp
#' @import tidyverse
#' @import shiny
#' @export
class_optim = function(s, f.obj, f.con, f.dir, 
                       ##credits, 
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
