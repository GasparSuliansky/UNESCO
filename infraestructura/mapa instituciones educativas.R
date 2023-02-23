library(dplyr)
library(ggplot2)
library(sf)
library(showtext)
font_add_google("Encode Sans")
showtext_auto()

locations <- data.frame(
  location = c("Instituto Gulich",
               "Universidad Nacional de La Matanza",
               "Facultad Regional Córdoba",
               "Facultad Regional Mendoza",
               "Instituto Colomb",
               "Universidad Nacional de La Plata",
               "Universidad Nacional del Sur",
               "Universidad de Buenos Aires"),
  universidad = c("UNC", 
                  "UNLM", 
                  "UTN", 
                  "UTN",
                  "UNSAM",
                  "UNLP",
                  "UNS",
                  "UBA"),
  latitude = c(-31.5, -34.699216, -30.5, -32.904903, -34.532870, -34.921972, -38.717492, -34.603722),
  longitude = c(-64.75, -58.569664, -64, -68.838510, -58.725902, -57.954363, -62.274139, -58.381592)
)

shp_prov <- read_sf("/Users/gasparsuliansky/Downloads/DEPARTAMENTOS 1869-2010/Cartografia/PROVINCIAS_1960_ACT.shp")

shp_prov |>
  ggplot() +
  geom_sf() +
  geom_point(data = locations, aes(x = longitude, y = latitude, col = universidad), size = 2.5, alpha = 0.95) +
  theme_void() +
  coord_sf(datum = NA) +
  xlim(-80, -50) +
  ylim(-58, -20) +
  theme(legend.title = element_blank(),
        legend.text = element_text(family = "Encode Sans", colour = "black", size = 11)) +
  scale_color_brewer(palette = "Blues")
