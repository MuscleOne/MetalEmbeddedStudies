## module to provide download function
## modul with download ui and server
downloadUI = function(id, download_item = "sample"){
  downloadButton(NS(id, "download"), paste0("Export ", download_item, " to .tsv"))
}
downloadServer = function(id, df_table, pre_name, metal=metal, month=time, download_item="sample"){
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
