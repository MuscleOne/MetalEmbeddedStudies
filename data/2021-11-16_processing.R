# first of all, load the data and check the dataframe inside
rm(list = ls())

relative_path_prefix_data = "./data"
load(paste0(relative_path_prefix_data, "/", "treatedData.RData"))
load(paste0(relative_path_prefix_data, "/", "treatedSerumSmallRNA.RData"))
load(paste0(relative_path_prefix_data, "/", "animal_info_concentration_weight.RData"))
