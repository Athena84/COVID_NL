

fluidPage(
  theme = shinytheme("cerulean"),
  
  titlePanel("How do the Dutch feel about their government's COVID measures?"),
  
  br(),
  
  tabsetPanel(
    #========== Tab 1
    tabPanel("Geographical differences in support", 
      fluidRow(
        column(6,
               h4("Geographical differences in support"),
               br(),
               plotOutput("geoPlot")
        ),
        column(2,
               br(),
               br(),
               h4("Top 3"),
               "[...]",
               br(),
               h4("Bottom 3"),
               "[...]"
        ),
        column(3, offset = 1,
           h4("..."),
           selectInput('Measure_geo', 'Compare support for measure', region_data$Measure, selected = "Vaccination")  
        )
      )
    ),
    
    #========== Tab 2      
    tabPanel("Compare groups of people",
      fluidRow(
        column(8,
          br(),
          plotOutput("Meas_beh_bysubgroup")
        ),
        column(3, offset = 1,
          #style = "border: 1px dotted black;",
          h4("..."),
          selectInput('Subgroup_cat', 'Compare between groups based on', meas_subset$Subgroup_category, selected = "Age"),
          selectInput('Measure_comp', 'Compare support for', meas_subset$Measure, selected = "Vaccination")
        )
      )
    ),
    
    #========== Tab 3
    tabPanel("Compare measures",
      fluidRow(
        column(8,       
          br(),
          plotOutput("Beh_subgroup_bymeasure")
        ),
        column(3, offset = 1,
          h4("..."), 
          selectInput('Subgroup_meas', 'Compare support for measure for specific group', meas_subset$Subgroup, selected = "70+")
        )
      )
    ),
    
    #========== Tab 4
    tabPanel("Details on vaccination willingness",
      fluidRow(
        column(8,       
          br(),
          
          plotOutput("Vacc_Detail")
        ),
        column(3, offset = 1,
          h4("..."), 
          selectInput('Subgroup_vacc', 'Compare development over time of willingness for vaccination for based on specific group', vacc_will_subset$Subgroup, selected = "70+")
        )
    )
    )
  )
)
