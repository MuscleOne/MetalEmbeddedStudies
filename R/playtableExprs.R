### when we obtain a dataframe (table), then we want to display and download it
## to write two module

## module to display the table, in this case we use reactable, with df_data as input
playtableExprsUI = function(id){
  reactableOutput(NS(id, "df"))
}
playtableExprsServer = function(id, df_table) {
  stopifnot(is.reactive(df_table))
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
}


