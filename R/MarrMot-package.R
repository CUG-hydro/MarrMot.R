#' @import magrittr data.table
#' @importFrom JuliaCall julia_library julia_call
#' 
#' @import magrittr
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

.onLoad <- function(libname, pkgname) {
  if (getRversion() >= "2.15.1") {
    utils::globalVariables(
      c(".", ".SD", ".N")
    )
  }
}
