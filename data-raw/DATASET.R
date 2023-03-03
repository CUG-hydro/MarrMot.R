## code to prepare `DATASET` dataset goes here
models_all <- read.table("data-raw/models_all.txt", header = F)$V1
usethis::use_data(models_all, overwrite = TRUE)
