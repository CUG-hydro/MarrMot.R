# library(plumber)
# library(MarrMot)
# library(JuliaCall)
# library(data.table)
# library(magrittr)

# plumber.R
#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(user, msg="") {
  tryCatch({
    check_user(user)
    list(msg = paste0("MarrMot.jl: '", msg, "'"))
  }, error = function(e) {
    message(sprintf('%s', e$message))
  })
}

#* Calibrate Model parameters
#* 
#* @param df A dataframe with the columns of `prcp`, `pet`, `tair` and `R`
#* @param models Character vector
#* 
#* @post /MarrMot/calibrate
function(user, df, models, maxn=10, verbose=FALSE) {
  tryCatch({
    check_user(user)
    julia_init()
    if (verbose) print2(df, models, maxn)

    MarrMot_calib(df, models, maxn)
  }, error = function(e) {
    message(sprintf('%s', e$message))
  })
}

#* Calibrate Model parameters
#* 
#* @param df A dataframe with the columns of `prcp`, `pet`, `tair` and `R`
#* @param models Character vector
#* 
#* @post /MarrMot/predict
function(user, df, par, model, verbose=FALSE) {
  tryCatch({
    check_user(user)
    julia_init()
    if (verbose) print2(df, par, model)

    MarrMot_predict(df, par, model)
  }, error = function(e) {
    message(sprintf('%s', e$message))
  })
  # trees$Height
}
