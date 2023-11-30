#' Make example table available
#'
#' @description
#' Pull in location hierarchy and make available as a data.table

example <- data.table::fread("data-raw/example.csv")
usethis::use_data(example, overwrite = TRUE)
