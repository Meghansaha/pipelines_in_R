#=======Even Simpler Pipeline Docking Script Example=======#

#======================#
#Project Description====
#======================#

#This is an example of a "Docking Script". A term I use to define a centralized
#script that runs a series of modularized scripts/processes in a logical order.
#This is ONE possibility that can be used to start creating an even simple pipeline in
#R from start to finish#

#======================#
#Library Load In====
#======================#
library(dplyr) # For data wrangling
library(ggplot2) # For data vizzes
library(readxl) # For loading in Excel spreadsheets
library(janitor) # To keep things clean
library(here) # For easier directory referencing

#======================#
# Data Process Checks====
#======================#
#Program will check to see if any updates were made to the file after the first time it's ran during testing#
#If new data is found, a separate processing script is launched#
#After you run this the first time on your system, this will always remain "FALSE" until you add new data to the `survey_data.xlsx`
#File located in the data folder. This is intentional. 

data_updated <- FALSE

#Data Load in===
new_data <- read_excel(here("data/survey_data.xlsx"))

#Pulling in "Master" file to scan for any changes==
master_data <- readRDS("data/master_data.rds")

#Data "Validation"===
# Weak but quick "validation" to check for number of rows in "new" data compared to "master" data===
data_updated <- nrow(new_data) != nrow(master_data) 

#======================#
# Data Processing Work====
#======================#

# If data has changed, a separate processing program is launched. and a new master file is saved once it completes===
if(data_updated){
  source("scripts/processing_script.R")
}

#======================#
# Visualization Work====
#======================#
# Pipeline returns to the dock and launches a new script to make visuals if the data was updated===

#Visual Creation===
if(data_updated){
  source("scripts/viz_script.R")
}

#======================#
# Deliverable Rendering====
#======================#
# Pipeline returns to the dock and renders the associated Markdown report====
# In this example, the RMD script is not put into the "Scripts" folder like the more complicated example.
# This may be an easier solution for those that don't have a strong grasp of working directory nuances yet.
rmarkdown::render("reports/example_report.Rmd",
                  output_file = "example_report.html")

# Have the console open up the updated report===
browseURL(here("reports/example_report.html"))