#' @title Summarize a metaframe
#' @description This is a function to summarize a metaframe
#' @param object An object of class metaframe
#' @param ... ignored
#' @export
summary.metaframe <- function(object, ...){
  summary(object$dataframe)
}

#' @title Print a metaframe object
#' @description This is a function to print a metaframe
#' @param x An object of class metaframe
#' @param ... ignored
#' @export
print.metaframe <- function(x, ...){
  message("Not written yet.")
}


#' @title Display the structure of a metaframe object
#' @description This is a function to display the internal structure of a metaframe
#' @param object An object of class metaframe
#' @param ... ignored
#' @export
str.metaframe <- function(object, ...){
  message("Not written yet.")
}