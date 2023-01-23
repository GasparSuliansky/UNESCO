install.packages(c("tidyverse", "readxl", "rnaturalearth", "rnaturalearthdata", "ggrepel", "showtext"))
library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggrepel)
library(showtext)
font_add_google("Encode Sans", family = "Encode Sans")
showtext_auto()

world_map_data <- ne_countries(returnclass = "sf") %>% filter(!name == "Antarctica")

df <- read_csv("https://raw.githubusercontent.com/GasparSuliansky/UNESCO/main/Mapa.csv")

ggplot() +
  geom_sf(data = world_map_data, color = "gray81", fill = "gray89") +
  theme_void() +
  geom_point(data = df, aes(x = Longitud, y = Latitud, size = as.factor(Cantidad)), col = "#0099CC", alpha = 0.80) +
  theme(plot.background = element_rect(fill= "white", colour = "white")) +
  scale_size_manual(values = c("1" = 1, "2" = 2, "3" = 3, "6" = 6)) +
  guides(size = "none")