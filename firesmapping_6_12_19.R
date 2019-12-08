library(sf)
library(tidyverse)
library(raster)

fires <- sf::st_read("http://www.rfs.nsw.gov.au/feeds/majorIncidents.json")
#st_write(obj = fires, "E:/Coding Tutorials-Learning/firesnearme.geojson")
aus_border <- st_read(dsn = "E:/Demonstrating&Teaching/BIOL360 R module/Data/61395_shp/australia", layer = "cstauscd_r")
nsw_coast <- filter(aus_border, FEAT_CODE == "mainland" & STATE_CODE == 3)
#scivi <- st_read(dsn = "S:/Biosci Bushfires/CERMB_LIBRARY/GIS/VEGETATION/SCIVI", layer = "Scivi_xdv9")
#scivi <- filter(scivi, grepl("^Forest", NSWMAP_FOR))

nsw_coast <- st_transform(nsw_coast, crs(fires))
fires_crop <- st_crop(fires, nsw_coast)

fires_plot<- ggplot()+
  geom_sf(data = nsw_coast, fill = "gray90") +
  #geom_sf(data = scivi)+
  geom_sf(data = fires, fill = "red")+
  theme_classic() +
  xlim(144, 154)+
  ylim(36, 28)+
  theme(axis.line = element_line(size = 1), title = element_text(size = 14, face = "bold"))+
  labs(title = "1.52 million hectares burnt so far this fire season!!", subtitle = "Thats 1.8% of the total state of NSW")
fires_plot
ggsave(plot = fires_plot, filename = "E:/Coding Tutorials-Learning/fireplot_6_12_19.png", dpi = 600)
