library(tidyverse)

df <- readxl::read_xlsx("/Users/gasparsuliansky/Downloads/data.xlsx") |> janitor::clean_names() |> select(1:12)

dff <- df |>
  filter(colaboracion %in% c("1.0", "2.0") & orbita == "LEO" & !pais %in% c("Bolivia", "Venezuela"))

dff |> nrow()

dff$masa_kg <- as.numeric(dff$masa_kg)

mean_masa <- c()
for (i in unique(dff$pais)){
  mean_masa <- c(mean_masa, paste0(i,": ", dff |> 
    filter(pais == i) |>
    summarise(mean = mean(masa_kg, na.rm = T))))
}
mean_masa

mean_masa_total <- dff |>
  summarise(mean = mean(masa_kg))
mean_masa_total 

# Peso promedio > media: Argentina 
# Peso promedio < media: Bolivia, Brasil, Chile, Colombia, Costa Rica, Ecuador, Guatemala, México, Paraguay, Perú, Uruguay, Venezuela

total_masa <- c()
for (i in unique(dff$pais)){
  total_masa <- c(total_masa, paste0(i,": ", dff |> 
                               filter(pais == i) |>
                               summarise(total = sum(masa_kg, na.rm = T))))
}
total_masa

mean <- (9560.086 + 961 + 12.2 + 5 + 1 + 7 + 1 + 19.6 + 14 + 3.127 + 2) / 11
mean

# Peso total > media: Argentina
# Peso total < media: Brasil, Chile, Colombia, Costa Rica, Ecuador, Guatemala, México, Paraguay, Perú, Uruguay

dff$cant_de_instrumentos <- as.numeric(dff$cant_de_instrumentos)

mean_instr <- c()
for (i in unique(dff$pais)){
  mean_instr <- c(mean_instr, paste0(i,": ", dff |> 
                               filter(pais == i & cant_de_instrumentos != "NA") |>
                               summarise(mean = mean(cant_de_instrumentos, na.rm = T))))
}
mean_instr

mean <- dff |>
  summarise(sum = round(mean(cant_de_instrumentos, na.rm = T), 2))
mean

# # instrumentos promedio > media: Chile, Costa Rica, Ecuador, Paraguay, Uruguay
# # instrumentos promedio < media: Argentina, Brasil, Bolivia, Colombia, Guatemala, México, Perú, Venezuela

total_p <- c()
for (i in unique(dff$pais)){
  total_p <- c(total_p, paste0(i,": ", dff |> 
                                 filter(pais == i & cant_de_instrumentos != "NA") |>
                                 summarise(total = round(sum(cant_de_instrumentos, na.rm = T), 2))))
}
total_p

mean <- (106 + 30 + 19 + 3 + 3 + 6 + 1 + 12 + 3 + 9 + 5) / 11
mean

# # instrumentos total > media: Argentina, Brasil, Chile
# # instrumentos total < media: Colombia, Costa Rica, Ecuador, Guatemala, México, Paraguay, Perú, Uruguay

sats_p <- c()
for (i in unique(dff$pais)){
  sats_p <- c(sats_p, paste0(i,": ", dff |> 
                                 filter(pais == i) |>
                                 summarise(sats = n())))
}
sats_p

sats <- dff|>
  summarise(sats = n()/length(unique(dff$pais)))
sats

# # satélites total > media: Argentina, Brasil
# # satélites total < media: Bolivia, Chile, Colombia, Costa Rica, Ecuador, Guatemala, México, Paraguay, Perú, Uruguay, Venezuela


###

library(DiagrammeR)

