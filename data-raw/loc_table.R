#' Make location hierarchy table available
#'
#' @description
#' Pull in location hierarchy and make available as a data.table

loc_table <- data.table::fread("data-raw/loc_table.csv")
usethis::use_data(loc_table, overwrite = TRUE)
