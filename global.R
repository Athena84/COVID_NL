
#Libraries for the app
library(shiny)
library(ggplot2)
library(dplyr)
library(viridisLite)
library(sf)
library(RColorBrewer)

#Load datasets (pre-processing of raw data in datacleaner.R)
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))
meas_subset <- read.csv("./Data/measures_sup.csv", stringsAsFactors = FALSE, header = TRUE)
region_data_lists <- read.csv("./Data/region_data_lists.csv", stringsAsFactors = FALSE, header = TRUE)
region_data_charts <- st_read("./Data/region_data_charts.shp", stringsAsFactors = FALSE)
