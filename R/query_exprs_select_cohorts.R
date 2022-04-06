# module_1 to select samples in the sample sheet given a library
## helper ui 
# strsplit(vec_col_name, "_")

#' Title
#'
#' @param id a dataframe of the selected sample information, which is used to update the choice list 
#' @param characteristics characteristics of the cohorts, "month_post_implantation" or "metal_implanted"
#'
#' @return
#' @export
#'
#' @examples
query_exprs_select_cohorts_ui <- function(id, characteristics="month_post_implantation") {
  selectizeInput(NS(id, "char"), 
                 paste(strsplit(characteristics, "_")[[1]], collapse=" "), 
                 choices = NULL, multiple = TRUE, 
                 options = list(placeholder = 'Show ALL')) 
}

#' Title
#'
#' @param id shiny id
#' @param data a dataframe of the selected sample information, which is used to update the choice list  
#' @param characteristics characteristics of the cohorts, "month_post_implantation" or "metal_implanted"
#'
#' @return
#' @export
#'
#' @examples
query_exprs_select_cohorts_server = function(id, data, characteristics="month_post_implantation") {
  stopifnot(is.reactive(data))
  moduleServer(id, 
               function(input, output, session) {
                 observeEvent(data(), {
                   updateSelectizeInput(session, "char", 
                                        choices=sort(unique(data()[, paste0(characteristics)])))
                 })
                 
                 # the key commend to select the column in the input table we want!
                 list(cohort_condt = reactive({ 
                   if(is.null(input$char)) {
                     data()[, paste0(characteristics)] %in% unique(data()[, paste0(characteristics)])
                   } else {
                     data()[, paste0(characteristics)] %in% input$char
                   }
                 }),#cohort_condt
                 cohort_selectinput = reactive(input$char)
                 )
               })
}
