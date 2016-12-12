#' @title Summarize a metaframe
#' @description This is a function to summarize a metaframe
#' @param object An object of class metaframe
#' @param ... ignored
#' @method summary metaframe
#' @export
summary.metaframe <- function(object, ...){
  print(summary.data.frame(object))
  print(summary(attr(object, "meta.data")))
}


#' @title Print a metaframe object
#' @description This is a function to print a metaframe
#' @param x An object of class metaframe
#' @param ... ignored
#' @details If the number of rows in the data frame exceed 10, then only the 
#' first ten rows will be printed
#' @method print metaframe
#' @export
print.metaframe <- function(x, ...){
  print(attr(x, "meta.data"))
  if(nrow(x) > 10){
    cat("Output truncated to first 10 rows \n")
    cat("\n")
    print.data.frame(x[1:10,])
  } else{
    print.data.frame(x)
  }
}


#' @title Display the structure of a metaframe object
#' @description This is a function to display the internal structure of a metaframe
#' @param object An object of class metaframe
#' @param ... ignored
#' @method str metaframe
#' @export
str.metaframe <- function(object, ...){
  tmp <- object
  class(tmp) <- "data.frame"
  print(str(tmp))
  # print(str(attr(object, "meta.data")))
}