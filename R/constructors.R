#' @title Add source information to data in R
#' @param object a dataset or meta.data object to append with source information
#' @param src a properly formatted source description to append, a named list
#' @description This function will add source data to a data object in R. If
#' source data already exists, it will modify the source data appropriately.
#' If source data does not exist, it will convert the object to a metaframe,
#' and append the source data correctly.
#' @export
add_source <- function(object, src) UseMethod("add_source")


#' @rdname add_source
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



#' @rdname add_source
#' @export
#' 
add_source.metaframe <- function(object, src){
  attr(object, "meta.data") <- add_source(attr(object, "meta.data"), src = src)
  return(object)
}



#' @title Add a label to meta.data in R
#' @param object an object to append with meta.data labels
#' @param label a character vector or list for the labels
#' @description This function will add a description to a data object
#' in R. If a description already exists, it will be replaced. If a description
#'  does not exist, it will convert the object to a metaframe, and append the
#'  description
#' @export
add_label <- function(object, label) UseMethod("add_label")


#' @rdname add_label
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

#' @rdname add_label
#' @export
#' 
add_label.metaframe <- function(object, label){
  attr(object, "meta.data") <- add_label(attr(object, "meta.data"), label = label)
  return(object)
}

#' @title Add annotation information to data in R
#' @param object an object to append with meta.data notes
#' @param note a character vector or list for the notes
#' @description This function will add annotations to the dataset. Annotations
#' should be non-data descriptions of dataset features such as observation dates,
#' log information, or equipment changes in collecting data.
#' @export
add_note <- function(object, note) UseMethod("add_note")


#' @rdname add_note
#' @method add_note meta.data
#' @export
add_note.meta.data <- function(object, note){
  if(is.null(names(note))){
    stop("note object must be named.")
  }
  if(!names(note) %in% object@var_names){
    stop("Names of note must be in object@var_names.")
  }
  if(is.null(object@notes)){
    object@notes <- note
  } else{
    for(i in names(note)){
      object@notes[[i]] <- note[[i]]
    }
  }
  return(object)
}

#' @rdname add_note
#' @method add_note metaframe
#' @export
#' 
add_note.metaframe <- function(object, note){
  attr(object, "meta.data") <- add_note(attr(object, "meta.data"), note = note)
  return(object)
}


#' @title Add units information to data in R
#' @param object an object to append with meta.data about units of measurement
#' @param unit a character vector or list for the units
#' @description This function will add units information to the dataset. Units 
#' should be short character descriptions of the unit of measure for data elements 
#' in the data set. 
#' @export
add_unit <- function(object, unit) UseMethod("add_unit")



#' @rdname add_unit
#' @method add_unit meta.data
#' @export
add_unit.meta.data <- function(object, unit){
  if(is.null(names(unit))){
    stop("unit object must be named.")
  }
  if(!names(unit) %in% object@var_names){
    stop("Names of unit must be in object@var_names.")
  }
  if(is.null(object@units)){
    object@units <- unit
  } else{
    for(i in names(unit)){
      object@units[[i]] <- unit[[i]]
    }
  }
  return(object)
}

#' @rdname add_unit
#' @method add_unit metaframe
#' @export
#' 
add_unit.metaframe <- function(object, unit){
  attr(object, "meta.data") <- add_unit(attr(object, "meta.data"), unit = unit)
  return(object)
}

#' @title Add revisions information to data in R
#' @param object an object to append with meta.data about revisions to the data
#' @param revision a character vector or list of revisions
#' @description This function will add revision information to the dataset. Revisions 
#' are descriptions of changes made to individual fields in the dataset based on 
#' information or changes outside of the analysis tool-chain
#' @export
add_revision <- function(object, revision) UseMethod("add_revision")


#' @rdname add_revision
#' @method add_revision meta.data
#' @export
add_revision.meta.data <- function(object, revision){
  if(is.null(names(revision))){
    stop("revision object must be named.")
  }
  if(!names(revision) %in% object@var_names){
    stop("Names of revision must be in object@var_names.")
  }
  if(is.null(object@revisions)){
    object@revisions <- revision
  } else{
    for(i in names(revision)){
      object@revisions[[i]] <- revision[[i]]
    }
  }
  return(object)
}

#' @rdname add_revision
#' @method  add_revision metaframe
#' @export
#' 
add_revision.metaframe <- function(object, revision){
  attr(object, "meta.data") <- add_revision(attr(object, "meta.data"), revision = revision)
  return(object)
}