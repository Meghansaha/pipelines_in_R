#======File Backup Function======#

#======================#
#Description====
#======================#

#A function for detecting previous version of a file, backing up older files and 
#saving new files in place after backups have been created. Your mileage may vary
#Experiment with caution in production as this relies on specific string matching
#For functionality

file_updater <-function(df, master_df){
  if(!is_tibble(df)){
    if(!is.data.frame(df)){
      stop("`file_updater` function requires a `tibble` or `dataframe input.")
    }
  }
  
  #merging new data with old data
  new_df <- rbind(master_df,df) 


#Checking to see if a current master back up file exists, if so, creating a new version, if not, backing up the current master
backup_exists <- file.exists(here(paste0("data/backup_data/master_geo-",Sys.Date(),".RDS")))

if(backup_exists){
  #Listing all geo files
  geo_files <- list.files(here(paste0("data/backup_data")))
  
  #Counting mastergeo files from today
  suffix <- sum(str_count(geo_files,paste0("master_geo-",Sys.Date()))) + 1
  
  invisible(file.copy(from = here("data/master_geo.RDS"),
                      to = here(paste0("data/backup_data/master_geo-",Sys.Date(),"-",suffix,".RDS")),
                      overwrite = FALSE))
} else{
  saveRDS(new_df,here(paste0("data/backup_data/master_geo-",Sys.Date(),".RDS")))
}

#Saving the "new" data as the "new" master (updating the old data)
saveRDS(new_df,here("data/master_geo.RDS"))
}