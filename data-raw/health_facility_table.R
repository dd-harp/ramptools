#' Make health facility table available
#'
#' @description
#' Pull in health facility table and make available as a data.table

health_facility_table <- data.table::fread("data-raw/health_facility_table.csv")
usethis::use_data(health_facility_table, overwrite = TRUE)


