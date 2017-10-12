

library(shiny)

shinyUI(fluidPage(

  
  sidebarLayout(
    sidebarPanel(
      selectInput("severity",
                  "Accident Severity:",
                  c("All", "1", "2", "3")),
      plotOutput("hist", height = "250px")
    ),

   
    mainPanel(
      leafletOutput("map")
    )
  )
))
