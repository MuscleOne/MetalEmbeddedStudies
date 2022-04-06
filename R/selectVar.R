# module_1 to select samples in the sample sheet given a library
## helper ui 
# strsplit(vec_col_name, "_")

selectVarInput <- function(id, treatment="month_post_implantation") {
  selectizeInput(NS(id, "var"), 
                 paste(strsplit(treatment, "_")[[1]], collapse=" "), 
                 choices = NULL, multiple = TRUE, 
                 options = list(placeholder = 'Show ALL')) 
}

selectVarServer <- function(id, data, treatment="month_post_implantation") {
  stopifnot(is.reactive(data))
  moduleServer(id, 
    function(input, output, session) {
      observeEvent(data(), {
      updateSelectizeInput(session, "var", choices=sort(unique(data()[, paste0(treatment)])))
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
