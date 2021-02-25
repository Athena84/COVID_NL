
function(input, output){
  
  #====== tab1
  
  filter_vacc <- reactive(
    filter(region_data, Measure == input$Measure_geo)
  )
  top_bottom_regions <- reactive(
    filter_vacc() %>%
      arrange(., desc(Value)) %>%
      select(., Region) 
  )
  
  
  output$GeoPlot <- renderPlot(
    filter_vacc() %>%
      ggplot(data = .) +
      geom_sf(aes(fill = Value)) +
      scale_fill_viridis_c() +
      theme_void()
  )
  
  output$region1 <- renderPrint({
    top_bottom_regions() %>%
      .[1, "Region"]
  })
  output$region2 <- renderPrint({
    top_bottom_regions() %>%
      .[2, "Region"]
  })
  output$region3 <- renderPrint({
    top_bottom_regions() %>%
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
        axis.text.x = element_text(size = 14, angle = 90),
        axis.text.y = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.position = "bottom",
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
        axis.text.x = element_text(size = 14, angle = 90),
        axis.text.y = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.position = "bottom",
        legend.title=element_blank()
      ) +
      ylim(0,100) +
      xlab("") +
      ylab("")
  )
  
  #======= tab4
  output$Vacc_Detail <- renderPlot(
    filter(vacc_will_subset, Subgroup == input$Subgroup_vacc) %>%
      ggplot(data = ., aes(x = Date, y = Value)) +
      geom_bar(aes(group = Response, fill = Response), stat = "identity", position = position_fill()) +
      #geom_text(aes(group = Response, label = Value), colour = "white") +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 14, angle = 45),
        axis.text.y = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.position = "bottom",
        legend.title=element_blank()
      ) +
      xlab("") +
      ylab("") +
      scale_fill_manual(values = c("#d1495b", "#8d96a3", "#00798c", "#66a182"))
  )
  
}