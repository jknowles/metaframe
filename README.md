<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/jknowles/metaframe.png?branch=master)](https://travis-ci.org/jknowles/metaframe) [![Coverage Status](http://img.shields.io/coveralls/jknowles/metaframe.svg?style=flat)](https://coveralls.io/r/jknowles/metaframe) [![Github Issues](http://githubbadges.herokuapp.com/jknowles/metaframe/issues.svg)](https://github.com/jknowles/metaframe/issues) [![Pending Pull-Requests](http://githubbadges.herokuapp.com/jknowles/metaframe/pulls.svg?style=flat)](https://github.com/jknowles/metaframe/pulls) [![License](https://img.shields.io/github/license/jknowles/metaframes.svg)](http://www.gnu.org/licenses/gpl.html)

An R package to extend the functionality of data.frame and data.frame-like objects with metadata and codebook annotations.

### Introduction

Metadata is not easily accessed and used in R and this is a big challenge to the efforts to make data analysis more automated and more reproducible. This package seeks to create a simple object-type for easily storing, updating, and outputting metadata during the course of an analysis project. This way the codebook can be baked right into the code.

### Overview

`metaframe` is organized around [a `meta.data` object](The%20object%20is%20deliberately%20named%20with%20a%20period,%20`meta.data`,%20to%20avoid). This is an S4 object that stores lists of attributes for a data set. The package will also contain a small set of basic functions to package a `data.frame` and a `meta.data` object together, while retaining the functionality of a `data.frame` with some additional enhancements.

### Storing Metadata in R

`metaframe` organizes your `meta.data` into a few categories -- some of which it can helpfully auto-complete for you.

### Example

``` r
library(metaframe)
#> Loading required package: rmarkdown
#> Warning: package 'rmarkdown' was built under R version 3.2.2
doco <- document(airquality)
class(doco)
#> [1] "meta.frame" "data.frame"
print(attr(doco, "meta.data"))
#> Showing metadata for object:  airquality
#>  ------------------------------------------------------------- 
#> Showing metadata for following variables in object: 
#>  OVERALL :  
#>  Ozone :  
#>  Solar.R :  
#>  Wind :  
#>  Temp :  
#>  Month :  
#>  Day :  
#>  
#> ---------------------------------------------------------------- 
#> Data from following sources: 
#>  OVERALL :  
#>  Ozone :  
#>  Solar.R :  
#>  Wind :  
#>  Temp :  
#>  Month :  
#>  Day :  
#>  
#> ---------------------------------------------------------------- 
#> Data expressed in the following units: 
#>  Ozone :  
#>  Solar.R :  
#>  Wind :  
#>  Temp :  
#>  Month :  
#>  Day :  
#>  
#> ---------------------------------------------------------------- 
#> Additional notes on the data: 
#>   : No notes listed. 
#>  
#> ---------------------------------------------------------------- 
#> Revision history for data elements: 
#>   : No revisions listed. 
#>  
#> ----------------------------------------------------------------
```

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

confusion when rendering HTML documents, mimic the formatting of `data.frame`, and to make searching for this specific implementation of metadata in R easier.
