#' Launch a shiny app to document your data interactively
#'
#' \code{shine_doc} launches a shiny app that allows you to interactively
#' document data elements in your dataframe.
#'
#' @param newdata data you want to document
#' @param pos The position of the environment to export function arguments to.
#' Defaults to 1, the global environment, to allow shiny to run.
#' @return A shiny app
#' @import shiny
#' @import rhandsontable
#' @export
shine_doc <- function(data, pos=1) {
  envir = as.environment(pos)
  expParam <- function(x) assign(".data", list("data" = x), envir = envir)
  expParam(x = data)
  appDir <- system.file("shiny-apps", "doco", package = "metaframe")
  shiny::runApp(appDir, display.mode = "normal")
}
