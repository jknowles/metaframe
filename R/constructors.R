#' @title Add source information to data in R
#' @param object a dataset or meta.data object to append with source information
#' @param src a properly formatted source description to append, a named list
#' @description This function will add source data to a data object in R. If
#' source data already exists, it will modify the source data appropriately.
#' If source data does not exist, it will convert the object to a metaframe,
#' and append the source data correctly.
#' @export
add_source <- function(object, src) UseMethod("add_source")


#' @title Add source information to a meta.data object
#' @describeIn add_source
#' @method add_source meta.data
#' @export
#' 
add_source.meta.data <- function(object, src){
  if(class(src) != "list"){
    stop("src must be a list.")
  }
  if(is.null(names(src))){
    stop("src list must be a named list.")
  }
  if(!names(src) %in% object@var_names){
    stop("Names of src must be in object@var_names.")
  }
  if(is.null(object@sources)){
    object@sources <- src
  } else{
    for(i in names(src)){
      if(!any(names(src[[i]]) %in% c("Name", "Year", "Citation","Notes"))){
        stop("Each src element must contain only named characters 'Name', 'Year', 'Citation', and 'Notes'.")
      }
      object@sources[[i]] <- src[[i]]
    }
  }
  return(object)
}



#' @title Add source information to a meta.frame
#' @describeIn add_source
#' @method add_source meta.frame
#' @export
#' 
add_source.meta.frame <- function(object, src){
  attr(object, "meta.data") <- add_source(attr(object, "meta.data"), src = src)
  return(object)
}



#' @title Add a label to meta.data in R
#' @param object an object to append with meta.data labels
#' @param label a character vector of list for the labels
#' @description This function will add a description to a data object
#' in R. If a description already exists, it will be replaced. If a description
#'  does not exist, it will convert the object to a metaframe, and append the
#'  description
#' @export
add_label <- function(object, label) UseMethod("add_label")


#' @title Add a label to a data.frame
#' @describeIn add_label
#' @method add_label meta.data
#' @export
add_label.meta.data <- function(object, label){
  if(is.null(names(label))){
    stop("label object must be named.")
  }
  if(!names(label) %in% object@var_names){
    stop("Names of label must be in object@var_names.")
  }
  if(is.null(object@labels)){
    object@labels <- label
  } else{
    for(i in names(label)){
      object@labels[[i]] <- label[[i]]
    }
  }
  return(object)
}

#' @title Add labels to a meta.frame
#' @describeIn add_label
#' @method add_label meta.frame
#' @export
#' 
add_label.meta.frame <- function(object, label){
  attr(object, "meta.data") <- add_label(attr(object, "meta.data"), label = label)
  return(object)
}



#' 
#' 
#' #' @title Add a description to a data.frame
#' #' @describeIn add_description
#' #' @export
#' add_description.metaframe <- function(data, descr){
#'   if(is.null(attr(data, "description"))){
#'     attr(data, "description") <- descr
#'     return(data)
#'   } else {
#'     tmp <- attr(data, "description")
#'     src <- c(tmp, descr) # hack to fix later
#'     attr(data, "description") <- descr
#'     return(data)
#'   }
#' }
#' 


#' #' @title Add source information to a data.frame
#' #' @describeIn add_source
#' #' @export
#' add_source.data.frame <- function(object, src){
#'   data <- metaframe(data)
#'   attr(data, "sources") <- src
#'   return(data)
#' }



#' #' @title Add annotation information to data in R
#' #' @param data a dataset to modify
#' #' @param ann a list containing annotation descriptions
#' #' @description This function will add annotations to the dataset. Annotations 
#' #' should be non-data descriptions of dataset features such as observation dates, 
#' #' log information, or equipment changes in collecting data. 
#' #' @export
#' add_annotation <- function(data, ann) UseMethod("add_annotation")
#' 
#' #' @title Add annotations to a data.frame
#' #' @describeIn add_annotation
#' #' @export
#' add_annotation.data.frame <- function(data, ann){
#'   data <- metaframe(data)
#'   attr(data, "annotations") <- ann
#'   return(data)
#' }
#' 
#' 
#' #' @title Add annotations to a metaframe
#' #' @describeIn add_annotation
#' #' @export
#' add_annotation.metaframe <- function(data, ann){
#'   if(is.null(attr(data, "annotations"))){
#'     attr(data, "annotations") <- ann
#'     return(data)
#'   } else {
#'     tmp <- attr(data, "annotations")
#'     src <- c(tmp, ann) # hack to fix later
#'     attr(data, "annotations") <- ann
#'     return(data)
#'   }
#' }
#' 
#' #' @title Add information about revisions to data in R
#' #' @param data a dataset to modify
#' #' @param revs a list containing descriptions of revisions
#' #' @description This function will add information about revisions to a dataset. 
#' #' Revisions are descriptions of changes made to the dataset including  changing 
#' #' modifications to values of a particular row, column, or cell. 
#' #' @export
#' add_revisions <- function(data, revs) UseMethod("add_revisions")
#' 
#' 
#' 
#' #' @title Add revisions to a data.frame
#' #' @describeIn add_revisions
#' #' @export
#' add_revisions.data.frame <- function(data, revs){
#'   data <- metaframe(data)
#'   attr(data, "revisions") <- revs
#'   return(data)
#' }
#' 
#' 
#' #' @title Add revisions to a metaframe
#' #' @describeIn add_revisions
#' #' @export
#' add_revisions.metaframe <- function(data, revs){
#'   if(is.null(attr(data, "revisions"))){
#'     attr(data, "revisions") <- revs
#'     return(data)
#'   } else {
#'     tmp <- attr(data, "revisions")
#'     src <- c(tmp, revs) # hack to fix later
#'     attr(data, "revisions") <- revs
#'     return(data)
#'   }
#' }
