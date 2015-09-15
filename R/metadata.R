
#' meta.data data documentation class
#'
#' A meta.data object stores metadata about a given data element in R in a structured 
#' set of lists for easy output and analysis. Most commonly meta.data objects are 
#' attached to a data.frame and stored as a meta.frame. 
#'
##' @name meta.data-class
##' @aliases meta.data-class
##' @docType class
##' @section Objects from the Class: Objects are created by calls to
##' \code{\link{meta.data}}.
##' @details
##' The object has the following items
##' \itemize{
##' \item{sources - a list of character strings describing data sources}
##' \item{units - a list of character strings specifying the units of variables}
##' \item{labels - a generic character string describing an object}
##' \item{notes - character strings describing any additional details about specific data elements}
##' \item{revisions - a list of data revisions}
##' \item{var_names - a character vector of column names in last known order}
##' \item{obs_names - a charadcter vector of row names in last known order}
##' }
##' @keywords classes
##' @export
meta.data <- setClass("meta.data", representation(
  sources = "list",
  units = "list", 
  labels = "list", 
  notes = "list", 
  revisions = "list", 
  var_names = "character", 
  obs_names = "character", 
  summary = "list", 
  Rname = "character"),   S3methods=TRUE)

##' Generic function to build summary data for a meta.data object
##'
##' Summarize a data object in R. Based on the object 
##' structure this function will automatically define some attributes of the data. 
##' @param object a data object to define metadata for
##' @param n number of top and bottom values to retain
##' @param ... additional arguments to pass through
##' @return A \code{list} with summary features for an object
##' @note Yadda yadda yadda
##' @export meta.summary
##' @rdname meta.summary
##' @author Jared E. Knowles
meta.summary <- function(object, n, ...){
  UseMethod("meta.summary")
}


#' @title Build summary data from a data.frame object
#' @rdname meta.summary
#' @method meta.summary data.frame
#' @export
meta.summary.data.frame <- function(object, n, ...){
  stataMode <- function(x){
    x <- as.character(x)
    z <- table(as.vector(x))
    m <- names(z)[z == max(z)]
    
    if (length(m) == 1){
      return(m)
    }
    return(".")
  }
  
  numSum <- apply(object, 2, function(x) {t(c(min = min(x, na.rm = TRUE),
                                              Q1 = quantile(x, prob = 0.25, na.rm = TRUE),
                                              median = median(x, na.rm = TRUE),
                                              Q3 = quantile(x, prob = 0.75, na.rm = TRUE),
                                              max =max(x, na.rm = TRUE),
                                              sd = sd(x, na.rm = TRUE),
                                              missing = sum(is.na(x == TRUE)),
                                              nunique = length(unique(x)), 
                                              mode = stataMode(x), 
                                              class = class(x)))})
  
  numSum <- data.frame(t(numSum), stringsAsFactors = FALSE)
  names(numSum) <- c("min", "Q1", "median", "Q3", "max", "sd", 
                     "missing", "nunique",  "mode", "class")
  numSum[, 1:8] <- apply(numSum[, 1:8], 2, as.numeric)
  
  
  myTab <- function(x, n, order = c("ascending", "descending"), 
                    na.rm=TRUE){
    order <- match.arg(order, several.ok = FALSE)
    z <- table(x)
    if(order == "ascending"){
      z <- z[order(-z)][1:n]
    } else {
      z <- z[order(z)][1:n]
    }
    
    if(na.rm == TRUE){
      z <- z[!is.na(z)]
    }
    return(as.list(z))
  }
  
  highObs <-  apply(object, 2, myTab, n = n, order = "ascend")
  lowObs <- apply(object, 2, myTab, n = n, order = "desce")
  dataDims <- list('rows' = nrow(object), 'cols' = ncol(object), 
                   'uniqueRows' = nrow(object[!duplicated(object),]))
  varClasses <- apply(object, 2, class)
  output <- list("numericSummary" = numSum, 
                 "highObs" = highObs, 
                 "lowObs" = lowObs, 
                 'dims' = dataDims,
                 "classes" = varClasses)
  return(output)
}