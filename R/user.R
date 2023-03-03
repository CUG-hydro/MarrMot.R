## 设计一个用户系统
#' @importFrom data.table fread fwrite
check_user <- function(User, file = "_MarrMot_users.csv") {
  dbase <- fread(file)
  time <- Sys.time()
  date <- Sys.Date()
  hour <- hour(time)

  ind <- first(which(User %in% dbase$user))

  if (length(ind) > 0) {
    d <- dbase[User == user, ][1, ]

    # 每天的限制
    if (date == as.Date(d$date)) {
      d$day_used %<>% add(1)
    } else {
      d$day_used <- 1
    }

    if (d$day_used > d$day_max) {
      stop("超出每天api数")
    }

    # 每小时的限制
    if (hour == d$hour) {
      d$hour_used %<>% add(1)
    } else {
      d$hour_used <- 1
    }

    if (d$hour_used > d$hour_max) {
      stop("超出每小时api数")
    }

    df_new <- rbind(d, dbase[user != User])
    fwrite(df_new, file)
  } else {
    stop("未注册用户")
  }
}
