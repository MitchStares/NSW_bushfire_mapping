
# Fires Near Me Mapping Script --------------------------------------------

# The following script downloads the current fires near me map avaliable on the RFS website and
# Plots it in a leaflet environment. There is also the option to add in your own site shapefiles
# to view your sites against the current burns

# -------------------------------------------------------------------------

source("S:/Biosci Bushfires/CERMB_LIBRARY/DATA/WEATHER/Avaliable BOM Station Data/using.R")
using("leaflet", "geojsonio", "sf", "jsonlite")

#If using doesnt work, then run the following library commands
#library(leaflet)
#library(geojsonio)
#library(sf)
#library(jsonlite)

#### ADD YOUR SITES HERE ###
#sites <- read_sf("E:/Manuscripts/cwd_chrono/GIS", layer = "eli107")


geojson <- readLines("http://www.rfs.nsw.gov.au/feeds/majorIncidents.json", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)


geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 1,
  fillOpacity = 0.8
)

if(exists("sites") == FALSE){
  leaflet() %>% setView(lng = 151.2093, lat = -33.8688, zoom = 7) %>% addTiles() %>% addGeoJSON(geojson)
} else{
  leaflet() %>% addTiles() %>% addGeoJSON(geojson) %>% addCircleMarkers(data = sites, color = "red")
}


##Used for converting firesnearme data to data frame and saving to alternate formats##

#fires <- sf::st_read("http://www.rfs.nsw.gov.au/feeds/majorIncidents.json")
#sum(st_area(fires))
#st_write(obj = fires, "firesnearme.kml")
