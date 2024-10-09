#' @param db_path Location of the database
#' @returns Integer value of latest version
get_latest_version <- function(db_path) {
  # Connect to database
  db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  # Grab the latest version
  latest_version <- tbl(db, "version_metadata") %>%
    filter(version == max(version, na.rm = T)) %>%
    pull("version")
  # Disconnect from database
  DBI::dbDisconnect(db)
  return(latest_version)
}

#' @param db_path Location of the database
#' @param version_id
#' @returns Integer value of latest version
get_version_metadata <- function(db_path, version_id) {
  # Connect to database
  db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  # Grab the latest version
  version_metadata <-  tbl(db, "version_metadata") %>%
    filter(version == version_id) %>%
    collect()
  # Disconnect from database
  DBI::dbDisconnect(db)
  return(as.data.table(version_metadata))
}

get_id_vars <- function(db_path) {
  # Connect to database
  db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  # Grab the list of columns that are identifiers
  id_vars <-  tbl(db, "column_info") %>%
    filter(is_identifier == 1) %>%
    pull(column_name)
  # Disconnect from database
  DBI::dbDisconnect(db)
  return(id_vars)
}

get_value_var <- function(db_path) {
  # Connect to database
  db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  # Grab the list of columns that are identifiers
  value_var <-  tbl(db, "column_info") %>%
    filter(is_value == 1) %>%
    pull(column_name)
  # Disconnect from database
  DBI::dbDisconnect(db)
  return(value_var)
}

#' @param db_path Location of the database
#' @param id_list A list of id names and values, if NULL, pulls full table
#' @param version_id Integer version number, if NULL, pulls latest version 
#' 
get_data <- function(db_path, id_list = NULL, version_id = NULL) {
  # Connect to database
  db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  # If version is NULL, pull the latest version
  if (is.null(version_id)) {
    version_id <- get_latest_version(db_path)
  }
  data <- tbl(db, "data")
  # Filter to provided id ranges
  if (!is.null(id_list)) {
    for (id in names(id_list)) {
      vals <- id_list[[id]]
      data <- data %>% filter(.data[[id]] %in% vals)
    }
  }
  # For a specific version, pull max version less than or equal to that version
  # for each unique set of id_vars
  id_vars <- get_id_vars(db_path)
  data <- data %>% filter(version <= version_id) %>%
    group_by(across(all_of(id_vars))) %>%
    filter(version == max(version, na.rm = T)) %>%
    ungroup() %>%
    collect() %>%
    as.data.table()
  DBI::dbDisconnect(db)
  return(data)
}

get_db_diff <- function(new_data, db_path) {
  id_vars <- get_id_vars(db_path)
  value_var <- get_value_var(db_path)
  id_list <- sapply(id_vars, function(id) {
    unique(new_data[[id]])
  })
  db_data <- get_data(db_path, id_list)
  db_diff <- anti_join(new_data, db_data, , by = c(id_vars, value_var))
  return(db_diff)
}

make_human_readable <- function(dt) {
  setnames(dt, c("dataElement", "orgUnit"), c("dhis_id", "location_id"))
  dt <- merge(dt, loc_table[, .(location_id, location_name)])
  dt <- merge(dt, indicator_table[, .(dhis_id, code_name)])
  return(dt)
}