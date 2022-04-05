# module_1 to select samples in the sample sheet given a library
## helper ui 
selectMetalMonthUI = function(id, df_data) {
  tagList(
    selectizeInput(NS(id, "metal_weight"), "Metal Implanted", 
                choices = unique(df_data[, "metal_implanted"]), multiple = TRUE, 
                options = list(placeholder = 'Show ALL')),
    selectizeInput(NS(id, "month_weight"), "Euthanized Month Post-implantation", 
                choices = sort(unique(df_data[, "euthanized_month_post_implantation"])), multiple = TRUE, 
                options = list(placeholder = 'Show ALL'))
  )
}

selectMetalMonthServer = function(id, df_data) {
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
