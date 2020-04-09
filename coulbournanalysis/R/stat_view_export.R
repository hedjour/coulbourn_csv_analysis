stat_view_export <- function(x,col_name, values, file_names ){
  
  pivot_wider(x, names_from = all_of(col_name), values_from = all_of(values)) %>%
    (function(y){y[,apply(y, 2, function(x) !all(is.na(x)))]}) %>%
    write.table(., file = file_names, sep = ";", row.names = FALSE, na = "")
}