
#Libraries for the app
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)

#Load datasets (pre-processing of raw data in datacleaner.R)
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
meas_subset <- read.csv("./Data/measures_att.csv", stringsAsFactors = FALSE, header = TRUE)

