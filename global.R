
#Libraries for the app
library(shiny)
library(ggplot2) #for plotting
library(dplyr) #for last steps data sorting
library(sf) #for maps
library(shinythemes)
library(RColorBrewer) #for gradient chart colours
library(rsconnect) #for publishing

#Load datasets (pre-processing of raw data in datacleaner.R)
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))
meas_subset <- read.csv("./Data/measures_sup.csv", stringsAsFactors = FALSE, header = TRUE)
att_subset <- read.csv("./Data/measures_att.csv", stringsAsFactors = FALSE, header = TRUE)
region_data_charts <- st_read("./Data/region_data_charts.shp", stringsAsFactors = FALSE)
