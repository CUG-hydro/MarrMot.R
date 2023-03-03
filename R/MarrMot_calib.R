# source("api/main_MarrMot_api.R")
# library(JuliaCall)
# library(dplyr)
# library(future)
# library(Ipaper)
# library(hydroTools)

# mkdir("OUTPUT")
# models_all <- read.table("data/models_all.txt", header = F)$V1

get_param <- function(x) {
  cbind(x$parRanges, x$theta) %>%
    set_colnames(c("par_low", "par_up", "par")) %>%
    as.data.frame()
}

#' MarrMot_calib
#' 
#' @param df A data.table with the columns of c("prcp", "pet", "tair").
#' 
#' @param models model names
#' 
#' @export
MarrMot_calib <- function(df, models, maxn = 10) {
  forcing <- select(df, prcp, pet, tair) %>% as.matrix()
  Robs <- df$R
  # 如果没有Robs这里会报错
  res <- julia_call("MarrMot.MarrMot_calib", forcing, Robs, models, maxn = maxn) %>%
    set_names(models)

  KGE <- purrr::map_dbl(res, "KGE")
  t_elapsed <- purrr::map_dbl(res, "t_elapsed")
  info <- data.frame(model = models, KGE, t_elapsed)

  params <- purrr::map(res, get_param)
  list(info = info, param = params)
}

#' MarrMot_predict
#' 
#' @param df A data.table with the columns of c("prcp", "pet", "tair").
#' @param model model name
#' @param par numberic vector or scalar
#' 
#' @export 
MarrMot_predict <- function(df, par, model) {
  forcing <- select(df, prcp, pet, tair) %>% as.matrix()
  
  Rsim <- julia_call("MarrMot.MarrMot_predict", forcing, par, model)
  Rsim
}
