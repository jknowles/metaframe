## R metaframe S3 objects

#' @title meta.frame
#' @description A data.frame with metadata attached to it
#' @param data a data.frame
#' @param ... additional arguments to \code{\link{document}}
#' @export
metaframe <- function(data, ...) {
  if (!is.data.frame(data)) stop("data must be a data.frame")
  attr(data, "meta.data") <- document(data, ...)
  structure(data.frame(data), class = c("data.frame", "meta.frame"))
}

#' "meta.frame" class
#'
#' @name metaframe-class
#' @family metaframe
#'
#' @exportClass metaframe
setOldClass(c("metaframe", "data.frame"))