#====== Data Processing for Surveys ======#

# Data Transformation ====
#New data is copied into a "mod" data frame for processing===
new_data_mod <- new_data %>%
  clean_names() %>%
  mutate("participant_id" = as.character(row_number())) %>% #Making up an ID number for each person
  rename("age" = "how_old_are_you",
         "like_games" = "do_you_like_to_play_video_games",
         "game_types" = "what_kind_of_games_do_you_like",
         "music_genres" = "what_are_some_music_genres_that_you_like",
         "fav_artist" = "whos_your_favorite_artist") %>% #Renaming vars for easier plots/RMD
  relocate(participant_id, .before = "age") %>% #I'm just anal about IDs being first
  mutate(age = factor(age, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "Over 65")))

#Missing values are recoded===
new_data_mod2 <- new_data_mod %>%
  mutate(across(!where(is.factor), ~ifelse(is.na(.),"Not Reported",.)))

#Comma separated values are parsed out to create different data frames===
#Music Data===
new_data_music <- new_data_mod2 %>%
  select(-contains("game")) %>%
  separate_rows(music_genres)

#Pulling out unique artists
unique_artists <- unique(new_data_music$fav_artist)

#Games Data===
new_data_games <- new_data_mod2 %>%
  select(-contains(c("artist","music","types"))) 

#Saving needed data files for staging in the visualization script====
saveRDS(new_data_music, "data/new_data_music.rds")
saveRDS(new_data_games, "data/new_data_games.rds")
saveRDS(unique_artists, "data/fav_artists.rds")

#Save the new copy as a master file. Replaces old master file as well before override
file.rename(from = "data/master_data.rds",
            to = "data/old_master_data.rds")

saveRDS(new_data, "data/master_data.rds")

#Removing added objects from the environment====
message("Processing Script Executed and Completed. Returning to Dock...")
  