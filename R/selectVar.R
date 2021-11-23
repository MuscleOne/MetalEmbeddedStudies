# module_1 to select samples in the sample sheet given a library
## helper ui 
selectVarInput <- function(id, treatment="collected_time") {
  selectInput(NS(id, "var"), paste0(treatment), choices = NULL, multiple = TRUE) 
}

selectVarServer <- function(id, data, treatment="collected_time") {
  stopifnot(is.reactive(data))
  moduleServer(id, function(input, output, session) {
    observeEvent(data(), {
      updateSelectInput(session, "var", choices=unique(data()[, paste0(treatment)]))
    })
    
    # the key commend to select the column in the input table we want!
    list(treat_condt = reactive({ 
      if(is.null(input$var)) {
        data()[, paste0(treatment)] %in% unique(data()[, paste0(treatment)])
      } else {
        data()[, paste0(treatment)] %in% input$var
      }
    }),#treat_condt
    treat_selectinput = reactive(input$var)
    )
  })
}
