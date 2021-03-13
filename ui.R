
navbarPage(
  theme = shinytheme("cerulean"),
  title ="COVID measures in the Netherlands",

    #========== Tab 1
    tabPanel(span("Regional differences in support", title = "Choose one Covid measure and compare support between different regions in the Netherlands"), 
      fluidRow(
        column(1),
        column(8,
               #h4("Geographical differences in support"),
               br(),
               plotOutput("GeoPlot"),
               br(),
               br(),
               selectInput(inputId = 'Measure_geo',
                           label = 'Compare support for measure',
                           choices = unique(region_data_lists$Measure),
                           selected = "Vaccination"
               )  
        ),
        column(2,
               br(),
               br(),
               h4("Regions with highest support"),
               textOutput("region1"),
               textOutput("region2"),
               textOutput("region3"),
        
               br(),
               h4("Regions with lowest support"),
               textOutput("region4"),
               textOutput("region5"),
               textOutput("region6")
        ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
               h4("Explanation"),
               "Percentage of the sample supporting the main COVID measures in the latest cohort of the survey.", br(),
               "Regional split based on \"Veiligheidsregio's\" represented within the survey sample.", br(),
               br(),
               "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
        ),
        column(1)
      ) #close row
    ), #close tab
    
    #========== Tab 2      
    tabPanel(span("Compare groups of people", title = "Choose one Covid measure and compare the support of groups of people based on their age, gender of level of education"),
      fluidRow(
        column(1),
        column(10,
          br(),
          plotOutput("Meas_beh_bysubgroup"),
          br(),
          br(),
          selectInput(inputId = 'Subgroup_cat',
                      label = 'Compare between groups based on',
                      choices = unique(meas_subset$Subgroup_category),
                      selected = "Age"
                      ),
          selectInput(inputId = 'Measure_comp',
                      label = 'Compare support for',
                      choices = unique(meas_subset$Measure), 
                      selected = "Vaccination"
                      )
        ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
               h4("Explanation"),
               "Percentage of the sample supporting the main COVID measures for all cohorts of the survey.", br(),
               "Split based on based on the subgroups of the population representated in the survey.", br(),
               br(),
               "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
        ),
        column(1)
      ) #close row
    ), #close tab
    
    #========== Tab 3
    tabPanel(span("Compare measures", title = "Choose one specific group of people and compare their support for different measures"),
      fluidRow(
        column(1),
        column(10,       
          br(),
          plotOutput("Beh_subgroup_bymeasure"),
          br(),
          br(),
          selectInput(inputId = 'Subgroup_meas',
                      label = 'Support over time for specific group',
                      choices = unique(meas_subset$Subgroup),
                      selected = "Aged 16-24"
                      )
        ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
               h4("Explanation"),
               "Percentage of the sample supporting the main COVID measures for all cohorts of the survey.", br(),
               "Split based on the subgroups of the population representated in the survey.", br(),
               br(),
               "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
        ),
        column(1)
      ) #close row
    ), #close tab
    
    #========== Tab 4
    
    tabPanel(span("Vaccination willingness details", title = "Explore the details of vaccination willingness"),
      fluidRow(
        column(1),
        column(10,       
          br(),
          h2("Will the Dutch population reach the critical 80% treshold vaccination level?"),
          br(),
          plotOutput("Vacc_Detail"),
          br(),
          br(),
          selectInput(inputId = 'Subgroup_vacc',
                      label = 'Willingness over time for specific group',
                      choices = unique(vacc_will_subset$Subgroup),
                      selected = "Aged 16-24"
                      )
        ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
               h4("Explanation"),
               "Percentage of the sample being (not) willing to take the vaccination as reported in all cohorts of the survey.", br(),
               "Split based on based on the subgroups of the population representated in the survey.", br(),
               br(),
               "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
        ),
        column(1)
      ) #close row
    ), #close tab
  
  #========== Tab 5
  tabPanel(span("Compare behavior", title = "Choose one specific group of people and one specific measure and compare actual behavior with support"),
           fluidRow(
             column(1),
             column(10,       
                    br(),
                    plotOutput("Att_subgroup_bymeasure"),
                    br(),
                    br(),
                    selectInput(inputId = 'Subgroup_att',
                                label = 'Behavior over time for specific group',
                                choices = unique(att_subset$Subgroup),
                                selected = "Aged 16-24"
                    ),
                    selectInput(inputId = 'Measure_att',
                                label = 'Behavior over time towards measure',
                                choices = unique(att_subset$Measure),
                                selected = "Max_guests_@home"
                    )
             ),
             column(1)
           ), #close row
           fluidRow(
             column(1),
             column(10,
                    h4("Explanation"),
                    "Reported adherence in percentage for respondent and environment of respondent with regards to the main COVID measures for all cohorts in the survey", br(),
                    "Split based on the subgroups of the population representated in the survey.", br(),
                    br(),
                    "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
             ),
             column(1)
           ) #close row
  ), #close tab
  #========== Tab 5
  tabPanel(span("About", title = "Background of this visualization"),
           fluidRow(
             column(1),
             column(10,
                    br(),
                    h4("The data"),
                    "All data in this visualization tool was gathered in a representative survey of the Dutch popluation.", br(),
                    "This research was realized based on advice from the Scientific Advisory Board of the Behavior Unit of the RIVM National Institute for Public Health and was funded by the Dutch Organization for Scientific Research (NWO), the Dutch organization for health research and healthcare innovation (ZonMw) and the Dutch Ministry of Health, Welfare and Sports.", br(), 
                    br(),
                    "The survey ran for 10 cohorts at the time of writing. The lowest number of respondents in a single cohort was 47.470, only the data for the respondents who have participated in at least 2 of the 10 cohorts has been included in the results. The results for the data of respondents who have participated in all 10 cohorts (4.976) are not materially different.", br(),
                    br(),
                    "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek"),
                    br(),
                    br(),
                    h4("Author"),
                    "Athena84 is a participant in the January 2021 cohort of the ",
                    a("New York City Data Science Academy Bootcamp.", href = "https://nycdatascience.com/"),
                    "This visualization tool was created as part of an assignment in the bootcamp.", br(),
                    br(),
                    "Source code of data preparation: ", a("Github", href = "https://github.com/Athena84/COVID_NL"),
             ),
             column(1)
           )#close row
  )#close tab
             
)#close navbarpage
