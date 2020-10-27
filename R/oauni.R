#' @keywords internal
"_PACKAGE"

#' Start hoad web application
#' @inheritDotParams rmarkdown::run
#' @inherit rmarkdown::run
#' @family CICD
#' @export
runOAUNI <- function(...) {
  rmarkdown::run(file = system.file("app", "dashboard.Rmd", package = "oauni"), ...)
}
