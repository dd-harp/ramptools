get_period_range <- function(frequency, year_start, sub_year_start, year_end,
                          sub_year_end) {
  #TODO: Error messages for non-sensical inputs
  #TODO: Add quarterly?
  if (frequency == "weekly") {
    period_dt <- make_week_map()
    period_dt <- period_dt[date_mid >= period_dt[period == paste0(year_start, "W", sub_year_start)]$date_mid]
    period_dt <- period_dt[date_mid <= period_dt[period == paste0(year_end, "W", sub_year_end)]$date_mid]
  } else if (frequency == "monthly") {
    period_dt <- data.table()
    for(y in year_start:year_end) {
      if (y == year_start) {
        if(year_end == year_start) {
          month_range <- sub_year_start:sub_year_end
        } else {
          month_range <- sub_year_start:12
        }
      } else if (y == year_end) {
        month_range <- 1:sub_year_end
      } else {
        month_range <- 1:12
      }
      period_dt <- rbind(period_dt, data.table(year = y, month = month_range))
    }
    period_dt[, period := paste0(year, month)]
    period_dt[nchar(month) == 1, period := paste0(year, "0", month)]
  }
  return(period_dt$period)
}

make_week_map <- function(min_date = "2012-12-31") {
  dt <- data.table(date = seq(as.IDate(min_date), Sys.Date(), by = 1))
  dt[, year := year(date)]
  dt[, week := isoweek(date)]
  dt[, year := ifelse(week == 1 & month(date) == 12, year + 1, year)]
  dt[, year := ifelse(week >= 52 & month(date) == 1, year - 1, year)]
  dt[, date_end := max(date), by = .(year, week)]
  dt[, date_start := date_end - 6]
  dt[, date_mid := date_start + 3]
  week_map <- unique(dt[, .(year, week, date_start, date_end, date_mid)])
  week_map[, period := paste0(year, "W", week)]
  return(week_map[])
}

make_month_map <- function(min_date = "2013-01-01") {
  dt <- data.table(date = seq(as.IDate(min_date), Sys.Date(), by = 1))
  dt[, year := year(date)]
  dt[, month := month(date)]
  dt[, date_start := min(date), by = .(year, month)]
  dt[, date_end := max(date), by = .(year, month)]
  dt[, date_mid := date_start + round((date_end - date_start) / 2)]
  month_map <- unique(dt[, .(year, month, date_start, date_end, date_mid)])
  month_map[, period := paste0(year, month)]
  month_map[nchar(month) == 1, period := paste0(year, "0", month)]
  return(month_map[])
}
