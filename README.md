<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/jknowles/metaframe.png?branch=master)](https://travis-ci.org/jknowles/metaframe) [![Coverage Status](http://img.shields.io/coveralls/jknowles/metaframe.svg?style=flat)](https://coveralls.io/r/jknowles/metaframe) [![Github Issues](http://githubbadges.herokuapp.com/jknowles/metaframe/issues.svg)](https://github.com/jknowles/metaframe/issues) [![Pending Pull-Requests](http://githubbadges.herokuapp.com/jknowles/metaframe/pulls.svg?style=flat)](https://github.com/jknowles/metaframe/pulls) [![License](https://img.shields.io/github/license/jknowles/metaframes.svg)](http://www.gnu.org/licenses/gpl.html)

An R package to extend the functionality of data.frame and data.frame-like objects with metadata and codebook annotations.

### Introduction

Metadata is not easily accessed and used in R and this is a big challenge to the efforts to make data analysis more automated and more reproducible. This package seeks to create a simple object-type for easily storing, updating, and outputting metadata during the course of an analysis project. This way the codebook can be baked right into the code.

### Overview

`metaframe` is organized around [a `meta.data` object](The%20object%20is%20deliberately%20named%20with%20a%20period,%20%60meta.data%60,%20to%20avoid). This is an S4 object that stores lists of attributes for a data set. The package will also contain a small set of basic functions to package a `data.frame` and a `meta.data` object together, while retaining the functionality of a `data.frame` with some additional enhancements.

### Storing Metadata in R

`metaframe` organizes your `meta.data` into a few categories -- some of which it can helpfully auto-complete for you.

### Example

Consider that we wish to document the `airquality` dataset built into R. After loading the dataset, you can call the `document` function to create a new object that contains the data, along with an attached `meta.data` attribute.

``` r
library(metaframe)
#> Loading required package: rmarkdown
#> Loading required package: knitr
doco <- document(airquality)
class(doco)
#> [1] "metaframe"  "data.frame"
```

The new documented object still behaves the way a `dataframe` would be expected to behave in R but with some additional information provided.

``` r
summary(doco)
#>      Ozone           Solar.R           Wind             Temp      
#>  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
#>  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
#>  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
#>  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
#>  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
#>  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
#>  NA's   :37       NA's   :7                                       
#>      Month            Day      
#>  Min.   :5.000   Min.   : 1.0  
#>  1st Qu.:6.000   1st Qu.: 8.0  
#>  Median :7.000   Median :16.0  
#>  Mean   :6.993   Mean   :15.8  
#>  3rd Qu.:8.000   3rd Qu.:23.0  
#>  Max.   :9.000   Max.   :31.0  
#>                                
#> ** Completeness of meta.data for object ** 
#> ----------------------------------------
#> Percentage of meta.data complete: 
#>     units    labels   sources     notes revisions 
#>         0         0         0       100       100 
#> ----- 
#> Complete elements by column: 
#>         units labels sources notes revisions
#> Ozone       0      0       0     1         1
#> Solar.R     0      0       0     1         1
#> Wind        0      0       0     1         1
#> Temp        0      0       0     1         1
#> Month       0      0       0     1         1
#> Day         0      0       0     1         1
print(doco)
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
#> Output truncated to first 10 rows 
#> 
#>    Ozone Solar.R Wind Temp Month Day
#> 1     41     190  7.4   67     5   1
#> 2     36     118  8.0   72     5   2
#> 3     12     149 12.6   74     5   3
#> 4     18     313 11.5   62     5   4
#> 5     NA      NA 14.3   56     5   5
#> 6     28      NA 14.9   66     5   6
#> 7     23     299  8.6   65     5   7
#> 8     19      99 13.8   59     5   8
#> 9      8      19 20.1   61     5   9
#> 10    NA     194  8.6   69     5  10
```

``` r
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

Adding Metadata
---------------

The basic metadata is not very helpful, just some basic numeric summaries re-organized. The power of `metaframe` comes from the ability to add metadata directly to the data object and to render that metadata out.

To do this, you can use a named list with names referring to the columns in the `metaframe` object.

``` r
# Column labels

my_data_labels <- list("Ozone" = "numeric Ozone (ppb)")
```

``` r
doco <- add_label(doco, label = my_data_labels)
```

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

confusion when rendering HTML documents, mimic the formatting of `data.frame`, and to make searching for this specific implementation of metadata in R easier.
