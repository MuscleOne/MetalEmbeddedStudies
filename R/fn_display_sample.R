################################################################################
# write a function to treat the 'df_sample[metal_var()&month_var(), ]'
# to  write a function
#' Function for Convert a Sample Information Dataframe before Displaying It
#' 
#' @description Convert the sample information dataframe in the expression profiling queries 
#' @param df a dataframe to be treated
#'
#' @return a converted dataframe
#' @export
#'
#' @examples
fn_display_sample = function(df) {
  df_t = t(df)
  df_t = cbind(rownames(df_t), df_t)
  colnames(df_t) = df_t[1,]
  rownames(df_t) = NULL
  df_t = df_t[-1,]
  return(df_t)
}
# test