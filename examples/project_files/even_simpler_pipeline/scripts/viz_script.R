#====== Visualization Script ======#

# Data Load-in===
games_data <- readRDS("data/new_data_games.rds")

# Making a visual for if people like games====
games_viz <- games_data %>%
  ggplot(aes(x = like_games))+
  geom_bar(stat = "count")

# Making a visual for if people like games====
games_viz <- games_data %>%
  ggplot(aes(x = like_games))+
  geom_bar(stat = "count", fill = c("darkred","darkgreen"), color = "black", size = 1) +
  labs(title = "Do People Like Video Games?", 
       x = NULL,
       y = "Number of Participants")+
  theme_minimal()+
  theme(axis.text = element_text( face = "bold", color = "black"),
        axis.title = element_text( face = "bold", color = "black"),
        plot.title = element_text(face = "bold", color = "black"))

# Saving the visual for the RMD
saveRDS(games_viz, "reports/plots/game_viz.rds")