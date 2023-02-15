install.packages(c("tidyverse", "showtext"))
library(tidyverse)
library(showtext)
font_add_google("Encode Sans", family = "Encode Sans")
showtext_auto()

df <- data.frame(
  sat = c("SAC-B (LEO)", "SAC-A (LEO)", "SAC-C (SSO)", "SAC-D / Aquarius (SSO)", "ARSAT 1 y 2 (GEO)", "SAOCOM 1 A y B (SSO)"),
  comp = c(0, 1, 2.5, 5, 6, 7),
  int = c(0, 1.25, 2.5, 4.5, 2, 7)
)

df |>
  ggplot(aes(x = comp, y = int)) +
  geom_point(shape = 18, size = 6, col = "#0099CCCC", alpha = 0.8) +
  geom_text(aes(label = sat), size = 3, nudge_y = 0.45) +
  geom_line(data = data.frame(x = c(3.5, 3.5), y = c(-1, 8)), aes(x = x, y = y), arrow = arrow(ends = "both", length = unit(0.2, "cm")), linewidth = 0.3) +
  geom_line(data = data.frame(x = c(-1, 8), y = c(3.5, 3.5)), aes(x = x, y = y), arrow = arrow(ends = "both", length = unit(0.2, "cm")), linewidth = 0.3) +
  theme_minimal() +
  theme(panel.grid = element_blank(),
        text = element_text(family = "Encode Sans", colour = "black", size = 12),
        axis.title = element_text(family = "Encode Sans", colour = "black", face = "bold", size = 9),
        axis.text = element_blank(),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        plot.caption = element_text(hjust = 0)) +
  xlab("Complejidad tecnológica") + ylab("Valor de integración local")
