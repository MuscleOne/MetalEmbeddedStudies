###### module: a business module to perform selection ##########################
## business logic: module to select sample and corresponding expression value, 
# and return the results as two df_table in one list

# the selection condition in this logic is metal and time
#' Title
#'
#' @param id shiny id
#'
#' @return
#' @export
#'
#' @examples
query_exprs_ui <- function(id) {
  tagList(
    query_exprs_select_studies_ui(NS(id, "data"), dataset_label="studies", dataset_choices=name_libraries),
    query_exprs_select_cohorts_ui(NS(id, "time"), characteristics="month_post_implantation"),
    query_exprs_select_cohorts_ui(NS(id, "metal"), characteristics="metal_implanted")
  )
}

#' Title
#'
#' @param id shiny id
#'
#' @return
#' @export
#'
#' @examples
query_exprs_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    selected = query_exprs_select_studies_server("data")
    
    sample = selected$selected_sample
    exprs = selected$selected_exprs
    selected_library = selected$selected_library
    
    # the input and the logical result of condition "collected_time"
    cohort_time_condt = 
      query_exprs_select_cohorts_server("time", sample, characteristics="month_post_implantation")
    cohort_time = cohort_time_condt$cohort_condt 
    time_condt = cohort_time_condt$cohort_selectinput
    
    # the input and the logical result of condition "metal_embodied"
    cohort_metal_condt =
      query_exprs_select_cohorts_server("metal", sample, characteristics="metal_implanted")
    cohort_metal = cohort_metal_condt$cohort_condt 
    metal_condt = cohort_metal_condt$cohort_selectinput
    
    # observe(print({sample()[cohort_time()&cohort_metal(),]}))
    cohort_col_selected = reactive({sample()[cohort_time()&cohort_metal(), 2]})
    
    list(cohort_sample = reactive({sample()[cohort_time()&cohort_metal(),]}),
         cohort_exprs = 
           reactive({
             exprs()[, c('transcript_id', cohort_col_selected())]
           }),# cohort_expr
         time_condt = reactive(time_condt()), 
         metal_condt = reactive(metal_condt()),
         library_condt = reactive(selected_library())
    )# list
  })
}

