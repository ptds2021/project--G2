#' @title Creation of dummies variables and others variables
#' @name class_optim
#' @description This function is used to perform the integer optimization.
#' It can be used within the ShinyApp settings.
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Final choice of classes of user
#' @param i Semester to be considered (from 1 to 3)
#' @param f.obj Objective function
#' @param f.con Constraints matrix
#' @param f.dir Sign of equality of constraints
#' @param f.rhs Right hand side of constraints
#' @import dplyr
#' @importFrom lpSolve lp
#' @import tidyverse
#' @import shiny
#' @export
class_optim = function(i, f.obj, f.con, f.dir, f.rhs){

  choice <- cbind(
    as.numeric(lp("min",
                  f.obj[[i]],
                  f.con[[i]],
                  f.dir[[i]],
                  f.rhs,
                  all.bin = TRUE,
                  presolve = 1)$solution),
    colnames(HEC_dummies_BA[[i]])) %>%
    as.data.frame() %>%
    mutate(Choice = V1, Class = V2)

  return(choice)
}
