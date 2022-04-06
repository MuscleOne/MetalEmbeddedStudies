#### module: query_exprs_select_studies ######
# module to choose the suitable dataset by libraries/studies, i.e., serum_miRNA

#' title query_exprs_select_studies_ui 
#'
#' @param id shiny id
#' @param dataset_label label of the item, dataset_label="Studies"
#' @param dataset_choices the name of the transcription studies, e.g. "serum_miRNA", "serum_tRNA"
#'
#' @return 
#' @export
#'
#' @examples
query_exprs_select_studies_ui = function(id, dataset_label, dataset_choices) {
  selectInput(NS(id, "dataset"), dataset_label, choices = dataset_choices)
}

#' title query_exprs_select_studies_server
#' @param id shiny id
#'
#' @return a list with three element, dataframe: selected_sample, selected_exprs, and a vector: selected_library
#' @export
#'
#' @examples
query_exprs_select_studies_server = function(id) {
  moduleServer(id, function(input, output, session) {
    list(selected_sample = reactive(l_sample[[input$dataset]]), 
         selected_exprs = reactive(l_exprs[[input$dataset]]),
         selected_library = reactive(input$dataset)
    )
  })#moduleServer
}
