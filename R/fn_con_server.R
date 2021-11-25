################### df_creatinine_con case #####################################
fn_creatinine_con_server = function(df_input=df_creatinine_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal_3 = reactive({
    if(is.null(input$metal_1)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_1
    }
  })
  
  selected_month_3 = reactive({
    if(is.null(input$month_1)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_1
    }
  })
  
  id_choices_3 = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal_3())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month_3()), "animal_ID"]
  })
  
  observeEvent( list(selected_metal_3(), selected_month_3()), {
    updateSelectInput(session, "animal_id_1",
                      choices=sort(unique(id_choices_3()))
    )# updateSelectInput
  })
  
  selected_id_3 = reactive({
    if(is.null(input$animal_id_1)) {
      unique(unique(id_choices_3()))
    } else {
      input$animal_id_1
    }
  })
  
  #### generate a dataframe to be displayed and downloaded ####
  df_concentration_info = reactive({
    df_input[(df_input[,"animal_ID"] %in% selected_id_3()), ]
  })
  
  return(list(
    df_concentration_info = df_concentration_info, 
    selected_metal_3 = selected_metal_3, 
    selected_month_3 = selected_month_3, 
    id_choices_3 = id_choices_3
  ))
}


################### df_abs_con case #####################################
fn_abs_con_server = function(df_input=df_abs_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal_3 = reactive({
    if(is.null(input$metal_2)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_2
    }
  })
  
  selected_month_3 = reactive({
    if(is.null(input$month_2)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_2
    }
  })
  
  id_choices_3 = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal_3())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month_3()), "animal_ID"]
  })
  
  observeEvent( list(selected_metal_3(), selected_month_3()), {
    updateSelectInput(session, "animal_id_2",
                      choices=sort(unique(id_choices_3()))
    )# updateSelectInput
  })
  
  selected_id_3 = reactive({
    if(is.null(input$animal_id_2)) {
      unique(unique(id_choices_3()))
    } else {
      input$animal_id_2
    }
  })
  
  selected_measure = reactive({
    if(is.null(input$measure_tissue_2)) {
      unique(df_input[,"measure_tissue"])
    } else {
      input$measure_tissue_2
    }
  })
  
  #### generate a dataframe to be displayed and downloaded ####
  df_concentration_info = reactive({
    df_input[(df_input[,"animal_ID"] %in% selected_id_3())&
               (df_input[,"measure_tissue"] %in% selected_measure()), ]
  })
  
  return(list(
    df_concentration_info = df_concentration_info, 
    selected_metal_3 = selected_metal_3, 
    selected_month_3 = selected_month_3, 
    id_choices_3 = id_choices_3
  ))
}

################### df_related_con case #####################################
fn_related_con_server = function(df_input=df_related_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal_3 = reactive({
    if(is.null(input$metal_3)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_3
    }
  })

  selected_month_3 = reactive({
    if(is.null(input$month_3)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_3
    }
  })

  id_choices_3 = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal_3())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month_3()), "animal_ID"]
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
    if(is.null(input$measure_tissue_3)) {
      unique(df_input[,"measure_tissue"])
    } else {
      input$measure_tissue_3
    }
  })

  #### generate a dataframe to be displayed and downloaded ####
  df_concentration_info = reactive({
    df_input[(df_input[,"animal_ID"] %in% selected_id_3())&
               (df_input[,"measure_tissue"] %in% selected_measure()), ]
  })

  return(list(
    df_concentration_info = df_concentration_info,
    selected_metal_3 = selected_metal_3,
    selected_month_3 = selected_month_3,
    id_choices_3 = id_choices_3
  ))
}


