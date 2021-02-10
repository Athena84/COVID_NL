
library(tidyverse)

#==========Load & prepare dataset
#Load dataset, select relevant columns
raw_df <- read.csv("./Data/Raw/Covid-19_gedrag.csv", stringsAsFactors = FALSE, header = TRUE, sep=";") %>%
  select(., c(2, 5:10, 12))

#Translate and shorten field names
colnames(raw_df) = c("Date", "Region", "Subgroup_category", "Subgroup", "Response_category", "Response", "Sample_size", "Value")

#Translate Subgroup categories and subgroups
raw_df$Subgroup_category <- gsub("Leeftijd", "Age", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup_category <- gsub("Geslacht", "Gender", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup_category <- gsub("Opleidng", "Education", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup <- gsub("Man", "Male", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Vrouw", "Female", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Hoog", "Higher", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Midden", "Middle", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Laag", "Lower", raw_df$Subgroup, fixed = TRUE)

#Remove total rows
raw_df <-  filter(raw_df, !(Region == "Nederland" & Subgroup_category == "Alle"))

#Combine region as a subgroup similar to structure of age/gender/education
raw_df$Subgroup_category <- ifelse(raw_df$Subgroup_category == "Alle", "Region", raw_df$Subgroup_category)
raw_df$Subgroup <- ifelse(raw_df$Subgroup == "Totaal", raw_df$Region, raw_df$Subgroup)
#Remove redundant region column
raw_df <- select(raw_df, c("Date", "Subgroup_category", "Subgroup", "Response_category", "Response", "Sample_size", "Value"))


#==========Store subset regarding vaccination
#Filter response category
vacc_will_subset <- filter(raw_df, Response_category == "Vaccinatiebereidheid")

#Translate responses
vacc_will_subset$Response <- gsub("Ja", "Willing", vacc_will_subset$Response, fixed = TRUE)
vacc_will_subset$Response <- gsub("Nee", "Not willing", vacc_will_subset$Response, fixed = TRUE)
vacc_will_subset$Response <- gsub("Weet_niet", "Not yet decided", vacc_will_subset$Response, fixed = TRUE)
vacc_will_subset$Response <- gsub("Al_gevaccineerd", "Already vaccinated", vacc_will_subset$Response, fixed = TRUE)

#Re-order responses
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))

#Re-size willing to include those already vaccinated
#Otherwise sum >100%, assumption: this question was added later and isn't included in the scaling of size to percentage (yet)
vacc_will_corrections <- filter(vacc_will_subset, Response == "Already vaccinated") %>%
  group_by(., Date, Subgroup) %>%
  summarise(., "Correction" = Value) 

vacc_will_subset <- left_join(vacc_will_subset, vacc_will_corrections, by = c("Date", "Subgroup")) %>%
  mutate(., Value = Value - ifelse(Response == "Willing", Correction, 0)) %>%
  select(.,c("Date", "Subgroup_category", "Subgroup", "Response_category", "Response", "Sample_size", "Value"))


#==========Store subset regarding measures
#Filter response category
meas_subset <- filter(raw_df, Response_category %in% c("Draagvlak", "Naaste_omgeving", "Helpen_regels", "Moeite", "Naleving"))

#Remove some measures with insufficient data or not so interesting outcomes
meas_subset <- filter(meas_subset, !(Response %in% c("Avondklok", "Hoest_niest_in_elleboog")))

#Translate categories and responses
meas_subset$Response_category <- gsub("Draagvlak", "Support", meas_subset$Response_category, fixed = TRUE)
meas_subset$Response_category <- gsub("Naaste_omgeving", "Adherence_observed", meas_subset$Response_category, fixed = TRUE)
meas_subset$Response_category <- gsub("Helpen_regels", "Belief_efficacy", meas_subset$Response_category, fixed = TRUE)
meas_subset$Response_category <- gsub("Moeite", "Difficulty", meas_subset$Response_category, fixed = TRUE)
meas_subset$Response_category <- gsub("Naleving", "Adherence_self", meas_subset$Response_category, fixed = TRUE)
meas_subset$Response <- gsub("Bij_klachten_blijf_thuis", "Symptoms_quarantine", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Bij_klachten_laat_testen", "Symptoms_test", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Draag_mondkapje_in_ov", "Mask_public_transport", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Draag_mondkapje_in_publieke_binnenruimte", "Mask_public_spaces", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Houd_1_5m_afstand", "Social_distancing", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Ontvang_max_bezoekers_thuis", "Max_guests_@home", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Vermijd_drukke_plekken", "Avoid_crowds", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Was_vaak_je_handen", "Wash_hands_frequently", meas_subset$Response, fixed = TRUE)
meas_subset$Response <- gsub("Werkt_thuis", "Work_@home", meas_subset$Response, fixed = TRUE)


#==========Write to smaller files
write.csv(meas_subset, "./Data/measures_att.csv", row.names = FALSE)
write.csv(vacc_will_subset, "./Data/vacc_will.csv", row.names = FALSE)



