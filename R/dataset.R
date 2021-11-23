# module to choose the suitable dataset by libraries
datasetInput <- function(id, dataset_label, dataset_choices) {
  selectInput(NS(id, "dataset"), dataset_label, choices = dataset_choices)
}

datasetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    list(selected_sample = reactive(l_sample[[input$dataset]]), 
         selected_exprs = reactive(l_exprs[[input$dataset]]),
         selected_library = reactive(input$dataset)
    )
  })#moduleServer
}
