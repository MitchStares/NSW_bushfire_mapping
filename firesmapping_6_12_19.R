library(rgdal)
library(sf)
library(tidyverse)
library(raster)

# Vegetation

#Read in current https://www.rfs.nsw.gov.au/fire-information/fires-near-me feed/map
fires <- sf::st_read("http://www.rfs.nsw.gov.au/feeds/majorIncidents.json")

st_write(obj = fires, "E:/Coding Tutorials-Learning/firesnearme_2_1_20.geojson") #incase you want to save it as a file
# This file is a shapefile of the australia, taken from Geoscience Australia http://www.ga.gov.au/
aus_border <- st_read(dsn = "vegetationnswextantnativevegetationv2", layer = "cstauscd_r")
nsw_coast <- filter(aus_border, FEAT_CODE == "mainland" & STATE_CODE == 3) #filter the australian wide map to NSW

nsw_coast <- st_transform(nsw_coast, crs(fires))
fires_crop <- st_crop(fires, nsw_coast)


#vegetation
# dpath<- "vegetationnswextantnativevegetationv2/NSWExtantNativeVegetationV2/Data/extveg002/extveg002"
# x <- new("GDALReadOnlyDataset", dpath)
# getDriver(x)
# getDriverLongName(getDriver(x))
# xx<-asSGDF_GROD(x)
# r <- raster(xx)
# 
# 
# illawarra <- sf::st_read(dsn = "E:/Demonstrating&Teaching/BIOL360 R module/Data/illawarra_veg/data/shapefile", layer = "IllawarraPCT_2016_E_4678")
# illawarra <- st_transform(illawarra, crs(fires))


fires_plot<- ggplot()+
  geom_sf(data = nsw_coast, fill = "gray90") +
  #geom_sf(data = scivi)+
  geom_sf(data = fires, fill = "red")+
  theme_classic() +
  xlim(144, 154)+
  ylim(37, 28)+
  theme(axis.line = element_line(size = 1), title = element_text(size = 14, face = "bold"))
  #labs(title = "1.52 million hectares burnt so far this fire season!!", subtitle = "Thats 1.8% of the total state of NSW")
fires_plot
#ggsave(plot = fires_plot, filename = "E:/Coding Tutorials-Learning/fireplot_6_12_19.png", dpi = 600)
