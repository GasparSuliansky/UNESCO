library(DiagrammeR)
library(showtext)
font_add_google("Encode Sans", "Encode sans")
showtext_auto()

nodes <- create_node_df(
  n = 15,
  type = "numbered",
  label = c("Espacial", "Aeronáutica", "Automotriz", "Electrónica", "Defensa", "Energía", "Aerogeneradores", "Nuclear", "Radares", "Eléctrica", "Metalmecánica", "Tecnológica", "CONAE/VENG", "CEATSA", "UNLP"),
  fontname = "encode sans",
  fontweight = "bold", 
  fontsize = c(8, 8, 8, 7, 7, 7, 5.5, 5.5, 7, 5.5, 5.5, 5.5, rep(10.5, 3)),
  width = c(0.65, 0.65, 0.65, 0.5, 0.5, 0.5, 0.4, 0.4, 0.5, 0.4, 0.4, 0.4, rep(1, 3)),
  height = c(0.65, 0.65, 0.65, 0.5, 0.5, 0.5, 0.4, 0.4, 0.5, 0.4, 0.4, 0.4, rep(1, 3)),
  color = c("#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC", "#0099CC", "#0099CC"),
  fillcolor = c("#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC80", "#0099CC", "#0099CC", "#0099CC"),
  fontcolor = "black",
  penwidth = 0.5
    )

nodes$fillcolor <- adjustcolor(nodes$fillcolor, alpha.f = 0.9)
nodes$color <- adjustcolor(nodes$color, alpha.f = 0.4)

edges <- create_edge_df(
  from = c(13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15),
  to = c(1, 2, 3, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 10, 4, 11, 9, 5, 6),
  color = "grey20",
  penwidth = 0.25,
  arrowhead = "none",
  )
      
graph <- create_graph(nodes_df = nodes, edges_df = edges)
            
render_graph(graph)