graph <- grViz("
digraph {

graph [layout = neato,
       overlap = FALSE,
       splines = TRUE]

node [style = filled,
      shape = circle]

node [fillcolor = '#0099CCBF',
      color = '#0099CC80',
      fontsize = 20]
AR, BR, CH, CO, CR, EC, GU, ME, PA, PE, UR


node [fillcolor = '#00640080',
      color = '#00640080',
      height = 1.5
      width = 1.5,
      fontsize = 14]
'Peso promedio\n > media' '# promedio\n instrumentos\n > media' 'Peso total\n > media' '# total\n instrumentos\n > media' '# satélites\n > media'

node [fillcolor = '#8B000080',
      color = '#8B000080',
      height = 1.5,
      width = 1.5
      fontsize = 14]
'Peso promedio\n < media' '# promedio\n instrumentos\n < media' 'Peso total\n < media' '# total\n instrumentos\n < media' '# satélites\n < media'

edge [concentrate = TRUE,
      color = 'black',
      arrowhead = 'vee',
      penwidth = 1,
      style = dashed]
      
AR -> {'Peso promedio\n > media', '# promedio\n instrumentos\n < media', 'Peso total\n > media', '# total\n instrumentos\n > media', '# satélites\n > media'}
BR -> {'Peso promedio\n < media', '# promedio\n instrumentos\n < media', 'Peso total\n < media', '# total\n instrumentos\n > media', '# satélites\n > media'}
CH -> {'Peso promedio\n < media', '# promedio\n instrumentos\n > media', 'Peso total\n < media', '# total\n instrumentos\n > media', '# satélites\n < media'}
CO -> {'Peso promedio\n < media', '# promedio\n instrumentos\n < media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
CR -> {'Peso promedio\n < media', '# promedio\n instrumentos\n > media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
EC -> {'Peso promedio\n < media', '# promedio\n instrumentos\n > media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
GU -> {'Peso promedio\n < media', '# promedio\n instrumentos\n < media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
ME -> {'Peso promedio\n < media', '# promedio\n instrumentos\n < media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
PA -> {'Peso promedio\n < media', '# promedio\n instrumentos\n > media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
PE -> {'Peso promedio\n < media', '# promedio\n instrumentos\n < media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}
UR -> {'Peso promedio\n < media', '# promedio\n instrumentos\n > media', 'Peso total\n < media', '# total\n instrumentos\n < media', '# satélites\n < media'}

}")

graph

require(magrittr)
require(DiagrammeRsvg)
require(xml2)

graph %>%
  export_svg() %>%
  read_xml() %>%
  write_xml("graph.svg")

###

library(tidyverse)
library(ggflags)
library(ggbump)

data <- data.frame(
  country = c(rep("ar", 5),
              rep("br", 5),
              rep("cl", 5),
              rep("co", 5),
              rep("cr", 5),
              rep("ec", 5),
              rep("gt", 5),
              rep("mx", 5),
              rep("py", 5),
              rep("pe", 5),
              rep("uy", 5)),
  names = c(rep(c("Masa\npromedio", "Masa\ntotal", "Cantidad\npromedio de\ninstrumentos", "Cantidad\ntotal de\ninstrumentos", "Cantidad\nde satélites\nlanzados"), 11)),
  rank = c(1, 1, 6, 1, 1,
           2, 2, 8, 2, 2,
           5, 5, 1, 3, 4,
           6, 7, 10, 8, 7,
           9, 10, 3, 9, 8,
           8, 6, 4, 6, 5,
           10, 11, 11, 11, 9,
           4, 3, 7, 4, 3,
           3, 4, 5, 10, 10,
           11, 8, 9, 5, 6,
           7, 9, 2, 7, 11),
  unique = c(F, F, F, F, F,
             F, F, F, F, F,
             F, F, F, F, 2,
             F, F, F, 1, F,
             1, 1, 1, 1, 1,
             F, F, 1, F, 2,
             1, 1, F, F, 1,
             F, F, F, F, F,
             F, F, 1, 1, 1,
             F, F, F, F, 2,
             F, F, F, F, 1)
)

data$names <- factor(data$names, levels = c("Masa\npromedio", "Masa\ntotal", "Cantidad\npromedio de\ninstrumentos", "Cantidad\ntotal de\ninstrumentos", "Cantidad\nde satélites\nlanzados"))

ggplot(data, aes(names, rank, country = country, color = country, group = country)) +
  geom_bump(linewidth = 0.25, linetype = "dashed") +
  geom_point(color = ifelse(data$unique == 1, "black", "#00000000"), shape = "*", size = 3.5, position = position_nudge(0.15, 0.35)) +
  geom_point(color = ifelse(data$unique == 2, "black", "#00000000"), shape = "*", size = 3.5, position = position_nudge(0.15, 0.35)) +
  geom_point(color = ifelse(data$unique == 2, "black", "#00000000"), shape = "*", size = 3.5, position = position_nudge(0.2, 0.35)) +
  geom_flag(size = 7) +
  theme_minimal() +
  guides(color = "none") +
  labs(x = element_blank(), y = element_blank()) +
  theme(axis.text.y = element_text(colour = "black", family = "Times", size = 11),
        axis.text.x = element_text(colour = "black", family = "Times", size = 9),
        panel.grid = element_blank(),
        axis.line = element_line(colour = "black", linewidth = 0.25)) +
  scale_y_reverse(breaks = 1:11, labels = ~ paste0(.x, "°")) +
  scale_color_manual(values = c("#6CACE4", "#009739", "#DA291C", "#FFCD00", "#00205B", "#FFD100", "#4997D0", "#006341", "#D52B1E", "#C8102E", "#001489"))

ggsave("gráfico reseña.png", dpi = 320)
