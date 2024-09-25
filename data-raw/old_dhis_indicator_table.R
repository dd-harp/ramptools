#' Make old dhis indicator data available
#'
#' @description
#' Pull in old dhis indicator and make available as a data.table

old_dhis_indicator_table <- data.table::fread("data-raw/old_dhis_indicator_table.csv")
usethis::use_data(old_dhis_indicator_table, overwrite = TRUE)


