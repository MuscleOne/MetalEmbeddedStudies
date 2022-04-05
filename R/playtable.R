## remove the "_" in the header
fn_remove_sub = function(df){
  df_1 = df
  vec_col_name = names(df)
  
  vec_col_name_new = rep(NA, length(vec_col_name))
  for (i in 1:length(vec_col_name)) {
    vec_col_name_new[[i]] = 
      paste(strsplit(vec_col_name, "_")[[i]], collapse=" ")
  }
  names(df_1) = vec_col_name_new
  return(df_1)
}


playtableUI = function(id){
  reactableOutput(NS(id, "df"))
}

playtableServer = function(id, df_table) {
  stopifnot(is.reactive(df_table))
  

  df_table_new = reactive(fn_remove_sub(df_table()))
  moduleServer(id, function(input, output, session){

    reactable_df_table = reactive({reactable(df_table_new(),
                                             searchable = TRUE,
                                             showPageSizeOptions = TRUE,
                                             paginationType = "jump",
                                             pageSizeOptions = c(8, 12, 16),
                                             defaultPageSize = 8,
                                             columns = list(
                                               gene_id = colDef(
                                                 sticky = "left",
                                                 # Add a right border style to visually distinguish the sticky column
                                                 style = list(borderRight = "1px solid #eee"),
                                                 headerStyle = list(borderRight = "1px solid #eee")
                                               )
                                             ),#columns
                                             defaultColDef = colDef(minWidth = 150))}
    )#reactive
    output$df = renderReactable({reactable_df_table()})
  }#function
  )# moduleServer
}

# 
# df_test = df_joint_weight[1:3, ]
# # animal_ID metal_implanted euthanized_month_post_implantation
# # 1         9              W.                                  3
# # 2         9              W.                                  3
# # 3         9              W.                                  3
# # weeks_post_implantation weight_value
# # 1                       6       424.74
# # 2                       3       376.01
# # 3                      10       462.80
# 
# # fn_remove_sub(df_test)
# 
# displayApp <- function(df = df_test) {
#   ui <- fluidPage(
#     playtableUI("dataset"),
#   )
#   server <- function(input, output, session) {
#     df = reactive(df_test)
#     playtableServer("dataset", df)
#   }
#   shinyApp(ui, server)
# }
# 
# displayApp()


  