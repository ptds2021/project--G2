<!-- badges: start -->
[![R-CMD-check](https://github.com/ptds2021/pkgtest/workflows/R-CMD-check/badge.svg)](https://github.com/ptds2021/pkgtest/actions)
<!-- badges: end -->

# `hectimetables`

## Description

`hectimetables` is an R package aiming at creating possible timetables for Business Analytics track of the Master in Management of the University of Lausanne (HEC), for the year 2020-2022. 

## Features

The end production is a shinyApp, which can be access on R by running `hectimetables::runDemo()` or online, hosted on the shinyapps.io website  (https://lauralopriore1997.shinyapps.io/project--G2/). 

Available to the interest user are a set of functions used in the ShinyApp: 

1) `dummy_creation()`: a function to create a matrix of constraints used to perform a binary optimization of classes to select or not, on how many core and elective credits he/she wants to do, as well as some half-days moment he/she does not want any class (Monday to Friday, AM or PM)

2) `class_optim()`: a function that takes the preferences of the user in the ShinyApp and makes it possible with the matrix of constraints

3) `display_text_timetable()` and `display_visual_timetable()`: two functions to generate some nice table as well as a visual containing which classes to take
