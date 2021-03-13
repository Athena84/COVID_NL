

#Libraries for the app
library(shiny)
library(ggplot2) #for plotting
library(dplyr) #for last steps data sorting
library(sf) #for maps
library(shinythemes)
library(RColorBrewer) #for gradient chart colours
library(rsconnect) #for publishing
#rsconnect::deployApp('https://athena84.shinyapps.io/COVID_NL/')

#Load datasets (pre-processing of raw data in datacleaner.R)
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))
meas_subset <- read.csv("./Data/measures_sup.csv", stringsAsFactors = FALSE, header = TRUE)
att_subset <- read.csv("./Data/measures_att.csv", stringsAsFactors = FALSE, header = TRUE)
#region_data_lists <- read.csv("./Data/region_data_lists.csv", stringsAsFactors = FALSE, header = TRUE)  #Was used for adding top-3 and bottom-3 regions but with small differences not too instructive
region_data_charts <- st_read("./Data/region_data_charts.shp", stringsAsFactors = FALSE)
