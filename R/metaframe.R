#' ## R metaframe S3 objects
#' 
#' #' @title meta.frame
#' #' @description A data.frame with metadata attached to it
#' #' @param data a data.frame
#' #' @export
#' meta.frame <- function(data, ...) {
#'   if (!is.data.frame(data)) stop("data must be a data.frame")
#'   attr(data, "meta.data") <- document(data, ...)
#'   structure(data.frame(data), class = c("data.frame", "meta.frame"))
#' }
#' 
#' #' "meta.frame" class
#' #'
#' #' @name meta.frame-class
#' #' @aliases meta.frame
#' #' @family meta.frame
#' #'
#' #' @exportClass meta.frame
#' setOldClass(c("meta.frame", "data.frame"))