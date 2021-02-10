
library(tidyverse)

#This file is to play around with plots before changing the Shiny app

#Load cleaned datasets
vacc_will_subset <- read.csv("./Data/vacc_will.csv", stringsAsFactors = FALSE, header = TRUE)
meas_subset <- read.csv("./Data/measures_att.csv", stringsAsFactors = FALSE, header = TRUE)
  
#Plots
vacc_will_agecoh_plot <- filter(vacc_will_subset, Subgroup_category == "Age") %>%
  ggplot(data = ., ) +
  geom_bar(aes(x = Date, y = Value, fill = Response), stat = "identity", position = "stack") +
  facet_wrap(facets = vars(Subgroup)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#E7B900"))

vacc_will_geo_plot <- filter(vacc_will_subset, Subgroup_category == "Region") %>%
  ggplot(data = ., ) +
  geom_bar(aes(x = Date, y = Value, fill = Response), stat = "identity", position = "stack") +
  facet_wrap(facets = vars(Subgroup)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#E7B900"))

vacc_will_edu_plot <- filter(vacc_will_subset, Subgroup_category == "Education") %>%
  ggplot(data = ., ) +
  geom_bar(aes(x = Date, y = Value, fill = Response), stat = "identity", position = "stack") +
  facet_wrap(facets = vars(Subgroup)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#E7B900"))

vacc_will_gender_plot <- filter(vacc_will_subset, Subgroup_category == "Gender") %>%
  ggplot(data = ., ) +
  geom_bar(aes(x = Date, y = Value, fill = Response), stat = "identity", position = "stack") +
  facet_wrap(facets = vars(Subgroup)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#E7B900"))

meas_sup_byage <- filter(meas_subset, (Response_category == "Support" & Subgroup_category == "Age")) %>%
  ggplot(data = ., aes(x = Date, y = Value, group = Response, colour = Response)) +
  geom_line() +
  facet_wrap(facets = vars(Subgroup)) +
  ylim(0,100)

meas_sup_agecoh_bymeasure <- filter(meas_subset, (Response_category == "Support" & Subgroup_category == "Age")) %>%
  ggplot(data = ., aes(x = Date, y = Value, group = Subgroup, colour = Subgroup)) +
  geom_line() +
  facet_wrap(facets = vars(Response)) +
  ylim(0,100)

meas_adh_byage <- filter(meas_subset, (Response_category == "Support" & Subgroup_category == "Age")) %>%
  ggplot(data = ., aes(x = Date, y = Value, group = Response, colour = Response)) +
  geom_line() +
  facet_wrap(facets = vars(Subgroup)) +
  ylim(0,100)

meas_adh_agecoh_bymeasure <- filter(meas_subset, (Response_category == "Support" & Subgroup_category == "Age")) %>%
  ggplot(data = ., aes(x = Date, y = Value, group = Subgroup, colour = Subgroup)) +
  geom_line() +
  facet_wrap(facets = vars(Response)) +
  ylim(0,100)

visit_behavior_byage <- filter(meas_subset, (Response == "Max_guests_@home" & Subgroup_category == "Age")) %>%
  ggplot(data = ., aes(x = Date, y = Value, group = Response_category, colour = Response_category)) +
  geom_line() +
  facet_wrap(facets = vars(Subgroup)) +
  ylim(0,100)


print(vacc_will_agecoh_plot)
print(vacc_will_geo_plot)
print(vacc_will_edu_plot)
print(vacc_will_gender_plot)
print(meas_sup_byage)
print(meas_sup_agecoh_bymeasure)
print(meas_adh_byage)
print(meas_adh_agecoh_bymeasure)
print(visit_behavior_byage)

