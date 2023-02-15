library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)

world_map_data <- ne_countries(returnclass = "sf") %>% filter(!name == "Antarctica")

df <- data.frame(
  latitude = c(-34.6037, -28.4731, -31.4135, 37.2718, 39.7392, -34.9011, 54.7723, 18.4252, 41.3851, 35.4979, 51.9225, 32.0853, 49.8158),
  longitude = c(-58.3816, -65.7954, -64.181, -119.4179, -104.9903, -56.1645, -1.5807, -64.6399, 2.1734, -80.8431, 4.4891, 34.7818, 6.1296),
  cantidad = c(6, 1, 2, 3, 1, 2, 1, 1, 1, 1, 1, 1, 1)
  )

ggplot() +
  geom_sf(data = world_map_data, color = "gray81", fill = "gray89") +
  theme_void() +
  geom_point(data = df, aes(x = longitude, y = latitude, size = as.factor(cantidad)), col = "#0099CC", alpha = 0.80) +
  theme(plot.background = element_rect(fill= "white", colour = "white")) +
  scale_size_manual(values = c("1" = 1, "2" = 2, "3" = 3, "6" = 6)) +
  guides(size = "none")
