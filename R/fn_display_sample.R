################################################################################
# write a function to treat the 'df_sample[metal_var()&month_var(), ]'
# to  write a function
fn_display_sample = function(df) {
  df_t = t(df)
  df_t = cbind(rownames(df_t), df_t)
  colnames(df_t) = df_t[1,]
  rownames(df_t) = NULL
  df_t = df_t[-1,]
  return(df_t)
}
# test