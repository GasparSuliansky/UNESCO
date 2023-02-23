library(tidyverse)
library(ggflags)
library(showtext)
font_add_google("Encode Sans")
showtext_auto()
options(scipen = 999)

df <- data.frame(
  country = c("Estados Unidos", "China", "Unión Europea", "Francia", "Italia", "Rusia", "Japón", "Alemania", "India", "Reino Unido", "Corea del Sur", "Canadá", "Argentina"),
  budget = c(25973800000, 8900000000, 7511172000, 2722269400, 2440070000, 2014760000, 1742314000, 1430093200, 1139458836.60, 576939200, 471944253.45, 362648759.06, 55759568.78),
  code = c("us", "cn", "eu", "fr", "it", "ru", "jp", "de", "in", "gb", "kr", "ca", "ar"),
  gdp = c(70248.6, 12556.3,38411.4, 43659, 35657.5, 12194.8, 39312.7, 51203.6, 2256.6, 46510.3, 34997.8, 51987.9, 10636.1)
)

df |>
  ggplot(aes(x = reorder(country, -budget), y = budget/1000000000)) +
  geom_col(fill = "#0099CC", col = "black", linewidth = 0.2) + 
  geom_text(aes(label = scales::comma_format(big.mark = ".", decimal.mark = ",")(round(budget/1000000000, 2))), col = "black", size = 3.75, family = "Encode Sans", fontface = "bold", vjust = -0.75) +
  theme_minimal() +
  guides(size = "none") +
  theme(panel.grid = element_blank(),
        plot.background = element_rect(),
        axis.line = element_line(linewidth = 0.35, colour = "black"),
        axis.text.y = element_text(family = "Encode Sans", face = "bold", size = 11, colour = "black"),
        axis.text.x = element_text(family = "Encode Sans", face = "bold", size = 11, colour = "black", angle = 90)) +
  labs(x = element_blank(), y = element_blank()) +
  scale_y_continuous(limits = c(0, 30), breaks = seq(0, 30, 5), expand = c(0, 0))

df |>
  mutate(x = c(1, 12, 2.5, 11, 0, 8.5, 4.5, 7, 12, 6, 6, 8, 9), y = c(11, 1, 0.5, 12, 4, 4, 5.5, 8, 6.5, 1.5, 11, 13.5, 7)) |>
  ggplot(aes(x = x, y = y, country = code, label = round(budget/1000000000, 2))) +
  geom_flag(size = sqrt(df$budget / 1000000000) * 12.5) +
  geom_text(vjust = -2.5, family = "Encode Sans", fontface = "bold") +
  guides(size = "none") +
  scale_size_continuous() +
  ylim(-2, 16) + xlim(-1.5, 13.5) +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid = element_blank())
