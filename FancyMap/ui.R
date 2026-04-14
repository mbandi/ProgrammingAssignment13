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
library(raster)


fluidPage(
    
    # Application title
    titlePanel("Nice places in Palma, updated 09/04/2026"),
    
    
    sidebarLayout(
        sidebarPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Documentation", br(), 
                                 HTML("<ul>
                                            <li>Use the checkboxes in the map to show/hide categories</li>
                                            <li>'Details' tab shows the selected marker information</li>
                                            <li>'Distance' tab show the distance between two markers</li>
                                            <li>Use the 'Reset' button to remove marker selection</li>
                                            <li>Enjoy the city!</li>
                                      </ul>")),
                        tabPanel("Details", br(), textOutput("description")), # Marker description
                        tabPanel("Distance", br(),                            # Distance between markers
                                 "Marker A: ", textOutput("markerA"), br(),
                                 "Marker B: ", textOutput("markerB"), br(),
                                 textOutput("distanceText"), br(),
                                 actionButton("resetMarkers", "Reset"))
            )
        ),
        
        
        # This is for the map
        mainPanel(
            leafletOutput("map")
        )
    )
)
