#' Launch a shiny app to document your data interactively
#'
#' \code{shine_doc} launches a shiny app that allows you to interactively
#' document data elements in your dataframe.
#'
#' @param data data you want to document
#' @return A shiny app
#' @import shiny
#' @export
shine_doc <- function(data) {
  appDir <- system.file("shiny-apps", "doco", package = "metaframe")
  shiny::runApp(appDir, display.mode = "normal")
}
