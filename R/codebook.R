##' Generic function to build a codebook from an R object
##'
##' Build an HTML codebook from an R object that includes metadata about the 
##' data stored in the object and its creation. For some object types it will 
##' include auto-generated summary information about the data in the fields. 
##' @param object a data object to construct a codebook for
##' @param file a character string indicating where the file should be saved, if 
##' NULL default is `codebook`
##' @param replace logical, should an existing codebook file be overwritten, default 
##' is FALSE
##' @param render logical, should the codebook be opened after it is written? default 
##' is FALSE
##' @return An HTML file with codebook information
##' @export codebook
##' @rdname codebook
##' @author Carl Frederick
codebook <- function(object, file=NULL, replace=FALSE, render=FALSE){
  UseMethod("codebook")
}



#' @rdname codebook
#' @method codebook meta.data
#' @import rmarkdown
#' @importFrom knitr kable
#' @export
codebook.meta.data <- function(object, file=NULL, replace=FALSE, render=FALSE) {
  if (!inherits(object, "meta.data")) {
    stop("not a meta.data object")
  }
  varnames <- object@var_names
  nvars <- length(varnames)
  mf.name <- object@Rname
  
  if (is.null(file)) {
    fname <- tempfile("codebook", fileext = ".Rmd")
  } else {
    if (file.exists(file)) {
      if (replace) {
        message(paste("Overwriting", file))
        file.create(file)
      } else {
        stop(paste("File", file, "already exists. Set replace = TRUE to overwrite"))
      }
    } else {
      file.create(file)
    }
    fname <- file(description = file, open = "r+")
  }
    header <- c("---", paste('title: "Codebook for `', mf.name, '`"', sep=""), 
                paste("date:", date()), "output: ", "  html_document:", 
                "    number_sections: no", "    toc: yes", 
                "    toc_depth: 2", "---", "\n")
  
  cat(header, sep="\n", file=fname, append=FALSE)
  
  #Fill in data level information
  varnames <- c("DATA", varnames)
  nvars <- nvars + 1
  
  
  #Cycle through (remember the two trailing spaces!)
  for (i in 1:nvars) {
    idx <-  varnames[i]
    cb.name <-   paste("## `", varnames[i], "`  \n\n")
    cb.label <-  paste("> **Label:  **", object@labels[[idx]], "  ")
    cb.type <-   paste("> **Type:   **", ifelse(varnames[i]=="DATA",  "data.frame", 
                                                object@summary$classes[[idx]]), "  ")
    cb.source <- paste("> **Source Name: **", object@sources[[idx]]$Name, "  \n")
    cb.source <- paste(cb.source, "> **Source Year: **", object@sources[[idx]]$Year, "  \n")
    cb.source <- paste(cb.source, "> **Source Citation: **", object@sources[[idx]]$Citation, "  \n")
    cb.source <- paste(cb.source, "> **Source Notes: **", object@sources[[idx]]$Notes, "  \n")
    cb.unit <-   paste("> **Units:  **", object@units[[idx]], "  ")
    cb.desc <-   paste(ifelse(varnames[i]=="DATA", 
                              paste("**Metaframe Label**  \n", object@labels$OVERALL, "  \n\n"), 
                              paste("**Label**  \n", object@labels[[idx]], "  \n\n")),
                       ifelse(is.null(object@notes[idx]) | nchar(object@notes[idx]) < 5, 
                              "**Notes**  \n  No notes.  \n\n", 
                              paste("**Notes**  \n", object@notes[idx], "  \n\n")),
                       ifelse(is.null(object@revisions[idx]) | nchar(object@revisions[idx]) < 5, 
                              "**Revisions**  \n  No revisions.  \n\n", 
                              paste("**Revisions**  \n", object@revisions[idx], "  \n\n")),
                       ifelse(varnames[i]=="DATA", paste("Source: ", object@sources[["OVERALL"]], "  \n\n"), ""))
    
    if (varnames[i]=="") {
      cat(c(cb.desc, "\n"), 
          sep="\n", file=fname, append=TRUE)
    } else  {
      # get names in place
      sumInfo <- knitr::kable(object@summary$numericSummary[i, ], format = "html")
      cat(c("---- \n", 
            cb.name, cb.label, cb.unit, cb.type, cb.source, "\n", 
            cb.desc, "\n",
            "**Summary**  \n ", sumInfo, "  \n \n"), sep="\n", file=fname, append=TRUE)
    }
  }
  
  if (is.null(file)) {
    if (render) browseURL(rmarkdown::render(fname))
    unlink(fname)
  }
  if (!is.null(file)) {
    if (render) browseURL(rmarkdown::render(file))
    close(fname)
  }
}
