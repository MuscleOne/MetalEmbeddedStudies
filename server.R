## server.R

library(shiny)

shinyServer(function(input, output, session) {
  
  ## >>>>
  ##### backend: about the homepage ##########
  observeEvent(input$jump_to_expression, {
    updateTabsetPanel(session, "intabset", selected = "expression")
  })
  
  observeEvent(input$jump_to_concentration, {
    updateTabsetPanel(session, "intabset", selected = "concentration")
  })
  
  observeEvent(input$jump_to_weight, {
    updateTabsetPanel(session, "intabset", selected = "weight")
  })
  ##### backend: about the homepage ##########
  
  
  ## >>>>
  ##### backend: to query data of serum small RNAs and the samples ##########
  # obtain a table of selected data/metadata, as well as condition we used
  treat_data = selectDataVarServer("condt")
  
  # dataframe table of sample information and expression matrix
  df_sample = treat_data$treat_sample
  df_exprs = treat_data$treat_exprs
  
  # what condition we used to make query
  the_library = treat_data$library_condt
  time = treat_data$time_condt
  metal = treat_data$metal_condt
  
  # the display form of the selected sample data
  display_sample = reactive({fn_display_sample(df_sample())})
  # display the data of sample information as well as expression
  playtableExprsServer("sample", display_sample)
  
  ##
  observe(print(df_sample()[1:5, 2]))
  # observe(print(df_exprs()[1:5, ]))
  
  playtableExprsServer("exprs", df_exprs)
  # have a look of conditions we used to make query
  output$condition = renderPrint(list(time(), metal(), the_library()))
  
  # the download function
  downloadServer("sample", df_sample, the_library, metal=metal, month=time, download_item="sample_info")
  downloadServer("exprs", df_exprs, the_library, metal=metal, month=time, download_item="exprssion_matrix")
  ###### backend: to query data of serum small RNAs and the samples ##########
  ## <<<<
  # 
  # ## >>>>
  ################# backend: weight information #######################
  
  #### input of metal, month and then control the "animal_id" and "time point" list ####
  l_selected_condt = selectMetalMonthServer(id="weight", df_data=df_joint_weight)
  
  # obtain the selected metal, month, and constrained id and time points lists
  selected_metal_weight = l_selected_condt$selected_metal_weight
  selected_month_weight = l_selected_condt$selected_month_weight
  id_choices_weight = l_selected_condt$id_choices_weight
  time_choices_weight = l_selected_condt$time_choices_weight
  
  #### input of the controlled (dynamically updated) list ####
  # the selected id under constrain of month and metal
  selected_id_weight = selectListControlServer(id="animal_id_weight",
                                               df_data=df_joint_weight, metal=selected_metal_weight, month=selected_month_weight, l_choices=id_choices_weight)
  # selected_id_weight = l_selected_id_weight$selected_controlled_col
  
  # the selected time points under constrain of month and metal
  selected_points = selectListControlServer(id="weeks_post_implantation",
                                            df_data=df_joint_weight, metal=selected_metal_weight, month=selected_month_weight, l_choices=time_choices_weight)
  ####
  
  
  #### generate a dataframe to be displayed and downloaded ####
  df_weight_info = reactive({
    df_joint_weight[(df_joint_weight[,"animal_ID"] %in% selected_id_weight())&
                      (df_joint_weight[,"weeks_post_implantation"] %in% selected_points()), ]
  })
  
  playtableServer("weight_play", df_weight_info)
  
  weight_info = reactive({
    weight_info = "information_of"
    weight_info
  })
  
  downloadServer("download_weight", df_weight_info, weight_info,
                 metal=selected_metal_weight, month=selected_month_weight, download_item="weight")
  #####
  
  ################# backend: weight information #######################
  ## <<<<
  
  # ## >>>>
  # ################# backend: concentration information #######################
  
  l_concentration_info = datasetConServer("data")
  
  df_concentration_info = l_concentration_info$df_concentration_info
  selected_metal_3 = l_concentration_info$selected_metal_3
  selected_month_3 = l_concentration_info$selected_month_3
  
  playtableServer("concentration_play", df_concentration_info)
  
  concentration_info = reactive({
    concentration_info = "information_of"
    concentration_info
  })
  
  downloadServer("download_concentration", df_concentration_info, concentration_info,
                 metal=selected_metal_3, month=selected_month_3, download_item="concentration")
  
  # ################# backend: concentration information #######################
  # ## <<<<
})
