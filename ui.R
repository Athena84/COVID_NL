

fluidPage(
  theme = shinytheme("cerulean"),
  
  titlePanel("How do the Dutch feel about their government's COVID measures?"),
  
  br(),
  tabsetPanel(
    #========== Tab 1
    tabPanel(span("Geographical differences in support", title = "Choose one Covid measure and compare support between different regions in the Netherlands"), 
      fluidRow(
        column(6,
               h4("Geographical differences in support"),
               br(),
               plotOutput("GeoPlot")
        ),
        column(2,
               br(),
               br(),
               h4("Top 3"),
               textOutput("region1"),
               textOutput("region2"),
               #textOutput("region3"),
        
               br(),
               h4("Bottom 3"),
               "[...]"
        ),
        column(3, offset = 1,
           h4("..."),
           selectInput(inputId = 'Measure_geo',
                       label = 'Compare support for measure',
                       choices = unique(region_data$Measure),
                       selected = "Vaccination"
                       )  
        )
      )
    ),
    
    #========== Tab 2      
    tabPanel(span("Compare groups of people", title = "Choose one Covid measure and compare the support of groups of people based on their age, gender of level of education"),
      fluidRow(
        column(8,
          br(),
          plotOutput("Meas_beh_bysubgroup")
        ),
        column(3, offset = 1,
          #style = "border: 1px dotted black;",
          h4("..."),
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
        )
      )
    ),
    
    #========== Tab 3
    tabPanel(span("Compare measures", title = "Choose one specific group of people and compare their support for different measures"),
      fluidRow(
        column(8,       
          br(),
          plotOutput("Beh_subgroup_bymeasure")
        ),
        column(3, offset = 1,
          h4("..."), 
          selectInput(inputId = 'Subgroup_meas',
                      label = 'Compare support for measure for specific group',
                      choices = unique(meas_subset$Subgroup),
                      selected = "70+"
                      )
        )
      )
    ),
    
    #========== Tab 4
    
    tabPanel(span("Vaccination willingness details", title = "Explore the details of vaccination willingness"),
      fluidRow(
        column(8,       
          br(),
          
          plotOutput("Vacc_Detail")
        ),
        column(3, offset = 1,
          h4("..."), 
          selectInput(inputId = 'Subgroup_vacc',
                      label = 'Compare development over time of willingness for vaccination for based on specific group',
                      choices = unique(vacc_will_subset$Subgroup),
                      selected = "70+"
                      )
        )
    )
    )
  )
)
