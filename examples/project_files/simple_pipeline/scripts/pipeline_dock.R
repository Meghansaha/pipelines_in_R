#=======Simple Pipeline Docking Script Example=======#

#======================#
#Project Description====
#======================#

#This is an example of a "Docking Script". A term I use to define a centralized
#script that runs a series of modularized scripts/processes in a logical order.
#This is ONE possibility that can be used to start creating a simple pipeline in
#R from start to finish#

#======================#
#Library Load In====
#======================#
#You can manage and track a list of needed packages by containing the info in a
#separate file. "data/packages.csv"

#Checking for pak package. Installing and loading if not found
if (!require(pak, quietly = TRUE)) install.packages('pak')
library(pak)

#Using a modularized package handler script "scripts/package_handler.R"
#to install and load-in necessary libraries
source("./scripts/package_handler.R")

#Loaded packages will be stored in the "package_names" vector in the environment

#======================#
#Data Load In====
#======================#
#This can look different depending on the type of data you need to load in.
#This example uses simple csv and RDS files that are already in the directory.
#This could be replaced with different file types and sources such as
#Google Drive, Google cloud platform, various APIs, and even a SQL database.

#"Master" data can be thought of as your existing database from previously ran
#scripts that compiled successfully. You should always make backups of previous
#master data sets before you update it with new data.

#Adding a logic variable to let us know if any data was updated, FALSE is the default
data_updated <- FALSE

#Loading in a "master" data file - A file of pre-existing data.
master_locations <- readRDS(here("data/master_EXAMPLE_locations.RDS"))

#Loading in some "current" data to process
current_locations <- read_csv(here("data/locations.csv"), show_col_types = FALSE) %>%
  arrange(year) %>%
  mutate(year = fct_inorder(as.character(year)),
         across(city:country, ~str_to_title(.)))

#Checking to see if new data is present in the "current" data set as compared to 
#the "master" data set. "new_data" object will only have new data in it
new_locations <- anti_join(current_locations, master_locations)

#Updating the logic variable only if new data was detected
if(nrow(new_locations) > 0){
  data_updated <- TRUE
}


#If new data was detected, the geoprocessing and visualization scripts will be 
#triggered and a new flexdashboard and RMarkdown report will be created. If not,
#the program will let the user know that no updates were found so that the program
#will complete.

if(data_updated){
  
#======================#
#Geoprocessing====
#======================#

#If new data was detected, the workflow will trigger the geoprocessing script
#"scripts/geo_script.R For the new data ONLY. This is helpful if 
#using a paid API?geoprocessing service Like Google maps. This example uses 
#the free tidygeocoder package, so explore away.

source(here("scripts/geo_script.R"))
  
#When geoprocesing is completed, the workflow will return to this script and launch
#the visualization script
  
#======================#
#Visualizations====
#======================#
  
source(here("scripts/viz_script.R"))
  
#======================#
#Deliverable Rendering====
#======================#

#This launches the RMD script that makes the HTML report#
rmarkdown::render(here::here("scripts/deliverable_script.rmd"), #The RMD Script we want to run
                  output_dir = here::here("reports"), #The folder/file path we want the finished report to go to
                  output_file = here::here("reports/travel_log.html"), #Setting the actual file name of the report
                  intermediates_dir = here::here()) #Making sure the the intermediate files like images, stay put in our main directory

# This opens up the HTML report to confirm it has worked/compiled#
browseURL(here::here("reports/travel_log.html"))

} else{
  message("No new data was detected.\nDeliverables should already be up to date.")
}

# This opens up the HTML report to confirm it has worked/compiled#
browseURL(here::here("reports/travel_log.html"))

#Assuming the program got to this point without error, this removes all other objects that was created from the environment.
rm(current_locations, geo_table_data, master_geo, master_locations, new_locations, package_names)