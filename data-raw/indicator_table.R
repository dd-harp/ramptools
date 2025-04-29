#' Make dhis indicator data available
#'
#' @description
#' Pull in dhis indicator and make available as a data.table

indicator_table <- data.table::fread("data-raw/indicator_table.csv")
usethis::use_data(indicator_table, overwrite = TRUE)

