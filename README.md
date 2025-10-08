
<!-- README.md is generated from README.Rmd. Please edit that file -->

# threshtools

<!-- badges: start -->
<!-- badges: end -->

This package was built to aid users in calculating and evaluating
activity level thresholds for epidemiological surveillance data. It
should be used alongside functions from the {mem} package and includes
some useful functions for tidying up `memmodel` outputs.

## Installation

You can install the development version of threshtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("matthh10/threshtools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(threshtools)

x <- dplyr::tibble(
  indicator = c("a", "b"),
  low = c(0.5, 1.2),
  medium = c(1.1, 0.8),
  high = c(2.5, 3.1),
  very_high = c(3.7, 4.2)
)

check_thresholds(x)
#> ✖ Overlapping thresholds detected.
#> ℹ Check the following thresholds and consider changing method of calculation:
#> 
#> # A tibble: 1 × 6
#>   indicator   low medium  high very_high alert
#>   <chr>     <dbl>  <dbl> <dbl>     <dbl> <lgl>
#> 1 b           1.2    0.8   3.1       4.2 TRUE
```
