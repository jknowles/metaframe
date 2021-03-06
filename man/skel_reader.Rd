% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/skeleton.R
\name{skel_reader}
\alias{skel_reader}
\title{Read in an external metadata file formatted by skeleton}
\usage{
skel_reader(object = NULL, file = NULL, fileEncoding = "latin1", ...)
}
\arguments{
\item{object}{an R data.frame containing metadata to convert to a metadata object}

\item{file}{a file path to read in a csv file}

\item{fileEncoding}{character, encoding of the csv file to read, default is "latin1"}

\item{...}{additional arguments to pass to \code{\link{read.csv}}}
}
\value{
an object of class meta.data
}
\description{
Read in a skeleton of metadata
}
\details{
The csv file should match the format of that produced by the appropriate 
skeleton method
}
