
navbarPage(
  id = "tabs",
  theme = shinytheme("flatly"),
  title ="",

    #========== Landing page
    tabPanel(span("NL COVID vaccination", title = "Background of this visualization"),
      fluidRow(
        column(1),
        column(8,
               h2("Will the Dutch population reach the 70% - 80% vaccination rate experts think is critical?"),
               "The topic dominates many conversations. Many controversies circulate. The Dutch government principally doesn't want to oblige the population to get vaccinated. Also this would be difficult if not impossible in the legal framework. Will the Netherlands reach a vaccination level high enough without obligation?", br(),
               br(),
               "The RIVM institute publishes high-quality representative survey data every couple of weeks regarding the COVID measures including vaccination, albeit in a rather technical table format. This project visualizes that data to give direction to the following questions.", br(),
               br(),
               tags$ul(
                 tags$li(actionLink("link_tab1", "Did the recent campaign work? What part of the Dutch population is expected to accept vaccination?")),
                 tags$li(actionLink("link_tab2","Should a campaign focus on certain geographical regions?")),
                 tags$li(actionLink("link_tab3","Should a campaign focus on certain subgroups of the population?")),
                 tags$li(actionLink("link_tab4","Is supporting vaccination the same as actually taking it?")),
                 tags$li(actionLink("link_tab5","Is there an effect of other COVID measures on acceptance of vaccination?"))
               ),
               "The visualizations are interactive so you can explore the data for yourself to answer related questions regarding the attitudes towards COVID measures.", br()
        ),
        column(2,
               br(),
               img(src='virus_small.jpg', align = "right")
               ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
          br(),
          h4("About the data"),
          "All data in this visualization tool was gathered in a representative survey of the Dutch popluation.", br(),
          "This research was realized based on advice from the Scientific Advisory Board of the Behavior Unit of the RIVM National Institute for Public Health and was funded by the Dutch Organization for Scientific Research (NWO), the Dutch organization for health research and healthcare innovation (ZonMw) and the Dutch Ministry of Health, Welfare and Sports.", br(), 
          br(),
          "The survey ran for 10 cohorts at the time of writing. The lowest number of respondents in a single cohort was 47.470, only the data for the respondents who have participated in at least 2 of the 10 cohorts has been included in the results. The results for the data of respondents who have participated in all 10 cohorts (4.976) are not materially different.", br(),
          br(),
          "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek"),
          br(),
          br(),
          h4("About the author"),
          "I am a data enthusiast from the Netherlands. I participated in the January 2021 cohort of the ",
          a("NYC Data Science Academy Bootcamp.", href = "https://nycdatascience.com/"),
          "This visualization tool was created as part of a bootcamp assignment regarding data visualizaiton with R.", br(),
          br(),
          "Source code of data preparation: ", a("Github", href = "https://github.com/Athena84/COVID_NL"),
         ),
        column(1)
       )#close row
    ),#close tab
  
  
    #========== Tab 1
    tabPanel(
      value = "tab1",
      span("Vaccination willingness details", title = "Explore the details of vaccination willingness"),
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
                           selected = "Total Population"
               )
        ),
        column(1)
      ), #close row
      fluidRow(
        column(1),
        column(10,
               h4("Explanation"),
               "Percentage of the sample (not) being willing to take the vaccination as reported in all cohorts of the survey.", br(),
               "Split based on based on the subgroups of the population representated in the survey.", br(),
               br(),
               "Note that in November and December there was a campaign by the Dutch government to promote vaccine safety", br(),
               br(),
               "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
        ),
        column(1)
      ) #close row 
    ),#close tab
    
    #========== Tab 2      
    tabPanel(
      value = "tab2",
      
      span("Compare regions", title = "Choose one Covid measure and compare support between different regions in the Netherlands"), 
      fluidRow(
        
        column(1),
        column(10,
               #h4("Compare regions"),
               br(),
               plotOutput("GeoPlot"),
               br(),
               br(),
               selectInput(inputId = 'Measure_geo',
                           label = 'Compare support for measure',
                           choices = unique(region_data_charts$Measure),
                           selected = "Vaccination"
               )  
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
    
    #========== Tab 3
    tabPanel(
      value = "tab3",
      
      span("Compare groups of people", title = "Choose one Covid measure and compare the support of groups of people based on their age, gender of level of education"),
      fluidRow(
        column(1),
        column(10,
               br(),
               plotOutput("Meas_beh_bysubgroup"),
               br(),
               br(),
               selectInput(inputId = 'Subgroup_cat',
                           label = 'Compare between groups based on',
                           choices = c("Age", "Gender", "Education level"),
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
      
#========== Tab 4
  
  tabPanel(
    value = "tab4",
    
    span("Compare behavior", title = "Choose one specific group of people and one specific measure and compare actual behavior with support"),
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
                                selected = "Total population"
                    ),
                    selectInput(inputId = 'Measure_att',
                                label = 'Behavior over time towards measure',
                                choices = unique(att_subset$Measure),
                                selected = "Social_distancing"
                    )
             ),
             column(1)
           ), #close row
           fluidRow(
             column(1),
             column(10,
                    h4("Explanation"),
                    "Adherence in percentage for respondent and environment of respondent with regards to the main COVID measures for all cohorts in the survey.", br(),
                    "Please note that this is self-reported adherence, so in reality the differences might be even larger.", br(),
                    "Split based on the subgroups of the population representated in the survey.", br(),
                    br(),
                    "Data source (Dutch): ", a("RIVM", href = "https://www.rivm.nl/gedragsonderzoek/maatregelen-welbevinden/over-dit-onderzoek")
             ),
             column(1)
           ) #close row
  ), #close tab
  
  
    #========== Tab 5
    
    tabPanel(
      value = "tab5",
      
      span("Compare measures", title = "Choose one specific group of people and compare their support for different measures"),
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
    ) #close tab

)#close navbarpage
