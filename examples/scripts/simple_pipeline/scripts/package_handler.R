#=======Package Handler Script=======#

#===============================#
# Description====
#===============================#
# Used to check the user's environment for required packages
# Will install and load any necessary packages


# ========Can be used for isolated debugging======== #
# if (!require(pak, quietly = TRUE)) install.packages('pak')
# library(pak)
#====================================================#

#===============================#
# Loading in the package list====
#===============================#
package_list <- read.csv("./data/packages.csv", na.strings = "")
package_names <- unlist(package_list$package_name)

#===============================#
#Checking to see if any packages are already installed====
#===============================#

#Pulling out newly detected packages#
new_packages <- package_names[which(package_names %in% installed.packages() == FALSE)]
new_indices <- which(package_names %in% installed.packages() == FALSE)

#If new packages need to be installed, it will do so. If not, script ends#
if(length(new_packages) > 0){
  
  #Setting the new packages list#
  new_list <- package_list[new_indices,]
  
  ##CRAN Packages====
  cran_list <- new_list$package_name[which(new_list$cran == TRUE)]
  
  ##GitHub Packages====
  gh_paks <- new_list[which(new_list$github == TRUE),]
  gh_list <- paste(gh_paks$gh_user,gh_paks$package_name, sep = "/")
  
  
  #===============================#
  # Installing Packages With Pak====
  #===============================#
  
  ##CRAN Package Installs====
  if(length(cran_list) > 0){
    pkg_install(cran_list)
    
    #Removing byproduct from the environment#
    rm(cran_list)
  }
  
  ##GitHub Package Installs====
  if(length(gh_list > 0)){
    pkg_install(gh_list)
  
    #Removing byproduct from the environment#
    rm(gh_paks, gh_list)
  }

  #===============================#
  #Script Termination====
  #===============================#
  
  #Removing byproducts from the environment#
  rm(package_list, new_packages, new_indices, new_list)
  
  message("=================================
Package install is complete...loading packages... 🎉
=================================")
  
  #loading in packages for the rest of the workflow
  invisible(lapply(package_names, require, character.only = TRUE))  
  
} else {
  #Removing byproducts from the environment#
  rm(package_list, new_packages, new_indices)
  
  message("=================================
Your packages are up to date - No installs necessary... loading packages... 🎉
=================================")
  
  #loading in packages for the rest of the workflow
  invisible(lapply(package_names, require, character.only = TRUE))
  
}