## R metaframe S3 objects

#' @title metaframe
#' @description A data.frame with metadata attached to it
#' @param data a data.frame
#' @export
metaframe <- function(data) {
  if (!is.data.frame(x)) stop("X must be a data.frame")
  attr(data, "sources") <- "No sources listed."
  attr(data, "description") <- "Standard metaframe. Undocumented"
  attr(data, "annotations") <- "No annotations"
  attr(data, "revisions") <- "Initial version"
  structure(data.frame(x), class = c("metaframe", "data.frame"))
}

# metaAttribs <- function(x){
#   attr(x, "sources") <- "No sources listed."
#   attr(x, "description") <- "Standard metaframe. Undocumented"
#   attr(x, "annotations") <- "No annotations"
#   attr(x, "revisions") <- "Initial version"
# }


