library(tidyverse)
library(sf)

#==========Load & prepare dataset
#Load dataset, select relevant columns, encoding needs specification because of some special characters in Frysian names
raw_df <- read.csv("./RawData/Covid-19_gedrag.csv", stringsAsFactors = FALSE, header = TRUE, sep=";", encoding = "UTF-8") %>%
  select(., c(2, 4:9, 12))

#Translate and shorten field names
colnames(raw_df) = c("Date", "Region_code", "Region", "Subgroup_category", "Subgroup", "Response_category", "Response", "Value")

#Translate Subgroups and responses
raw_df$Subgroup_category <- gsub("Leeftijd", "Age", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup_category <- gsub("Geslacht", "Gender", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup_category <- gsub("Opleiding", "Education level", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup_category <- gsub("Alle", "All", raw_df$Subgroup_category, fixed = TRUE)
raw_df$Subgroup <- gsub("16-24", "Aged 16-24", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("25-39", "Aged 25-39", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("40-54", "Aged 40-54", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("55-69", "Aged 55-69", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("70+", "Aged 70+", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Man", "Male", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Vrouw", "Female", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Hoog", "Higher education", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Midden", "Middle education", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Laag", "Lower education", raw_df$Subgroup, fixed = TRUE)
raw_df$Subgroup <- gsub("Totaal", "Total population", raw_df$Subgroup, fixed = TRUE)
raw_df$Response_category <- gsub("Draagvlak", "Support", raw_df$Response_category, fixed = TRUE)
raw_df$Response_category <- gsub("Naaste_omgeving", "Adherence_observed", raw_df$Response_category, fixed = TRUE)
raw_df$Response_category <- gsub("Helpen_regels", "Belief_efficacy", raw_df$Response_category, fixed = TRUE)
raw_df$Response_category <- gsub("Moeite", "Difficulty", raw_df$Response_category, fixed = TRUE)
raw_df$Response_category <- gsub("Naleving", "Adherence_self", raw_df$Response_category, fixed = TRUE)
raw_df$Response_category <- gsub("Vaccinatiebereidheid", "Willingness_vaccination", raw_df$Response_category, fixed = TRUE)
raw_df$Response <- gsub("Avondklok", "Curfew", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Bij_klachten_blijf_thuis", "Symptoms_quarantine", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Bij_klachten_laat_testen", "Symptoms_test", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Draag_mondkapje_in_ov", "Mask_public_transport", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Draag_mondkapje_in_publieke_binnenruimtes", "Mask_public_spaces", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Houd_1_5m_afstand", "Social_distancing", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Ontvang_max_bezoekers_thuis", "Max_guests_@home", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Vermijd_drukke_plekken", "Avoid_crowds", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Was_vaak_je_handen", "Wash_hands_frequently", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Werkt_thuis", "Work_@home", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Ja", "Willing", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Nee", "Not willing", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Weet_niet", "Not yet decided", raw_df$Response, fixed = TRUE)
raw_df$Response <- gsub("Al_gevaccineerd", "Already vaccinated", raw_df$Response, fixed = TRUE)


#Remove some measures with insufficient data or not so interesting outcomes
raw_df <- filter(raw_df, !(Response %in% c("Hoest_niest_in_elleboog", "Thuisgewerkte_uren", "Wash_hands_frequently", "Mask_public_transport", "Symptoms_quarantine",  "Symptoms_test", "Avoid_crowds")))

#Combine region as a subgroup similar to structure of age/gender/education
raw_df$Subgroup_category <- ifelse((raw_df$Subgroup_category == "All" & raw_df$Region != "Nederland"), "Region", raw_df$Subgroup_category)
raw_df$Subgroup <- ifelse((raw_df$Subgroup == "Total population" & raw_df$Region != "Nederland"), raw_df$Region, raw_df$Subgroup)

#Remove redundant region column
raw_df <- select(raw_df, c("Date", "Region_code", "Subgroup_category", "Subgroup", "Response_category", "Response", "Value"))


#==========Store separate subset regarding attitudes towards measures

#Filter out vaccination (as only support attitude known) and filter interesting response categories
#Remove region as subgroup and column
#On purpose leaving in the overall total row
meas_att_subset <- filter(raw_df, Response != "Willing") %>%
  filter(., (Response_category == "Support" | Response_category == "Adherence_observed" | Response_category == "Adherence_self")) %>%
  filter(., Subgroup_category != "Region") %>%
  select(., c("Date", "Subgroup_category", "Subgroup", Attitude = "Response_category", Measure = "Response", "Value"))


#==========Store separate subset regarding support for measures only

#Filter response category
meas_supp_subset <- filter(raw_df, Response_category == "Support")

#Add vaccination as measure under the support category, with value equal to those willing to take vaccination
meas_supp_subset <- filter(raw_df, Response == "Willing") %>%
  mutate(., Response = "Vaccination") %>%
  rbind(meas_supp_subset, .)

#Remove redundant response category column
meas_supp_subset <- select(meas_supp_subset, c("Date", "Region_code", "Subgroup_category", "Subgroup", "Response", "Value"))


#==========Store subset regarding vaccination
#Filter response category
vacc_will_subset <- filter(raw_df, Response_category == "Willingness_vaccination")

#Re-order responses
vacc_will_subset$Response <- factor(vacc_will_subset$Response, levels = c("Not willing", "Not yet decided", "Willing", "Already vaccinated"))

#Re-size willing to exclude those already vaccinated
#Otherwise sum >100%, assumption: this question was added later and isn't included in the scaling of size to percentage (yet)
vacc_will_corrections <- filter(vacc_will_subset, Response == "Already vaccinated") %>%
  group_by(., Date, Subgroup) %>%
  summarise(., "Correction" = Value) 

vacc_will_subset <- left_join(vacc_will_subset, vacc_will_corrections, by = c("Date", "Subgroup")) %>%
  mutate(., Value = Value - ifelse(Response == "Willing", Correction, 0)) %>%
  select(., c("Date", "Region_code", "Subgroup_category", "Subgroup", "Response", "Value")) %>%
  filter(., Value != 0)

#Remove region as subgroup and column
vacc_will_subset <- filter(vacc_will_subset, Subgroup_category != "Region") %>%
  select(.,c("Date", "Subgroup_category", "Subgroup", "Response", "Value"))


#==========Load map data and match to dataset regions
#Load mapping data municipalities to security regions, encoding needs specification because of some special characters in Frysian names
municipality_reg_mapping <- read.csv("./RawData/Gebieden_in_Nederland_2018.csv", stringsAsFactors = FALSE, header = TRUE, sep = ";", encoding = "UTF-8") %>%
  select(., c(1, 4, 5))

colnames(municipality_reg_mapping) <- c("Municipality", "Region_code", "Region")

#Removing "(...)" additions that disturb mapping except for "Bergen" of which 2 exist
municipality_reg_mapping$Municipality <- municipality_reg_mapping$Municipality %>%
  sapply(., function(x) ifelse(grepl("Bergen", x,  fixed = TRUE), x , gsub("([A-Z][a-z]*)\\s\\(.*\\)", "\\1", x))) %>%
  str_trim(.)

# Obtain map of NL municipalities from PDOK
municipalities_borders <- st_read("https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2018_gegeneraliseerd&outputFormat=json")

#Select relevant columns
municipalities_borders <- select(municipalities_borders, c(Municipality = "statnaam", "geometry"))

#Match the right security region for each municipality and unionize the geometry into security regions
region_borders <- left_join(municipalities_borders, municipality_reg_mapping, by = c("Municipality")) %>%
  group_by(., Region_code) %>%
  summarize(., Region = unique(Region), Region_geom = st_union(geometry, by_feature = FALSE))

#Match measure support for the last period per security region 
region_data_charts <- filter(meas_supp_subset, Subgroup_category == "Region") %>%
  filter(., Date == "2021-02-15") %>%
  select(., c("Region_code", Measure = "Response", "Value")) %>%
  left_join(region_borders, ., by = c("Region_code")) %>%
  select(., c("Region", "Measure", "Value"))

#Save regional split for last period as separate data file
#region_data_lists <- filter(meas_supp_subset, Subgroup_category == "Region" & Date == "2021-02-15") %>% #Was used for top-3 and bottom-3 regions, but differences are too small to be very interesting
 # select(., c(Region = "Subgroup", Measure = "Response", "Value"))

#Remove region as subgroup and column from measures subset
meas_supp_subset <- filter(meas_supp_subset, Subgroup_category != "Region") %>%
  select(., c("Date", "Subgroup_category", "Subgroup", Measure = "Response", "Value"))


#==========Write to smaller files for Shiny app
write.csv(meas_supp_subset, "./Data/measures_sup.csv", row.names = FALSE)
write.csv(meas_att_subset, "./Data/measures_att.csv", row.names = FALSE)
write.csv(vacc_will_subset, "./Data/vacc_will.csv", row.names = FALSE)
#write.csv(region_data_lists, "./Data/region_data_lists.csv", row.names = FALSE)
st_write(region_data_charts, "./Data/region_data_charts.shp", append = FALSE)
