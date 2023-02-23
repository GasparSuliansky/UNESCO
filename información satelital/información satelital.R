library(tidyverse)
library(showtext)
font_add_google("Fira Sans", "fira sans")
showtext_auto()

df <- data.frame(
  variables = c("Consumidor final", "Corporativo", "Observación de la Tierra"), 
  type = c("Telecomunicaciones", "Telecomunicaciones", "Observación de la Tierra"),
  esp = c("Telecomunicaciones - Consumidor final", "Telecomunicaciones - Corporativo", "Observación de la Tierra"),
  values = c(98.4, 17.2, 2.7)
)

# Pie Chart 

df$esp <- factor(df$esp, levels = c("Telecomunicaciones - Consumidor final", "Telecomunicaciones - Corporativo", "Observación de la Tierra"))

df |>
  mutate(proportion = values / sum(values)) |>
  ggplot(aes(x = "", y = values, fill = esp)) +
  geom_bar(stat = "identity", width = 1, col = "white", linewidth = 0.1) +
  geom_text(aes(label = paste0(scales::dollar_format(decimal.mark = ",")(values), " (", scales::percent_format()(proportion), ")")), family = "fira sans", fontface = "bold", col = "black", size = 6) +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("#0099CC", "#0099CCB2", "#0099CC66")) +
  theme(text = element_text(family = "fira sans", colour = "black", face = "bold"),
        legend.title = element_blank(),
        legend.position = c(0.5, 0.03),
        legend.direction = "horizontal",
        legend.text = element_text(family = "fira sans", colour = "black", face = "bold", size = 11),
        legend.key.size = unit(1, "cm"),
        legend.key.height = unit(1, "cm"),
        legend.key.width = unit(1, "cm"))

# Bar Plot

df <- data.frame(
  variables = c("TV", "Fijos", "Radio", "Banda ancha", "Móviles"),
  values = c(88.4, 15.7, 6.3, 2.8, 2)
)

df |> 
  ggplot(aes(x = reorder(variables, -values), y = values)) +
  geom_col(fill = "#0099CC", col = "black", linewidth = 0.25, width = 0.5) +
  geom_text(aes(label = scales::comma_format(big.mark = ".", decimal.mark = ",")(values)), fontface = "bold", vjust = -0.5, family = "fira sans", col = "black", size = 4) +
  theme_minimal() +
  theme(axis.text = element_text(family = "fira sans", colour = "black", face = "bold", size = 12),
        panel.grid = element_blank(),
        axis.line = element_line(colour = "black", linewidth = 0.35),
        plot.margin = margin(t = 5, r = 30, b = 0,  l = -10)) +
  labs(x = "", y = "") +
  scale_y_continuous(limits = c(0, 102), expand = c(0, 0))
