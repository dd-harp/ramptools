loc_table <- data.table::fread("data-raw/loc_table.csv")
usethis::use_data(loc_table, overwrite = TRUE)
