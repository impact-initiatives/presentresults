
<!-- README.md is generated from README.Rmd. Please edit that file -->

# presentresults

<!-- badges: start -->

[![check-standard](https://github.com/impact-initiatives/presentresults/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/impact-initiatives/presentresults/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/impact-initiatives/presentresults/branch/main/graph/badge.svg)](https://app.codecov.io/gh/impact-initiatives/presentresults?branch=main)
<!-- badges: end -->

The goal of presentresults is to outputs from a results table (long
format with analysis key).

## Installation

You can install the development version of presentresults from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("impact-initiatives/presentresults")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(presentresults)
try_results <- data.frame(analysis_index = c("mean @/@ v1 ~/~ NA @/@ NA ~/~ NA",
                                             "mean @/@ v1 ~/~ NA @/@ gro ~/~ A",
                                             "mean @/@ v1 ~/~ NA @/@ gro ~/~ B"),
                          stat = c(1:3))
create_table_variable_x_group(try_results, "analysis_index", "stat")
#> # A tibble: 1 × 6
#>   analysis_type analysis_var analysis_var_value  `NA`     A     B
#>   <chr>         <chr>        <chr>              <int> <int> <int>
#> 1 mean          v1           NA                     1     2     3
```
