library(plumber)


if (1) {
  # source("api/main_MarrMot_api.R")
  pr("./api/main_plumber.R") %>%
    pr_run(port = 8000, host = "0.0.0.0")
}

# pr() %>%
#   pr_handle("GET", "/hi", function() "Hello World") %>%
#   pr_run(port = 8000, host = "0.0.0.0")
