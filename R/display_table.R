## 
#' Remove the "_" in the Column Names of a Dataframe
#'
#' @description a helper function to remove "_" in the column names of a dataframe
#' @param df a dataframe to be functioned 
#'
#' @return a new dataframe whose column names is updated
#' @export
#'
#' @examples
remove_sub = function(df){
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


#' A Shiny Module UI for Displaying a Dataframe as Table in the Frontend 
#'
#' @description a Shiny module UI for displaying a dataframe as table in the frontend
#' @param id shiny id
#'
#' @return shiny input
#' @export
#'
#' @examples
display_table_ui = function(id){
  reactableOutput(NS(id, "df"))
}

#' A Shiny Module Server for Displaying a Dataframe as Table in the Frontend 
#'
#' @description a Shiny module server for displaying a dataframe as table in the frontend
#' @param id shiny id 
#' @param df_table dataframe to be displayed 
#' @param remove_sub Logical, remove "_" in the column names of a dataframe if T. 
#'
#' @return 
#' @export
#'
#' @examples
display_table_server = function(id, df_table, remove_sub = T) {
  stopifnot(is.reactive(df_table))
  
  if (remove_sub==T){
    df_table_new = reactive(remove_sub(df_table())) # function to remove the "_" in the column name 
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
  } else {
    moduleServer(id, function(input, output, session){
      reactable_df_table = reactive({reactable(df_table(),
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
  } #else
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
# # remove_sub(df_test)
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


