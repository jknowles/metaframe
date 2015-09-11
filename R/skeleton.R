##' Generic function to build a skeleton for codebook input from an R object
##'
##' To make metadata input more efficient, this function builds out a custom 
##' csv file that can be edited in an outside text editor and read back into R 
##' and then used to construct a metadata object. 
##' @usage skeleton(data, file, replace)
##' @param data a data object to construct a codebook skeleton for
##' @param file a character string indicating where the file should be saved, if 
##' NULL codebook object is printed to the console
##' @param replace logical, should an existing codebook skeleton file be 
##' overwritten, default is FALSE
##' @return A CSV file
##' @export skeleton
##' @rdname skeleton
##' @author Jared Knowles
skeleton <- function(data, file=NULL, replace=FALSE){
  UseMethod("skeleton")
}



#' @title Build a meta.data skeleton from a data.frame
#' @rdname skeleton
#' @method skeleton data.frame
#' @importFrom tools file_ext
#' @export
skeleton.data.frame <- function(data, file=NULL, replace=FALSE) {
  varNames <- c("OVERALL", colnames(data))
  colNames <- c("variable", "labels", "units", "notes", "sources.name", "sources.year", 
                "sources.citation", "sources.notes", "revisions")
  md_skel <- as.data.frame(setNames(replicate(length(colNames),
                                             rep(" ", length(varNames)), 
                                             simplify = F), colNames), 
                          row.names = 1:length(varNames))
  
  md_skel$variable <- varNames
  numSum <- meta.summary(data)$numericSummary
  numSum$variable <- row.names(numSum)
  md_skel <- merge(md_skel, numSum, by = "variable",all.x=TRUE)
  
  if(!is.null(file)){
    if(tools::file_ext(file)!= "csv"){
      warning("File other than csv specified, overriding to filename codebook.csv")
      file <- "codebook.csv"
    }
  }
  
  if (is.null(file)) {
    print(md_skel)
  } else {
    if (file.exists(file)) {
      if (replace) {
        message(paste("Overwriting", file))
        write.csv(md_skel, file = file, row.names = FALSE)
      } else {
        stop(paste("File", file, "already exists. Set replace = TRUE to overwrite"))
      }
    } else {
      write.csv(md_skel, file = file, row.names = FALSE)
    }
  }
}


#' @title Read in an external metadata file formatted by skeleton
#' @keywords internal
skel_reader <- function(file){
  md_skel <- read.csv(file = file, stringsAsFactors = FALSE)
  
  labels <- as.list(md_skel$labels); names(labels) <- md_skel$variable
  units <- as.list(md_skel$units); names(units) <- md_skel$variable
  notes <- as.list(md_skel$notes); names(notes) <- md_skel$variable
  revisions <- as.list(md_skel$revisions); names(revisions) <- md_skel$variable
    srcList <- vector(mode = "list", length = 4)
    names(srcList) <- c("Name", "Year", "Citation", "Notes")
    sources <- rep(list(srcList), length(md_skel$variable))
    names(sources) <- md_skel$variable
    for(i in 1:length(sources)){
      for(j in 1:length(sources[[i]])){
        p <- names(sources[[i]])[[j]]
        if(p == "Name"){ 
          var <- md_skel$sources.name
        } else if(p == "Year"){
          var <- md_skel$sources.year
        } else if(p == "Citation"){
          var <- md_skel$sources.citation
        } else if(p == "Notes"){
          var <- md_skel$sources.notes
        }
        sources[[i]][[j]] <- var[i]
    }
    }
    
    numSum <- data.frame(t(numSum), stringsAsFactors = FALSE)
    names(numSum) <- c("min", "Q1", "median", "Q3", "max", "sd", 
                       "missing", "nunique",  "mode", "class")
    numSum[, 1:8] <- apply(numSum[, 1:8], 2, as.numeric)
    
    output <- list("numericSummary" = numSum, 
                   "highObs" = highObs, 
                   "lowObs" = lowObs, 
                   'dims' = dataDims,
                   "classes" = varClasses)
    
    outMD <- meta.data(sources = sources,
                       units = units, 
                       labels = labels, 
                       notes = notes, 
                       revisions = revisions, 
                       var_names = md_skel$variable, 
                       obs_names = "Missing", 
                       summary = meta.summary(data), 
                       Rname = "From Skeleton")
    return(outMD)

  
}
