# rm(list=ls())
##############################
### to load some source data in the /data file
relative_path_prefix_data = "./data"
# load the expression data and the corresponding sample information
load(paste0(relative_path_prefix_data, "/", "2021-11-29_l_sample_exprs_libraries.RData"))
# load the splited concentration data
load(paste0(relative_path_prefix_data, "/", "2021-11-25_splited_con_data.RData"))
# load the latest treated weight data
load(paste0(relative_path_prefix_data, "/", "2021-11-25_weight_data.RData"))

################################
### to load some source code in the /R file
relative_path_prefix_R = "R"

########## general functions ###################################################
# load the download sub-app
source(paste0(relative_path_prefix_R, "/", "download.R"))
# load the function to improve the frontend display
source(paste0(relative_path_prefix_R, "/", "fn_display_sample.R"))
# load a sub-app to display the query results as tables
source(paste0(relative_path_prefix_R, "/", "playtable.R"))

###### sub-app of bussiness logic ##############################################
###### expression case ######
# sub-app to select sample from given dataset of studies
source(paste0(relative_path_prefix_R, "/", "selectVar.R"))
# sub-app to select sample and the corresponding expression value and respond results
source(paste0(relative_path_prefix_R, "/", "selectDataVar.R"))

###### weight case #####
# sub-app to select metal and month, and constrained id and weeks, and provides results df
source(paste0(relative_path_prefix_R, "/", "selectMetalMonth.R"))
# dynamical constrain of id and weighting weeks under metal and month 
source(paste0(relative_path_prefix_R, "/", "selectListControl.R"))

###### concentration case ######
# sub-app to dynamically query different kinds of concentration data
source(paste0(relative_path_prefix_R, "/", "datasetCon.R"))
# helps functions to query different kinds of concentration data at server side
source(paste0(relative_path_prefix_R, "/", "fn_con_server.R"))


###############################
### some code prepared for frontend display
l_sample = l_sample_exprs_libraries$l_sample
l_exprs = l_sample_exprs_libraries$l_exprs
name_libraries = l_sample_exprs_libraries$name_libraries

################################
### html in the frontend
# relative_path_prefix_html = "html"





