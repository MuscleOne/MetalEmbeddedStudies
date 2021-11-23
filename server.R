## server.R

library(shiny)

shinyServer(function(input, output, session) {
  
  # output$distPlot <- renderPlot({
  #   
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2]
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
  #   
  # })
  # >>>>
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
  playtableServer("sample", display_sample)
  playtableServer("exprs", df_exprs)
  # have a look of conditions we used to make query
  output$condition = renderPrint(list(time(), metal(), the_library()))

  # the download function
  downloadServer("sample", df_sample, the_library, metal=metal, month=time, download_item="sample_info")
  downloadServer("exprs", df_exprs, the_library, metal=metal, month=time, download_item="exprssion_matrix")
  ###### backend: to query data of serum small RNAs and the samples ##########
  ## <<<<

  ## >>>>
  ################# backend: weight information #######################
  selected_metal_2 = reactive({
    if(is.null(input$metal_2)) {
      unique(df_sample_info_pheno[,"metal_embodied"])
    } else {
      input$metal_2
    }
  })

  selected_month_2 = reactive({
    if(is.null(input$month_2)) {
      unique(df_sample_info_pheno[,"euthanized_period"])
    } else {
      input$month_2
    }
  })

  ### to update the input component of range of animal id ###
  id_choices_2 = reactive({
    df_sample_info_pheno[
      (df_sample_info_pheno[,"metal_embodied"] %in% selected_metal_2())&
        (df_sample_info_pheno[,"euthanized_period"] %in% selected_month_2()), "animal_ID"]
  })

  observeEvent( list(selected_metal_2(), selected_month_2()), {
    updateSelectInput(session, "animal_id_2",
                      choices=sort(unique(id_choices_2()))
    )# updateSelectInput
  })

  ### to update the input component of range of weighting time point ###
  weighting_time = reactive({
    df_joint_weight[
      (df_joint_weight[,"metal_embodied"] %in% selected_metal_2())&
        (df_joint_weight[,"euthanized_period"] %in% selected_month_2()), "time_point"]
  })

  observeEvent( list(selected_metal_2(), selected_month_2()), {
    updateSelectInput(session, "time_point",
                      choices=sort(unique(weighting_time()))
    )# updateSelectInput
  })


  selected_id_2 = reactive({
    if(is.null(input$animal_id_2)) {
      unique(unique(id_choices_2()))
    } else {
      input$animal_id_2
    }
  })

  selected_points = reactive({
    if(is.null(input$time_point)) {
      unique(weighting_time())
    } else {
      input$time_point
    }
  })

  df_weight_info = reactive({
    df_joint_weight[(df_joint_weight[,"animal_ID"] %in% selected_id_2())&
                      (df_joint_weight[,"time_point"] %in% selected_points()), ]
  })

  playtableServer("weight", df_weight_info)
  # output$weight <- renderPrint({
  #   df_weight_info()
  # })

  weight_info = reactive({
    weight_info = "information_of"
    weight_info
  })

  downloadServer("download_weight", df_weight_info, weight_info,
                 metal=selected_metal_2, month=selected_month_2, download_item="weight")
  ################# backend: weight information #######################
  ## <<<<

  ## >>>>
  ################# backend: concentration information #######################
  selected_metal_3 = reactive({
    if(is.null(input$metal_3)) {
      unique(df_sample_info_pheno[,"metal_embodied"])
    } else {
      input$metal_3
    }
  })

  selected_month_3 = reactive({
    if(is.null(input$month_3)) {
      unique(df_sample_info_pheno[,"euthanized_period"])
    } else {
      input$month_3
    }
  })
  id_choices_3 = reactive({
    df_sample_info_pheno[
      (df_sample_info_pheno[,"metal_embodied"] %in% selected_metal_3())&
        (df_sample_info_pheno[,"euthanized_period"] %in% selected_month_3()), "animal_ID"]
  })

  observeEvent( list(selected_metal_3(), selected_month_3()), {
    updateSelectInput(session, "animal_id_3",
                      choices=sort(unique(id_choices_3()))
    )# updateSelectInput
  })

  selected_id_3 = reactive({
    if(is.null(input$animal_id_3)) {
      unique(unique(id_choices_3()))
    } else {
      input$animal_id_3
    }
  })

  selected_measure = reactive({
    if(is.null(input$measure_type)) {
      unique(df_joint_concentration[,"measure_type"])
    } else {
      input$measure_type
    }
  })

  df_concentration_info = reactive({
    df_joint_concentration[(df_joint_concentration[,"animal_ID"] %in% selected_id_3())&
                             (df_joint_concentration[,"measure_type"] %in% selected_measure()), ]
  })

  playtableServer("concentration", df_concentration_info)

  concentration_info = reactive({
    concentration_info = "information_of"
    concentration_info
  })

  downloadServer("download_concentration", df_concentration_info, concentration_info,
                 metal=selected_metal_3, month=selected_month_3, download_item="concentration")
  ################# backend: concentration information #######################
  ## <<<<
})