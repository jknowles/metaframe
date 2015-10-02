##' Generic function to build a meta.data object
##'
##' Define and describe meta.data for a data object in R. Based on the object 
##' structure this function will automatically define some attributes of the data. 
##' @param data a data object to define metadata for
##' @param sources a list of charcter strings describing data sources
##' @param units a list of character strings describing units for the columns
##' @param labels a list of character strings providing long variable names and labels
##' @param notes a list of character strings with additional notes about variables
##' @param revisions a list of character strings with information about revisions to a variable
##' @param ... optional additional parameters to \code{meta.data.summary} 
##' @return A \code{\linkS4class{meta.data}} object 
##' @details
##' The object has the following items
##' \itemize{
##' \item{sources - a list of character strings describing data sources}
##' \item{units - a list of character strings specifying the units of variables}
##' \item{labels - a generic character string describing an object}
##' \item{notes - character strings describing any additional details about specific data elements}
##' \item{revisions - a list of data revisions}
##' }
##' @note Yadda yadda yadda
##' @export document
##' @rdname document
##' @author Jared E. Knowles
document <- function(data, sources = NULL, units=NULL, 
                     labels=NULL, notes=NULL, revisions=NULL, ...){
  UseMethod("document")
}

#' @title Setting meta.data from a data.frame object
#' @rdname document
#' @method document data.frame
#' @export
document.data.frame <- function(data, sources = NULL, units=NULL, 
                                labels=NULL, notes=NULL, 
                                revisions=NULL, ...){
  if (!is.data.frame(data)) stop("data must be a data.frame")
  K <- ncol(data) + 1
  if(is.null(sources)){
    srcList <- vector(mode = "list", length = 4)
    names(srcList) <- c("Name", "Year", "Citation", "Notes")
    sources <- rep(list(srcList), K) 
    names(sources) <- c("OVERALL", colnames(data))
  } else if(class(sources) != "list"){
    sources <- as.list(sources)
  }
  if(is.null(labels)){
    labels <- vector(mode = "list", length = K)
    names(labels) <- c("OVERALL", colnames(data))
  } else if(class(labels) != "list"){
    labels <- as.list(labels)
  }
  if(is.null(notes)){
    notes <- list("No notes listed.")
  } else if(class(notes) != "list"){
    notes <- as.list(notes)
  }
  if(is.null(revisions)){
    revisions <- list("No revisions listed.")
  } else if(class(revisions) != "list"){
    revisions <- as.list(revisions)
  }
  if(is.null(units)){
    units <- vector(mode = "list", length = K-1)
    names(units) <- colnames(data)
  } else if(class(units) != "list"){
    units <- as.list(units)
  }
  # check for additional values
  args <- eval(substitute(alist(...))) # get ellipsis values
  args <- lapply(args, eval, parent.frame()) # convert from symbols to objects
  if(exists("n", args)){
    n <- args$n
    } else{
    n <- 5
  }
  
  outMD <- meta.data(sources = sources,
                     units = units, 
                     labels = labels, 
                     notes = notes, 
                     revisions = revisions, 
                     var_names = colnames(data), 
                     obs_names = rownames(data), 
                     summary = meta.summary(data, n = n), 
                     Rname = deparse(substitute(data)))
  newdata <- data
  attr(newdata, "meta.data") <- outMD
  class(newdata) <- c("meta.frame", "data.frame")
  return(newdata)
} 
