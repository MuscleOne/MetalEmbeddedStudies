###############################
### to load some source data in the /data file
relative_path_prefix_data = "./data"
load(paste0(relative_path_prefix_data, "/", "treatedData.RData"))
load(paste0(relative_path_prefix_data, "/", "treatedSerumSmallRNA.RData"))
load(paste0(relative_path_prefix_data, "/", "animal_info_concentration_weight.RData"))
# load("treatedData.RData")
# load("treatedSerumSmallRNA.RData")
# load("animal_info_concentration_weight.RData")
################################
### to load some source code in the /R file
relative_path_prefix_R = "R"
# serumSmallRNA_files = list.files(relative_path_prefix)
# [1] "app.R"               "dataset.R"           "download.R"         
# [4] "fn_display_sample.R" "playtable.R"         "selectDataVar.R"    
# [7] "selectVar.R"
source(paste0(relative_path_prefix_R, "/", "dataset.R"))
source(paste0(relative_path_prefix_R, "/", "download.R"))
source(paste0(relative_path_prefix_R, "/", "fn_display_sample.R"))
source(paste0(relative_path_prefix_R, "/", "playtable.R"))
source(paste0(relative_path_prefix_R, "/", "selectDataVar.R"))
source(paste0(relative_path_prefix_R, "/", "selectVar.R"))

###############################
### some code prepared for frontend display
l_sample = list(); l_exprs = list();
l_sample = list(serum_miRNA_sample, serum_tRNA_sample, serum_rRNA_sample, mRNA_seq_sample, mRNA_array_sample)
l_exprs = list(serum_miRNA_exprs, serum_tRNA_exprs, serum_rRNA_exprs, mRNA_seq_exprs, mRNA_array_exprs)

name_libraries = c("serum_miRNA", "serum_tRNA", "serum_rRNA", "mRNA_seq", "mRNA_array")

names(l_sample) = name_libraries
names(l_exprs) = name_libraries

################################
### html in the frontend
# relative_path_prefix_html = "html"





