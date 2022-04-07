## module to provide download function
## modul with download ui and server

#' Shiny Module UI for Downloading Dataframe 
#'
#' @param id shiny id 
#' @param download_item a name of the download item, i.e., the title of the dataframe, and it would be displayed in the frontend.
#'
#' @return shiny input 
#' @export
#'
#' @examples
download_ui = function(id, download_item = "sample"){
  downloadButton(NS(id, "download"), paste0("Export ", download_item, " to .tsv"), class = "down")
}

#' Shiny Module Server for Downloading Dataframe 
#'
#' @param id shiniy id
#' @param df_table the dataframe to be downloaded
#' @param pre_name prefix of the name of the download object, char 
#' @param metal metal selected, char
#' @param month month selected, char
#' @param download_item a name of the download item, i.e., the title of the dataframe, it would be saved as a part of the download object. 
#'
#' @return
#' @export
#'
#' @examples
download_server = function(id, df_table, pre_name, metal=metal, month=time, download_item="sample"){
  stopifnot(is.reactive(df_table))
  stopifnot(is.reactive(pre_name))
  stopifnot(is.reactive(metal))
  stopifnot(is.reactive(month))
  
  moduleServer(id, function(input, output, session){
    output$download = downloadHandler(
      filename = function(pre=paste0(pre_name(), "_", download_item, "_")){
        if( is.null(metal())&is.null(month()) ) {
          print(paste0(pre, Sys.Date(),  "_metal_ALL_month_ALL.tsv"))
        } else if ( is.null(metal())&(!is.null(month())) ){
          print(paste0(pre, Sys.Date(),
                       "_metal_ALL_month_",
                       paste(month(), collapse="_"), ".tsv"))
        } else if ( (!is.null(metal()))&is.null(month()) ){
          print(paste0(pre, Sys.Date(),
                       "_metal_", paste(metal(), collapse="_"), "_month_ALL.tsv"))
        } else {
          print(paste0(pre, Sys.Date(),
                       "_metal_", paste(metal(), collapse="_"), "_month_",
                       paste(month(), collapse="_"), ".tsv"))
        }
      },
      content = function(file) {
        vroom::vroom_write(df_table(), file)
      }
    )
  })# moduleServer
}
