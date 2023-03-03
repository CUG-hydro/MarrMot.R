#' @export 
julia_init <- function() {
  JuliaCall::julia_setup()
  JuliaCall::julia_library("MarrMot")
}
