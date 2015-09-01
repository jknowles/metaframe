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

#' metadata data documentation class
#'
#' A metadata object stores metadata about a given data element in R in a structured 
#' set of lists for easy output and analysis. Most commonly metadata objects are 
#' attached to a data.frame and stored as a metaframe. 
#'
##' @name metadata-class
##' @aliases metadata-class
##' @docType class
##' @section Objects from the Class: Objects are created by calls to
##' \code{\link{metadata}}.
##' @details
##' The object has the following items
##' \itemize{
##' \item{sources - a list of character strings describing data sources}
##' \item{units - a list of character strings specifying the units of variables}
##' \item{description - a generic character string describing an object}
##' \item{annotations - character strings describing any additional details about specific data elements}
##' \item{revisions - a list of data revisions}
##' }
##' @seealso \code{\link{metaframe}}
##' @keywords classes
##' @examples
##'
##' showClass("metadata")
##' methods(class="metadata")
#' @export
metadata <- setClass("metadata", representation(
  sources = "list",
  units = "list", 
  description = "list", 
  annotations = "list", 
  revisions = "list"),   S3methods=TRUE)

#' @title Setting metadata from a data.frame object
#' @rdname document
#' @method document data.frame
#' @export
document.data.frame <- function(data, sources = NULL, units=NULL, 
                                description=NULL, annotations=NULL, 
                                revisions=NULL){
  if (!is.data.frame(data)) stop("data must be a data.frame")
  if(is.null(sources)){
    sources <- list("No sources listed.")
  } else if(class(sources) != "list"){
    sources <- as.list(sources)
  }
  if(is.null(description)){
    description <- list("No sources listed.")
  } else if(class(description) != "list"){
    description <- as.list(description)
  }
  if(is.null(annotations)){
    annotations <- list("No annotations listed.")
  } else if(class(annotations) != "list"){
    annotations <- as.list(annotations)
  }
  if(is.null(revisions)){
    revisions <- list("No revisions listed.")
  } else if(class(revisions) != "list"){
    revisions <- as.list(revisions)
  }
  if(is.null(units)){
    units <- list("No units listed.")
  } else if(class(units) != "list"){
    units <- as.list(units)
  }
  
  outMD <- metadata(sources = sources,
                     units = units, 
                     description = description, 
                     annotations = annotations, 
                     revisions = revisions)
  # class(outMD) <- "metadata"
  return(outMD)
} 


##' Generic function to build a metadata object
##'
##' Define and describe metadata for a data object in R
##' @usage metadata(data, ...)
##' @param data a data object to define metadata for
##' @param sources a list of charcter strings describing data sources
##' @param ... optional additional parameters. 
##' @return A \code{\linkS4class{metadata}} object 
##' @details
##' The object has the following items
##' \itemize{
##' \item{sources - a list of character strings describing data sources}
##' \item{units - a list of character strings specifying the units of variables}
##' \item{description - a generic character string describing an object}
##' \item{annotations - character strings describing any additional details about specific data elements}
##' \item{revisions - a list of data revisions}
##' }
##' @note Yadda yadda yadda
##' @export document
##' @rdname document
##' @author Jared E. Knowles
document <- function(data, sources = NULL, units=NULL, 
                     description=NULL, annotations=NULL, revisions=NULL){
  UseMethod("document")
}
