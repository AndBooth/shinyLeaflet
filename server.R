

library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  
  # Reactive to filter the dataframe based on the selected accident severity
  accidentSeverity <- reactive({
    
    if (input$severity != "All")
      return(accidents_sample[accidents_sample$Accident_Severity == as.integer(input$severity), ])
    else
      return(accidents_sample)
    
  })
  
  # Render the leaflet map
  output$map <- renderLeaflet({
    
    accidents_plot <- accidentSeverity()
    
    accidents_plot %>% leaflet() %>%
      addTiles() %>%
      setView(lng = -1.1, lat = 53.95, zoom = 10) %>%
      addMarkers()
    
  })

  # Reactive to filter the dataframe based on the current map bounds
  accidentsInView <- reactive({
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    
    accidentsselect <- accidentSeverity()
    
    accidentsselect %>% filter(Latitude >= latRng[1] & Latitude <= latRng[2] & 
                                Longitude >= lngRng[1] & Longitude <= lngRng[2])
  })
  
  # Output histogram of the accident counts per day of the week
  output$hist <- renderPlot({
    
    current_data <- accidentsInView()

    ggplot(current_data, aes(Day_of_Week)) + geom_bar(colour = "black", fill = "dodgerblue") +
      xlab("Day of the week")

  })
  
})
