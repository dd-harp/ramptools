#' Make age-sex indicator dhis ids available
#'
#' @description
#' Pull in age-sex indicator ids and make available as a data.table

age_sex_table <- data.table::fread("data-raw/age_sex_table.csv")
usethis::use_data(age_sex_table, overwrite = TRUE)
