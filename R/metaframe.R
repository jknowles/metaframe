## R metaframe S3 objects

#' @title Summarize a metaframe
#' @description This is a function to summarize a metaframe
#' @param object An object of class metaframe
#' @param ... ignored
#' @export
#' @examples
summary.metaframe <- function(object, ...){
  summary(object$dataframe)
}

#' @title Print a metaframe object
#' @description This is a function to print a metaframe
#' @param x An object of class metaframe
#' @param ... ignored
#' @export
#' @examples
print.metaframe <- function(x, ...){
  message("Not written yet.")
}
