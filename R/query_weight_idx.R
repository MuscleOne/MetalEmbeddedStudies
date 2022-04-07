# module_1 to select samples in the sample sheet given a library
# controlled

## helper ui 

#' A Shiny Module UI for Querying Body Weight Records in Custom Rats Cohorts
#'
#' @description Using selected animal ID or weighting time points as input, to find out records which is satisfied with the query.
#' @param id shiny id
#' @param df_data a big dataframe which contains information of body weight 
#' @param label "animal id" or "weighting time"
#' @param col "animal_ID" or "weeks_post_implantation", used to select a column of the input dataframe
#'
#' @return
#' @export
#'
#' @examples
query_weight_idx_ui = function(id, df_data, label, col) {
  tagList(
    selectizeInput(NS(id, "controlled_col"), label, 
                   choices = sort(unique(df_data[, col])), multiple = TRUE, 
                   options = list(placeholder = 'Show ALL')),
  )
}

#' A Shiny Module Server for Querying Body Weight Records in Custom Rats Cohorts
#'
#' @description Update the animal ID or weighting time points according to the selected metal and month post implants. 
#' @description Using selected animal ID or weighting time points as input, to find out records which is satisfied with the query. 
#' @param id shiny id
#' @param df_data a big dataframe which contains information of body weight 
#' @param metal the selected metal, provided by the previous model query_weight_cohort
#' @param month the selected month, provided by the previous model query_weight_cohort
#' @param l_choices animal_id or weighting time point, which used to define the custom cohorts together
#'
#' @return return selected records, TRUE or FALSE. 
#' @export
#'
#' @examples
query_weight_idx_server = function(id, df_data, metal, month, l_choices) {
  moduleServer(id, 
               function(input, output, session) {
                 #### input of the controlled (dynamically updated) animal_id list ####
                 stopifnot(is.reactive(metal))
                 stopifnot(is.reactive(month))
                 stopifnot(is.reactive(l_choices))
                 
                 observeEvent( list(metal(), month()), {
                   updateSelectizeInput(session, "controlled_col", 
                                        choices=sort(unique(l_choices()))
                   )# updateSelectizeInput
                 })#observeEvent
                 
                 reactive({
                   if(is.null(input$controlled_col)) {
                     unique(unique(l_choices()))
                   } else {
                     input$controlled_col
                   }
                 }) #return one reactive result: selected element in the given column
               })#moduleServer
}



