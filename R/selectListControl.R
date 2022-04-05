# module_1 to select samples in the sample sheet given a library
# controlled
## helper ui 
selectListControlUI = function(id, df_data, label, col) {
  tagList(
    selectizeInput(NS(id, "controlled_col"), label, 
                choices = sort(unique(df_data[, col])), multiple = TRUE, 
                options = list(placeholder = 'Show ALL')),
  )
}

selectListControlServer = function(id, df_data, metal, month, l_choices) {
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
