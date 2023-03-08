# library(plumber)
#' @importFrom plumber pr pr_run
deploy_MarrMot <- function(port = 8000, host = "0.0.0.0") {
  f <- system.file("api/MarrMot_api.R", package = "MarrMot")
  pr(f) %>%
    pr_run(port = port, host = host)
}
