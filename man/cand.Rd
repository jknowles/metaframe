% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metaframe-package.R
\docType{data}
\name{cand}
\alias{cand}
\title{A subset of data from a 2015 study of school board elections in Wisconsin}
\format{A data frame with 5,854 observations on the following 4 variables.
\describe{
 \item{\code{candidateid2}}{a character ID consisting of a school board ID - candidate ID}
 \item{\code{nraces}}{a numeric vector for the number of races the candidate ran in}
 \item{\code{nwins}}{a numeric vector for the number of races won by the candidate}
 \item{\code{ninc}}{a numeric vector for the number of times the candidate was an incumbent}
}}
\source{
Knowles, Jared E. 2015. School Boards and the Democratic Promise.
}
\usage{
cand
}
\description{
Data on candidates in school board elections in Wisconsin.
}
\examples{
data(cand)
head(cand)
}
\references{
Knowles, Jared E. (2015). School Boards and the Democratic Promise.
PhD Dissertation.
}
\keyword{datasets}
