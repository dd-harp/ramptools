#' Make district population data available
#'
#' @description
#' Pull in district population and make available as a data.table

district_pop <- data.table::fread("data-raw/district_pop.csv")
usethis::use_data(district_pop, overwrite = TRUE)
