
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

This is a basic example which shows you how to check for overlapping
thresholds:

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

or covert count tables to format accepted by `mem:memmodel()`

``` r
x <- tibble::tribble(
  ~week, ~year, ~flu_season,  ~rate,
  40,    2023,  "2023/2024",  2.5,
  41,    2023,  "2023/2024",  3.1,
  42,    2023,  "2023/2024",  4.2,
  40,    2024,  "2024/2025",  2.5,
  41,    2024,  "2024/2025",  3.1,
  42,    2024,  "2024/2025",  4.2,
  40,    2025,  "2025/2026",  2.5,
  41,    2025,  "2025/2026",  3.1,
  42,    2025,  "2025/2026",  4.2,
)


data_to_mem(
  x,
  seasons = c("2023/2024", "2024/2025"),
  week_col = week,
  year_col = year,
  season_col = flu_season,
  rate_col = rate,
  season_length = 33
)
#> # A tibble: 3 × 2
#>   `2023/2024` `2024/2025`
#>         <dbl>       <dbl>
#> 1         2.5         2.5
#> 2         3.1         3.1
#> 3         4.2         4.2
```

or quickly find out the flu season that a date belongs to

``` r

find_flu_season(as.Date("2023-11-15"), start_week = 40) # Expected: "2023/2024"
#> [1] "2023/2024"
```
