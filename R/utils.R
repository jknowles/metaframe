stata_mode <- function(x){
  x <- as.character(x)
  z <- table(as.vector(x))
  m <- names(z)[z == max(z)]
  
  if (length(m) == 1){
    return(m)
  }
  return(".")
}

num_sum <- function(x){
  t(c(min = min(x, na.rm = TRUE),
      Q1 = quantile(x, prob = 0.25, na.rm = TRUE),
      median = median(x, na.rm = TRUE),
      Q3 = quantile(x, prob = 0.75, na.rm = TRUE),
      max =max(x, na.rm = TRUE),
      sd = sd(x, na.rm = TRUE),
      missing = sum(is.na(x == TRUE)),
      nunique = length(unique(x)), 
      mode = stata_mode(x),
      class = class(x)))
}

char_sum <- function(x){
  t(c(mode = stata_mode(x), 
    missing = sum(is.na(x == TRUE)),
    nunique = length(unique(x)), 
    class = class(x)))
}