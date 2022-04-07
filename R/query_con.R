# module to choose the suitable dataset by libraries

#' A Shiny Module UI End for Querying Data Related to Metal Concentrations
#' @description A shiny module ui, is designed for display the query option, dependent on which concentration types you selected. 
#' @param id shiny id
#' @param dataset_label "concentration types"
#' @param dataset_choices "creatinine_concentration", "absolute_metal_concentration" or "related_metal_concentration"
#'
#' @return input data would be transport to the server end of the module
#' @export
#'
#' @examples
query_con_ui = function(id, dataset_label="concentration types", 
                        dataset_choices=vec_type_choices) {
  tagList(
    selectizeInput(NS(id, "con_types"), dataset_label, dataset_choices),
    # parameter_tabs
    tabsetPanel(
      id = NS(id, "params"),
      type = "hidden",
      tabPanel("creatinine_concentration",
               selectizeInput(NS(id, "metal_1"), "metal implanted", 
                              choices = unique(df_creatinine_con[, "metal_implanted"]), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "month_1"), "euthanized month post-implantation", 
                              choices = sort(unique(df_creatinine_con[, "euthanized_month_post_implantation"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "animal_id_1"), "animal id", choices = sort(unique(df_creatinine_con[, "animal_ID"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL'))
      ),#tabPanel: creatinine concentration
      tabPanel("absolute_metal_concentration",
               selectizeInput(NS(id, "metal_2"), "metal implanted", 
                              choices = unique(df_abs_con[, "metal_implanted"]), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "month_2"), "euthanized month post-implantation", 
                              choices = sort(unique(df_abs_con[, "euthanized_month_post_implantation"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "animal_id_2"), "animal id", choices = sort(unique(df_abs_con[, "animal_ID"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "measure_tissue_2"), "measure tissue",
                              choices = sort(unique(df_abs_con[, "measure_tissue"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL'))
      ),#tabPanel: absolute metal concentration
      tabPanel("related_metal_concentration",
               selectizeInput(NS(id, "metal_3"), "metal implanted", 
                              choices = unique(df_related_con[, "metal_implanted"]), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "month_3"), "euthanized month post-implantation", 
                              choices = sort(unique(df_related_con[, "euthanized_month_post_implantation"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "animal_id_3"), "animal id", choices = sort(unique(df_related_con[, "animal_ID"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL')),
               selectizeInput(NS(id, "measure_tissue_3"), "measure tissue",
                              choices = sort(unique(df_related_con[, "measure_tissue"])), multiple = TRUE, 
                              options = list(placeholder = 'Show ALL'))
      )#tabPanel: related metal concentration
    )#tabsetPanel
  )
}

#' A Shiny Module Server End for Querying Data Related to Metal Concentrations
#'
#' @description a shiny module server end for querying the metal related data and return the querying condition as well as the filtered records
#' @param id shiny id
#'
#' @return a list with three items, selected_metal, selected_month, and df_display
#' @export
#'
#' @examples
query_con_server = function(id) {
  moduleServer(id, 
               function(input, output, session) {
                 observeEvent(input$con_types, {
                   updateTabsetPanel(session, inputId = "params", selected = input$con_types)
                 }) #observeEvent
                 
                 df_display_1 = query_con_creatinine_server(df_creatinine_con, input, output, session)$df_concentration_info
                 df_display_2 = query_con_abs_server(df_abs_con, input, output, session)$df_concentration_info
                 df_display_3 = query_con_related_server(df_related_con, input, output, session)$df_concentration_info
                 
                 df_display = reactive({
                   switch(input$con_types,
                          creatinine_concentration = df_display_1(),
                          absolute_metal_concentration = df_display_2(),
                          related_metal_concentration = df_display_3()
                   )#switch
                 })#df_display
                 # 
                 
                 selected_metal_1 = query_con_creatinine_server(df_creatinine_con, input, output, session)$selected_metal
                 selected_metal_2 = query_con_abs_server(df_abs_con, input, output, session)$selected_metal
                 selected_metal_3 = query_con_related_server(df_related_con, input, output, session)$selected_metal
                 
                 selected_metal = reactive({
                   switch(input$con_types,
                          creatinine_concentration = selected_metal_1(),
                          absolute_metal_concentration = selected_metal_2(),
                          related_metal_concentration = selected_metal_3()
                   )#switch
                 })#selected_metal
                 
                 selected_month_1 = query_con_creatinine_server(df_creatinine_con, input, output, session)$selected_month
                 selected_month_2 = query_con_abs_server(df_abs_con, input, output, session)$selected_month
                 selected_month_3 = query_con_related_server(df_related_con, input, output, session)$selected_month
                 
                 selected_month = reactive({
                   switch(input$con_types,
                          creatinine_concentration = selected_month_1(),
                          absolute_metal_concentration = selected_month_2(),
                          related_metal_concentration = selected_month_3()
                   )#switch
                 })#selected_month
                 
                 list(
                   selected_metal = selected_metal, 
                   selected_month = selected_month, 
                   df_concentration_info = df_display
                 )
               })#moduleServer
}



