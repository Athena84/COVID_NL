

fluidPage(
  theme = shinytheme("cerulean"),
  
  titlePanel("How do the Dutch feel about their government's COVID measures?"),
  
  fluidRow(
    column(4,
           h4("Geographical differences in support"),
           img(src = "Map_temp.png"),
           sliderTextInput('timePoint', 
                           'Point in time', 
                            choices = meas_subset$Date
                      ),
           selectInput('x', 'Measure', meas_subset$Response)
    ),
    column(1,
           br(),
           br(),
           h4("Top 3"),
           "[...]",
           br(),
           h4("Bottom 3"),
           "[...]"
    ),
    column(6, offset = 1,
           tabsetPanel(
             tabPanel("Compare groups of people", 
                      plotOutput("Meas_beh_bysubgroup"),
                      selectInput('Subgroup_cat', 'Compare between', meas_subset$Subgroup_category, selected = "Age"),
                      selectInput('Response_cat', 'For behavior', meas_subset$Response_category, selected = "Support"),
                      selectInput('Response', 'Towards Measure', meas_subset$Response, selected = "Vaccination")
                      ), 
             tabPanel("Compare measures", verbatimTextOutput("summary")), 
             tabPanel("Compare behaviors", tableOutput("table"))
          )
    )
  )
)