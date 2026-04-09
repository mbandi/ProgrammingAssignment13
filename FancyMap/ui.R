# 
# I'm extending my R Markdown and Leaflet project to calculate the discance between two
# selected point in a map.
# 
# The documentation for this was taken from this sources:
# 
## https://rstudio.github.io/leaflet/articles/shiny.html
## https://rstudio.github.io/leaflet/articles/showhide.html
# 
# 
# If no one likes this map I'll do another one with more math... but with this 
# one you get to know some places to check out if you come to visit
# 


library(shiny)
library(leaflet)


fluidPage(
    
    # Application title
    titlePanel("Nice places in Palma, updated 09/04/2026"),
    
    
    sidebarLayout(
        sidebarPanel(
            
            h4("Details"),
            textOutput("description")
        ),
        
        
        # This is for the map
        mainPanel(
            leafletOutput("map")
        )
    )
)
