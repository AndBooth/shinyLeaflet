
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("severity",
                  "Accident Severity:",
                  c("All", "1", "2", "3")),
      plotOutput("scatter", height = "250px")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map")
    )
  )
))
