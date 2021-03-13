
function(input, output){

    top_regions <- reactive(
    filter(region_data_lists, Measure == input$Measure_geo) %>%
    arrange(., desc(Value)) %>%
    select(., Region) 
  )
  bottom_regions <- reactive(
    filter(region_data_lists, Measure == input$Measure_geo) %>%
      arrange(., Value) %>%
      select(., Region) 
  )
  
  #====== tab1
  
  my_breaks <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
  
  output$GeoPlot <- renderPlot(
    filter(region_data_charts, Measure == input$Measure_geo) %>%
      ggplot(data = .) +
      geom_sf(aes(fill = Value)) +
      scale_fill_gradientn(colours = rev(brewer.pal(6, "Reds")),
                           name = "% of population in support of measure",
                           breaks = my_breaks,
                           labels = my_breaks,
                           limits = c(40,100)) +
      theme(axis.line=element_blank(),
            axis.text.x=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            #legend.position="none",
            panel.background=element_blank(),
            panel.border=element_blank(),
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            plot.background=element_blank())
    )
  
  output$region1 <- renderPrint({
    top_regions() %>%
      .[1, "Region"]
  })
  output$region2 <- renderPrint({
    top_regions() %>%
      .[2, "Region"]
  })
  output$region3 <- renderPrint({
    top_regions() %>%
      .[3, "Region"]
  })
  output$region4 <- renderPrint({
    bottom_regions() %>%
      .[1, "Region"]
  })
  output$region5 <- renderPrint({
    bottom_regions() %>%
      .[2, "Region"]
  })
  output$region6 <- renderPrint({
    bottom_regions() %>%
      .[3, "Region"]
  })
  
  #======= tab 2
  
  output$Meas_beh_bysubgroup <- renderPlot(
    filter(meas_subset, (Subgroup_category == input$Subgroup_cat & Measure == input$Measure_comp)) %>%
      ggplot(data = ., aes(x = Date, y = Value, group = Subgroup, colour = Subgroup)) +
      geom_line() +
      scale_color_brewer(palette = "Dark2") +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 16, angle = 0),
        axis.text.y = element_text(size = 16),
        legend.text = element_text(size = 16),
        legend.position = "right",
        legend.title=element_blank()
      ) +
      ylim(0,100) +
      xlab("") +
      ylab("")
  )
  
  
  #======= tab 3
  
  output$Beh_subgroup_bymeasure <- renderPlot(
    filter(meas_subset, Subgroup == input$Subgroup_meas) %>%
      ggplot(data = ., aes(x = Date, y = Value, group = Measure, colour = Measure)) +
      geom_line() +
      scale_color_brewer(palette = "Dark2") +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 16, angle = 0),
        axis.text.y = element_text(size = 16),
        legend.text = element_text(size = 16),
        legend.position = "right",
        legend.title=element_blank()
      ) +
      ylim(0,100) +
      xlab("") +
      ylab("")
  )
  
  #======= tab4
  output$Vacc_Detail <- renderPlot(
    filter(vacc_will_subset, Subgroup == input$Subgroup_vacc) %>%
      group_by(Date) %>%
      arrange(Date, desc(Response)) %>%
      mutate(lab_ypos = cumsum(Value) - 0.5 * Value) %>%
      ggplot(data = ., aes(x = Date, y = Value)) +
      geom_col(aes(fill = Response), width = 0.8) +
      geom_text(aes(y = lab_ypos, label = Value, group = Response), colour = "white", size = 5) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 14, angle = 30),
        axis.text.y = element_blank(),
        legend.text = element_text(size = 14),
        legend.position = "bottom",
        legend.title=element_blank(),
        panel.grid = element_blank()
      ) +
      xlab("") +
      ylab("") +
      scale_fill_manual(values = c("#d1495b", "#8d96a3", "#00798c", "#66a182")) +
      geom_hline(yintercept = 80, linetype="dashed", color = "black") +
      geom_text(aes(0, 0.8, label = "80%", hjust = 10)) 
  )
  
  #======= tab 5
  
  output$Att_subgroup_bymeasure <- renderPlot(
    filter(att_subset, Subgroup == input$Subgroup_att & Measure == input$Measure_att) %>%
      ggplot(data = ., aes(x = Date, y = Value, group = Attitude, colour = Attitude)) +
      geom_line() +
      scale_color_brewer(palette = "Dark2") +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 16, angle = 0),
        axis.text.y = element_text(size = 16),
        legend.text = element_text(size = 16),
        legend.position = "right",
        legend.title=element_blank()
      ) +
      ylim(0,100) +
      xlab("") +
      ylab("")
  )
  
  
} #close function