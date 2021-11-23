###### module: a business module to perform selection ##########################
## business logic: module to select sample and corresponding expression value, 
# and return the results as two df_table in one list

# the selection condition in this logic is metal and time
selectDataVarUI <- function(id) {
  tagList(
    datasetExprsInput(NS(id, "data"), dataset_label="Studies", dataset_choices=name_libraries),
    selectVarInput(NS(id, "time"), treatment="month_post_implantation"),
    selectVarInput(NS(id, "metal"), treatment="metal_implanted")
  )
}
selectDataVarServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    selected <- datasetExprsServer("data")
    
    sample = selected$selected_sample
    exprs = selected$selected_exprs
    selected_library = selected$selected_library
    
    # the input and the logical result of condition "collected_time"
    treat_time_condt <- selectVarServer("time", sample, treatment="month_post_implantation")
    treat_time = treat_time_condt$treat_condt 
    time_condt = treat_time_condt$treat_selectinput
    
    # the input and the logical result of condition "metal_embodied"
    treat_metal_condt <- selectVarServer("metal", sample, treatment="metal_implanted")
    treat_metal = treat_metal_condt$treat_condt 
    metal_condt = treat_metal_condt$treat_selectinput
    
    
    list(treat_sample = reactive({sample()[treat_time()&treat_metal(),]}),
         treat_exprs = reactive({
           exprs()[, c('transcript_id', sample()[treat_time()&treat_metal(), 2])]
         }),# treat_expr
         time_condt = reactive(time_condt()), 
         metal_condt = reactive(metal_condt()),
         library_condt = reactive(selected_library())
    )# list
  })
}

