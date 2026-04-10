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


function(input, output, session) {
    
    markerA <- NULL
    markerB <- NULL
    
    output$map <- renderLeaflet({
        my_map <- leaflet() %>% 
            addTiles() %>%
            
            # Group parameter is used to control visibility, layerId is to know what marker the user clicked
            addMarkers(lat = 39.565480, lng = 2.653512, popup = "Bellaombra", group = "Landmarks", layerId = "Bellaombra") %>%
            addMarkers(lat = 39.570967, lng = 2.640377, popup = "Big park", group = "Landmarks", layerId = "Sa Feixina") %>%
            addMarkers(lat = 39.567634, lng = 2.647568, popup = "Cathedral", group = "Landmarks", layerId = "La Seu") %>%
            addMarkers(lat = 39.571418, lng = 2.649283, popup = "Cool modernist buildings", group = "Landmarks", layerId = "Pl. Mercat") %>%
            addMarkers(lat = 39.569623, lng = 2.649969, popup = "Old olive tree", group = "Landmarks", layerId = "Cort") %>%
            addMarkers(lat = 39.575540, lng = 2.653417, popup = "Plaza España", group = "Landmarks", layerId = "Pl. España") %>%
            
            
            addMarkers(lat = 39.571252, lng = 2.653434, popup = "Best Ice cream", group = "Food/drink", layerId = "Claudio's") %>%
            addMarkers(lat = 39.567758, lng = 2.654576, popup = "A vegan restaurant", group = "Food/drink", layerId = "Temple Natura") %>%
            addMarkers(lat = 39.583628, lng = 2.655691, popup = "Great pizza", group = "Food/drink", layerId = "Quemado") %>%
            addMarkers(lat = 39.572195, lng = 2.639348, popup = "Bars and restaurants", group = "Food/drink", layerId = "C. Fabrica") %>%
            addMarkers(lat = 39.578447, lng = 2.650977, popup = "Coffe and restaurants", group = "Food/drink", layerId = "C. Blanquerna") %>%
            addMarkers(lat = 39.579886, lng = 2.650021, popup = "Artisanal chocolate store", group = "Food/drink", layerId = "Maua") %>%
            
            
            addMarkers(lat = 39.565157, lng = 2.655702, popup = "'Restored' old wall", group = "Nice Views", layerId = "Baluar d'es Princep") %>%
            addMarkers(lat = 39.571935, lng = 2.651175, popup = "Stairs with some views", group = "Nice Views", layerId = "La Rambla") %>%
            addMarkers(lat = 39.566989, lng = 2.647692, popup = "Old wall", group = "Nice Views", layerId = "Dalt Murada") %>%
            addMarkers(lat = 39.569665, lng = 2.641128, popup = "To see the bay", group = "Nice Views", layerId = "Es Baluard views 1") %>%
            addMarkers(lat = 39.570545, lng = 2.641775, popup = "To see the old town roofs", group = "Nice Views", layerId = "Es Baluard views 2") %>%
            addMarkers(lat = 39.563842, lng = 2.619530, popup = "To see the city", group = "Nice Views", layerId = "Bellver") %>%
            
            
            addMarkers(lat = 39.566282, lng = 2.650319, popup = "Architecture exposition", group = "To visit", layerId = "Architect's College") %>%
            addMarkers(lat = 39.567179, lng = 2.650736, popup = "Historic Art exposition", group = "To visit", layerId = "Museo Mallorca") %>%
            addMarkers(lat = 39.570140, lng = 2.641042, popup = "Modern art", group = "To visit", layerId = "Es Baluard Museum") %>%
            addMarkers(lat = 39.570744, lng = 2.648075, popup = "Cool mind teasers", group = "To visit", layerId = "Puzzle2") %>%
            
            # This adds an overlayed control on the map to show/hide groups.
            addLayersControl(
                overlayGroups = c("Landmarks", "Food/drink", "Nice Views", "To visit"),
                options = layersControlOptions(collapsed = FALSE))
        
        my_map
    })
    
    # Here we observe the marker click event
    observeEvent(input$map_marker_click, {
        
        # Show the description of the selected point
        setDescription(input$map_marker_click$id)
        
        # Get the selected point info to calculate the distance
        selectMarker(input$map_marker_click)
        
        # This generates the distance text according to the user selected markers
        output$distanceText <- renderText({
            if (is.null(markerA) || is.null(markerB)) {
                "Select two markers to calculate the distance"
            } else {
                paste("Distance between marker A and marker B is: ", distance(), " m")
            }
        })
    })
    
    distance <- function() {
        pointA <- c(markerA$lng, markerA$lat)
        pointB <- c(markerB$lng, markerB$lat)
        pointDistance(pointA, pointB, lonlat = TRUE)
    }
    
    # Check the Id and set the corresponding description for the marker
    setDescription <- function(markerId) {
        output$description <- renderText({
            if(markerId == "Bellaombra") {
                "We used to have beautiful trees here, but the city council chop them down :("
            } else if(markerId == "Sa Feixina") {
                "It's a big park with different elevations. It's at the limit of the old town and the new part."
            } else if(markerId == "La Seu") {
                "The cathedral was made to be seen from the sea, so you also get a nice view of it from most of the bay"
            } else if(markerId == "Pl. Mercat") {
                "You can find some interesting modernist buildings around here, and it's close to a shopping area."
            } else if(markerId == "Cort") {
                "This is the old city council square, but I particularly like the old olive tree. It's around 600 years old."
            } else if(markerId == "Pl. España") {
                "Because you can't have a city in Spain without a Spain Square. Also the main place to get a taxi, bus or train. If you get lost, this is a good place to go."
            } else if(markerId == "Claudio's") {
                "Claudio's icre cream are the best. If you find a better ice cream in Palma let me know. It's closed in winter, though."
            } else if(markerId == "Temple Natura") {
                "If you like vegan food, this place has a beautiful inner yard. If you don't, you can get some drinks. Sometimes they have live music."
            } else if(markerId == "Quemado") {
                "Great pizza and wonderful people :D"
            } else if(markerId == "C. Fabrica") {
                "You can find a lot of restaurants and places to drink here."
            } else if(markerId == "C. Blanquerna") {
                "You can find a lot of restaurants and coffe shops here."
            } else if(markerId == "Maua") {
                "This guys craft their own chocolate, with products from specific places. Like a specialty coffe shop, but for chocolate."
            } else if(markerId == "Baluar d'es Princep") {
                "This was part of the old defensive wall of the city, and is 'newly restored'. There are some nice views from up there."
            } else if(markerId == "La Rambla") {
                "There are some nice views from the top of the stairs. Specially around christmass."
            } else if(markerId == "Dalt Murada") {
                "This is a nice walk and you get to see the bay and sea."
            } else if(markerId == "Es Baluard views 1") {
                "The west limit of the old wall, you can have some views from here. The cathedral, the bay and Bellver."
            } else if(markerId == "Es Baluard views 2") {
                "There are not a lot of places to see the rooftop os the old town buildings, this is one of them."
            } else if(markerId == "Bellver") {
                "Bellver Castle. This is a not-very-practical multi-purpose small castle with some panoramic views of the city."
            } else if(markerId == "Architect's College") {
                "This belongs to the Architecture college, sometimes they have some expositions that you can see."
            } else if(markerId == "Museo Mallorca") {
                "Mallorca's historic art museum, it's a nice walk."
            } else if(markerId == "Es Baluard Museum") {
                "This is the modern art museum."
            } else if(markerId == "Puzzle2") {
                "Nice little store with very friedly staff and lots of mind teasers."
            }
        })
    }
    
    # We keep the pointA if it was already set
    selectMarker <- function(selectedMarker) {
        if(is.null(markerA)) {
            markerA <<- selectedMarker
            output$markerA <- renderText({paste(markerA$id, "(", markerA$lat, ", ", markerA$lng, ")")})
        } else {
            markerB <<- selectedMarker
            output$markerB <- renderText({paste(markerB$id, "(", markerB$lat, ", ", markerB$lng, ")")})
        }
    }
    
    # Remove marker's selection
    observeEvent(input$resetMarkers, {
        markerA <<- NULL
        output$markerA <- NULL
        markerB <<- NULL
        output$markerB <- NULL
        output$distanceText <- renderText({"Select two markers to calculate the distance"})
    })
    
}

