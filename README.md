<!-- badges: start -->
[![R-CMD-check](https://github.com/ptds2021/pkgtest/workflows/R-CMD-check/badge.svg)](https://github.com/ptds2021/pkgtest/actions)
<!-- badges: end -->

# `hectimetables`

## Description

`hectimetables` is an R package aiming at creating possible timetables for students in the Business Analytics  track of the Master in Management of the University of Lausanne (HEC), for the year 2020-2022. 

## Features

The end product is a shinyApp, which can be access on R by running `hectimetables::runDemo()` or online, hosted on the shinyapps.io website  (https://lauralopriore1997.shinyapps.io/project--G2/). 

Available to the interest user are a set of functions used in the ShinyApp:

1) `dummy_creation()`: a function to create a matrix of constraints used to perform an integer optimization of classes, which is used in `class_optim()`

2) `class_optim()`: a function that takes the preferences of the user in the ShinyApp (how many core and elective credits a student wants to do, as well as some half-days moment he/she does not want any class (Monday to Friday, AM or PM) and suggest classes that would satisfy the matrix of constraints created with `dummy_creation()`

3) `display_text_timetable()` and `display_visual_timetable()`: two functions to generate a nice table as well as a visual representation of classes to take

## Why we like it

As former BA students at HEC Lausanne, we struggled every semester to create a suitable timetable which would satisfy all constraints and preferences. Here, as part of a Programming class, we coded a possible solution to our problem with a ShinyApp. We made it available so other students could benefit from it.