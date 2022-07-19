#=======Viz Work Script=======#

#======================#
#Data Load-in====
#======================#

#Bringing in the updated master data set#
master_geo <- readRDS(here::here("data/master_geo.RDS"))

#Doing some wrangling to help filter out data for the intended map#
unique_countries <- unique(master_geo$country) 
unique_countries <- replace(unique_countries, unique_countries == "United States", "USA")
unique_countries <- c(unique_countries,"Puerto Rico")

#Grabbing spatial data for the map#
world <- map_data("world") %>%
  filter(region %in% unique_countries)

#======================#
#Visualizations 
#======================#

#Locations Map====

#Quick and Dirty map that is hard-coded for MY locations#
#If you add any not in these bounds, you will have to alter your x and y lims in `coord_map`#
location_map <- ggplot() +
  theme_void()+
  theme(plot.background = element_rect(fill = "#2784a1"))+
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "white", fill = "#144505", size = 0.1) +
  geom_point(
    data = master_geo,
    aes(long, lat), fill = "#ffffff", color = "#000000", size = 3, shape = 21, stroke = .5 ) +
  coord_map(xlim = c(-130,-60),
            ylim = c(10,50))

#======================#
#Visualization Save Out 
#======================#
ggsave(filename = here::here("images/rmd_map.png"),
       plot =location_map,
       device = "png",
       bg = "transparent")


#Removing objects that are no longer needed#
rm(location_map, master_geo, world, unique_countries)