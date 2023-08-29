#' Make dhis indicator data available
#'
#' @description
#' Pull in dhis indicator and make available as a data.table

dhis_indicator_table <- data.table::fread("data-raw/dhis_indicator_table.csv")
usethis::use_data(dhis_indicator_table, overwrite = TRUE)

