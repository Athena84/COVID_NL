
function(input, output){
  
  output$Meas_beh_bysubgroup <- renderPlot(
    filter(meas_subset, (Response_category == input$Response_cat & Subgroup_category == input$Subgroup_cat & Response == input$Response)) %>%
      ggplot(data = ., aes(x = Date, y = Value, group = Subgroup, colour = Subgroup)) +
      geom_line() +
      ylim(0,100)
  )
  
}