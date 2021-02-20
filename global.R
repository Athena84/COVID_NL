
#Libraries for the app
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)
library(sf)

#Load datasets (pre-processing of raw data in datacleaner.R)
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))
meas_subset <- read.csv("./Data/measures_sup.csv", stringsAsFactors = FALSE, header = TRUE)
region_data <- st_read("./Data/region_data.shp", stringsAsFactors = FALSE)
