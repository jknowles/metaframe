#' metaframe: Provides methods for writing, reading, and analyzing metadata 
#' about data in data.frame objects in R.
#'
#' The metaframe package seeks to make storing data about data easy and seamless 
#' within the R ecosystem. Attributes of data can be stored as data.frame 
#' attributes making it easy for analysts to track the provenance of data 
#' through the data analysis process. 
#'
#' See the vignettes for usage examples
#'
#' @section metaframe functions:
#'
#' \itemize{
#'   \item \code{\link{document}}
#'   \item \code{\link{codebook}}
#' }
#'
#' @name metaframe
#' @docType package
#' @aliases metaframe metaframe-package
NULL

#' A subset of data from a 2015 study of school board elections in Wisconsin
#' @description Data on candidates in school board elections in Wisconsin.
#' @format A data frame with 5,854 observations on the following 4 variables.
#' \describe{
#'  \item{\code{candidateid2}}{a character ID consisting of a school board ID - candidate ID}
#'  \item{\code{nraces}}{a numeric vector for the number of races the candidate ran in}
#'  \item{\code{nwins}}{a numeric vector for the number of races won by the candidate}
#'  \item{\code{ninc}}{a numeric vector for the number of times the candidate was an incumbent}
#' }
#' @source Knowles, Jared E. 2015. School Boards and the Democratic Promise.
#' @references Knowles, Jared E. (2015). School Boards and the Democratic Promise.
#' PhD Dissertation. 
#' @examples
#' data(cand)
#' head(cand)
"cand"