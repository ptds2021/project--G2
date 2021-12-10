# `hectimetables`

## Description
`hectimetables` is an R package containing data set of classes of Business Analytics track of the Master in Management of the University of Lausanne (HEC), for the year 2020-2022. 

## Features
A shinyApp is constructed for this aim, which is available by simply loading the package `hectimetables` and running `hectimetables::runDemo()`. 

Available to the interest user are a set of functions used in the ShinyApp: 
1) `dummy_creation()`: a function to create a matrix of constraints used to perform a binary optimisation of classes to select or not, depending on how many total credits the student aim to pass in a given semester, how many core and elective credits he/she wants, as well as some half-days moment he/she does not want any class (Monday to Friday, AM or PM)
2) `class_optim()`: a function that takes the preferences of the user in the ShinyApp and makes it possible with the matrix of constraints
3) `display_text_timetable` and `display_visual_timetable`: two functions to generate some nice table or visual containing which classes to take
