# Make a codebook

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
  
  header <- c("---", paste('title: "Codebook for `', mf.name, '`"', sep=""), paste("date:", date()),
              "output: ", "  html_document:", "    number_sections: no", "    toc: yes", "    toc_depth: 2", "---", "\n")
  
  cat(header, sep="\n", file=fname, append=FALSE)
  
  #Fill in data level information
  varnames <- c("DATA", varnames)
  nvars <- nvars + 1
  
  
  #Cycle through (remember the two trailing spaces!)
  for (i in 1:nvars) {
    idx <-  names(object@description)==varnames[i]
    cb.name <-   paste("## `", varnames[i], "`  \n\n")
    cb.label <-  paste("> **Label:  **", object@description[[idx]], "  ")
    cb.type <-   paste("> **Type:   **", ifelse(varnames[i]=="",  "data.frame", 
                                                object@summary$classes[[idx]]), "  ")
    cb.source <- paste("> **Source Name: **", object@sources[[idx]]$Name, "  ")
    cb.source <- paste("> **Source Year: **", object@sources[[idx]]$Year, "  ")
    cb.source <- paste("> **Source Citation: **", object@sources[[idx]]$Citation, "  ")
    cb.source <- paste("> **Source Notes: **", object@sources[[idx]]$Notes, "  ")
    cb.unit <-   paste("> **Units:  **", object@units[[idx]], "  ")
    cb.desc <-   paste(ifelse(varnames[i]=="DATA", 
                              paste("**Metaframe Description**  \n", object@description$OVERALL, "  \n\n"), 
                              "**Description**  \n"),
                       ifelse(is.null(object@annotations[idx]), 
                              "No annotations.  \n\n", 
                              paste(object@annotations[idx], "\n\n")),
                       ifelse(is.null(object@revisions[idx]), 
                              "No revisions.  \n\n", 
                              paste(object@revisions[idx], "\n\n")),
                       ifelse(varnames[i]=="DATA", paste("Source: ", object@sources[["OVERALL"]], "  \n"), ""))
    
    if (varnames[i]=="") {
      cat(c(cb.desc, "\n"), 
          sep="\n", file=fname, append=TRUE)
    } else  {
      cat(c("---- \n", 
            cb.name, cb.label, cb.type, cb.source, cb.unit, "\n", 
            cb.desc, "\n",
            "**Summary**  \nInfo in here", "\n"), sep="\n", file=fname, append=TRUE)
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
