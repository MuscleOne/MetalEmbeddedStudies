# module_1 to select samples in the sample sheet given a library
## helper ui 

#' A Shiny Module UI for Querying Body Weight in Rats Cohorts
#'
#' @description It is a shiny module ui designed for querying body weight data in rats cohorts determined via "Metal Implanted" and "Euthanized Month Post-implantation"  
#' @param id shiny id
#' @param df_data a big dataframe which contains information of body weight 
#'
#' @return return shiny input of "metal" and "euthanized month" selected by user
#' @export
#'
#' @examples
query_weight_cohorts_ui = function(id, df_data) {
  tagList(
    selectizeInput(NS(id, "metal_weight"), "metal implanted", 
                   choices = unique(df_data[, "metal_implanted"]), multiple = TRUE, 
                   options = list(placeholder = 'Show ALL')),
    selectizeInput(NS(id, "month_weight"), "euthanized month post-implantation", 
                   choices = sort(unique(df_data[, "euthanized_month_post_implantation"])), multiple = TRUE, 
                   options = list(placeholder = 'Show ALL'))
  )
}

#' A Shiny Module Server for Querying Body Weight in Rats Cohorts
#'
#' @description It is a shiny module server designed for querying body weight data in rats cohorts determined via "Metal Implanted" and "Euthanized Month Post-implantation"  
#' @param id shiny id 
#' @param df_data a big dataframe which contains information of body weight
#'
#' @return generate selected cohorts determined by metal and month post implantation, and the corresponding animal_id and weighting time points. 
#' @export 
#'
#' @examples
query_weight_cohorts_server = function(id, df_data) {
  moduleServer(id, 
               function(input, output, session) {
                 selected_metal_weight = reactive({
                   if(is.null(input$metal_weight)) {
                     unique(df_data[,"metal_implanted"])
                   } else {
                     input$metal_weight
                   }
                 })#selected_metal_weight
                 selected_month_weight = reactive({
                   if(is.null(input$month_weight)) {
                     unique(df_data[,"euthanized_month_post_implantation"])
                   } else {
                     input$month_weight
                   }
                 })#selected_month_weight
                 id_choices_weight = reactive({
                   df_data[
                     (df_data[,"metal_implanted"] %in% selected_metal_weight())&
                       (df_data[,"euthanized_month_post_implantation"] %in% selected_month_weight()), "animal_ID"]
                 })#id_choices_weight
                 
                 time_choices_weight = reactive({
                   df_data[
                     (df_data[,"metal_implanted"] %in% selected_metal_weight())&
                       (df_data[,"euthanized_month_post_implantation"] %in% selected_month_weight()), "weeks_post_implantation"]
                 })#id_choices_weight
                 
                 list(
                   selected_metal_weight = selected_metal_weight, 
                   selected_month_weight = selected_month_weight, 
                   id_choices_weight = id_choices_weight,
                   time_choices_weight = time_choices_weight
                 )
                 # output should be list(selected_metal_weight(), selected_month_weight()) and sort(unique(id_choices_weight())
               })#moduleServer
}
