################### df_creatinine_con case #####################################

#' Server End for Querying the Creatinine Concentration 
#' 
#' @description A shiny server, is designed for querying the Creatinine Concentration
#' @param df_input df_creatinine_con, a dataframe
#' @param input shiny input, metal_1, month_1, animal_id_1
#' @param output a list, including element of selected_metal, selected_month and id_choices, and the filtered records of concentration 
#' @param session 
#'
#' @return return a list of output
#' @export
#'
#' @examples
query_con_creatinine_server = function(df_input=df_creatinine_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal = reactive({
    if(is.null(input$metal_1)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_1
    }
  })
  
  selected_month = reactive({
    if(is.null(input$month_1)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_1
    }
  })
  
  id_choices = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month()), "animal_ID"]
  })
  
  observeEvent( list(selected_metal(), selected_month()), {
    updateSelectizeInput(session, "animal_id_1",
                         choices=sort(unique(id_choices()))
    )# updateSelectizeInput
  })
  
  selected_id_3 = reactive({
    if(is.null(input$animal_id_1)) {
      unique(unique(id_choices()))
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
    selected_metal = selected_metal, 
    selected_month = selected_month, 
    id_choices = id_choices
  ))
}


################### df_abs_con case #####################################

#' Server End for Querying the Absolution Metal Concentration
#' 
#' @description A shiny server, is designed for querying the absolution metal concentration
#' @param df_input df_abs_con, a dataframe
#' @param input shiny input, metal_2, month_2, animal_id_2, measure_tissue_2
#' @param output a list, including element of selected_metal, selected_month and id_choices, and the filtered records of concentration
#' @param session 
#'
#' @return return a list of output
#' @export
#'
#' @examples
query_con_abs_server = function(df_input=df_abs_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal = reactive({
    if(is.null(input$metal_2)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_2
    }
  })
  
  selected_month = reactive({
    if(is.null(input$month_2)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_2
    }
  })
  
  id_choices = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month()), "animal_ID"]
  })
  
  observeEvent( list(selected_metal(), selected_month()), {
    updateSelectizeInput(session, "animal_id_2",
                         choices=sort(unique(id_choices()))
    )# updateSelectizeInput
  })
  
  selected_id_3 = reactive({
    if(is.null(input$animal_id_2)) {
      unique(unique(id_choices()))
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
    selected_metal = selected_metal, 
    selected_month = selected_month, 
    id_choices = id_choices
  ))
}

################### df_related_con case #####################################

#' Server End for Querying the Related Metal Concentration
#' 
#' @description A shiny server, is designed for querying the related metal concentration
#' @param df_input df_related_con, a dataframe
#' @param input shiny input, metal_3, month_3, animal_id_3, measure_tissue_3
#' @param output a list, including element of selected_metal, selected_month and id_choices, and the filtered records of concentration
#' @param session 
#'
#' @return return a list of output
#' @export
#'
#' @examples
query_con_related_server = function(df_input=df_related_con, input, output, session){
  # #### input of metal, month and then control the "animal_id" list ####
  selected_metal = reactive({
    if(is.null(input$metal_3)) {
      unique(df_input[,"metal_implanted"])
    } else {
      input$metal_3
    }
  })
  
  selected_month = reactive({
    if(is.null(input$month_3)) {
      unique(df_input[,"euthanized_month_post_implantation"])
    } else {
      input$month_3
    }
  })
  
  id_choices = reactive({
    df_input[
      (df_input[,"metal_implanted"] %in% selected_metal())&
        (df_input[,"euthanized_month_post_implantation"] %in% selected_month()), "animal_ID"]
  })
  
  observeEvent( list(selected_metal(), selected_month()), {
    updateSelectizeInput(session, "animal_id_3",
                         choices=sort(unique(id_choices()))
    )# updateSelectizeInput
  })
  
  selected_id_3 = reactive({
    if(is.null(input$animal_id_3)) {
      unique(unique(id_choices()))
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
    selected_metal = selected_metal,
    selected_month = selected_month,
    id_choices = id_choices
  ))
}


