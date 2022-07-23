#=======Geoprocessing Script=======#

#===============================#
# Description====
#===============================#
# Used to geocode locations with the tidygeocoder package for mapping.

# ========Can be used for isolated debugging======== #
# geo_packages <- c("dplyr", "here", "readr", "tidygeocoder")
# invisible(lapply(geo_packages, require, character.only = TRUE))
# new_locations <- read_csv(here("data/master_locations.csv"), show_col_types = FALSE)
#====================================================#


#===============================#
# Geocoding====
#===============================#

new_geo <- new_locations %>%
  geocode(city = city,
      state = state,
      country = country,
      limit = 1)

#===============================#
# Data merging and write-out====
#===============================#

# Pulling in a custom function ("functions/file_updater.R") to check for backup master files
# and update the master file
source(here("functions/file_updater.R"))

#Pulling in the "master" geo dataset (data that was already geocoded in a past session)
master_geo <- readRDS(here("data/master_EXAMPLE_geo.RDS"))

#Using the function for the "new_geo" dataframe
file_updater(new_geo,master_geo)
  
# Friendly message to console
message("Updated data is now in `data/master_geo.RDS`")

#Removing secondary (not needed) objects from the environment#
rm(master_geo,new_geo, file_updater)