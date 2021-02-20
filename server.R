
function(input, output){
  
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
  
  output$GeoPlot <- renderPlot(
    filter(region_data, Measure == input$Measure_geo) %>%
      ggplot(data = .) +
      geom_sf(aes(fill = Value)) +
      scale_fill_viridis_c() +
      theme_void()
  )
  
  output$Vacc_Detail <- renderPlot(
    filter(vacc_will_subset, Subgroup == input$Subgroup_vacc) %>%
      ggplot(data = ., ) +
      geom_bar(aes(x = Date, y = Value, group = Response, fill = Response), stat = "identity", position = position_fill()) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 14, angle = 90),
        axis.text.y = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.position = "bottom",
        legend.title=element_blank()
      ) +
      xlab("") +
      ylab("") +
      scale_fill_manual(values = c("#00798c", "#8d96a3", "#d1495b", "#66a182"))
    
  )
  
}