

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
      )
    ),
    
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
      )
    ),
    
    #========== Tab 3
    tabPanel(span("Compare measures", title = "Choose one specific group of people and compare their support for different measures"),
      fluidRow(
        column(1),
        column(8,       
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
      )
    ),
    
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
      )#close row
    )#close tabpanel
  )#close navbarpage
