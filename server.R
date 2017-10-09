
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  
  accidentSeverity <- reactive({
    
    if (input$severity != "All")
      return(accidents_sample[accidents_sample$Accident_Severity == as.integer(input$severity), ])
    else
      return(accidents_sample)
    
  })
  
  
  output$map <- renderLeaflet({
    
    accidents_plot <- accidentSeverity()
    
    accidents_plot %>% leaflet() %>%
      addTiles() %>%
      setView(lng = -1.1, lat = 53.95, zoom = 10) %>%
      addMarkers()
    
  })

  
  accidentsInView <- reactive({
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    
    accidentsselect <- accidentSeverity()
    
    accidentsselect %>% filter(Latitude >= latRng[1] & Latitude <= latRng[2] & 
                                Longitude >= lngRng[1] & Longitude <= lngRng[2])
  })
  
  
  output$scatter <- renderPlot({
    
    current_data <- accidentsInView()

    ggplot(current_data, aes(Day_of_Week)) + geom_bar(colour = "black", fill = "dodgerblue") +
      xlab("Day of the week")

  })
  
})
