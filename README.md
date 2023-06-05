
<!-- README.md is generated from README.Rmd. Please edit that file -->

# presentresults

<!-- badges: start -->

[![check-standard](https://github.com/impact-initiatives/presentresults/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/impact-initiatives/presentresults/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/impact-initiatives/presentresults/branch/main/graph/badge.svg)](https://app.codecov.io/gh/impact-initiatives/presentresults?branch=main)
<!-- badges: end -->

The goal of presentresults is to present the results from a results
table (long format with analysis key).

## Installation

You can install the development version of presentresults from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("impact-initiatives/presentresults")
```

## Large table variables (lines) per groups (columns)

This is how to turn a results table into a wide variable per group.

``` r
library(presentresults)
try_results <- data.frame(
  analysis_index = c(
    "mean @/@ v1 ~/~ NA @/@ NA ~/~ NA",
    "mean @/@ v1 ~/~ NA @/@ gro ~/~ A",
    "mean @/@ v1 ~/~ NA @/@ gro ~/~ B"
  ),
  stat = c(1:3)
)
create_table_variable_x_group(try_results, "analysis_index", "stat")
#> # A tibble: 1 × 6
#>   analysis_type analysis_var analysis_var_value  `NA`     A     B
#>   <chr>         <chr>        <chr>              <int> <int> <int>
#> 1 mean          v1           NA                     1     2     3
```

## Large table groups (lines) per variables (columns)

This is how to turn a results table into a wide group per variable.

``` r
example_group_x_variable <- create_table_group_x_variable(presentresults_resultstable, value_columns = "stat")
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].

head(example_group_x_variable)
#>                                       group_var_value
#> header_analysis_var                   group_var_value
#> header_analysis_var_value             group_var_value
#> header_analysis_type                  group_var_value
#> 1                             locationA ~/~ displaced
#> 2                         locationA ~/~ non-displaced
#> 3                             locationB ~/~ displaced
#>                           fcs_cat ~/~ low ~/~ prop_select_one
#> header_analysis_var                                   fcs_cat
#> header_analysis_var_value                                 low
#> header_analysis_type                          prop_select_one
#> 1                                           0.258064516129032
#> 2                                                        0.25
#> 3                                            0.37037037037037
#>                           fcs_cat ~/~ medium ~/~ prop_select_one
#> header_analysis_var                                      fcs_cat
#> header_analysis_var_value                                 medium
#> header_analysis_type                             prop_select_one
#> 1                                               0.32258064516129
#> 2                                                          0.375
#> 3                                              0.407407407407407
#>                           fcs_cat ~/~ high ~/~ prop_select_one
#> header_analysis_var                                    fcs_cat
#> header_analysis_var_value                                 high
#> header_analysis_type                           prop_select_one
#> 1                                            0.419354838709677
#> 2                                                        0.375
#> 3                                            0.222222222222222
#>                           rcsi_cat ~/~ low ~/~ prop_select_one
#> header_analysis_var                                   rcsi_cat
#> header_analysis_var_value                                  low
#> header_analysis_type                           prop_select_one
#> 1                                            0.290322580645161
#> 2                                                        0.375
#> 3                                            0.259259259259259
#>                           rcsi_cat ~/~ medium ~/~ prop_select_one
#> header_analysis_var                                      rcsi_cat
#> header_analysis_var_value                                  medium
#> header_analysis_type                              prop_select_one
#> 1                                               0.258064516129032
#> 2                                               0.458333333333333
#> 3                                               0.518518518518518
#>                           rcsi_cat ~/~ high ~/~ prop_select_one
#> header_analysis_var                                    rcsi_cat
#> header_analysis_var_value                                  high
#> header_analysis_type                            prop_select_one
#> 1                                             0.451612903225806
#> 2                                             0.166666666666667
#> 3                                             0.222222222222222
#>                           lcs_cat ~/~ none ~/~ prop_select_one
#> header_analysis_var                                    lcs_cat
#> header_analysis_var_value                                 none
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                           0.0416666666666667
#> 3                                            0.296296296296296
#>                           lcs_cat ~/~ stress ~/~ prop_select_one
#> header_analysis_var                                      lcs_cat
#> header_analysis_var_value                                 stress
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                              0.458333333333333
#> 3                                              0.259259259259259
#>                           lcs_cat ~/~ emergency ~/~ prop_select_one
#> header_analysis_var                                         lcs_cat
#> header_analysis_var_value                                 emergency
#> header_analysis_type                                prop_select_one
#> 1                                                  0.32258064516129
#> 2                                                 0.291666666666667
#> 3                                                 0.185185185185185
#>                           lcs_cat ~/~ crisis ~/~ prop_select_one
#> header_analysis_var                                      lcs_cat
#> header_analysis_var_value                                 crisis
#> header_analysis_type                             prop_select_one
#> 1                                              0.354838709677419
#> 2                                              0.208333333333333
#> 3                                              0.259259259259259
#>                           hhs_cat ~/~ none ~/~ prop_select_one
#> header_analysis_var                                    hhs_cat
#> header_analysis_var_value                                 none
#> header_analysis_type                           prop_select_one
#> 1                                            0.225806451612903
#> 2                                            0.208333333333333
#> 3                                            0.222222222222222
#>                           hhs_cat ~/~ slight ~/~ prop_select_one
#> header_analysis_var                                      hhs_cat
#> header_analysis_var_value                                 slight
#> header_analysis_type                             prop_select_one
#> 1                                              0.258064516129032
#> 2                                              0.291666666666667
#> 3                                              0.222222222222222
#>                           hhs_cat ~/~ moderate ~/~ prop_select_one
#> header_analysis_var                                        hhs_cat
#> header_analysis_var_value                                 moderate
#> header_analysis_type                               prop_select_one
#> 1                                                0.225806451612903
#> 2                                               0.0833333333333333
#> 3                                                0.222222222222222
#>                           hhs_cat ~/~ severe ~/~ prop_select_one
#> header_analysis_var                                      hhs_cat
#> header_analysis_var_value                                 severe
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                                           0.25
#> 3                                              0.222222222222222
#>                           hhs_cat ~/~ very_severe ~/~ prop_select_one
#> header_analysis_var                                           hhs_cat
#> header_analysis_var_value                                 very_severe
#> header_analysis_type                                  prop_select_one
#> 1                                                   0.193548387096774
#> 2                                                   0.166666666666667
#> 3                                                   0.111111111111111
#>                           fcm_cat ~/~ phase_1 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_1
#> header_analysis_type                              prop_select_one
#> 1                                               0.290322580645161
#> 2                                                            0.25
#> 3                                               0.222222222222222
#>                           fcm_cat ~/~ phase_2 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_2
#> header_analysis_type                              prop_select_one
#> 1                                              0.0967741935483871
#> 2                                              0.0833333333333333
#> 3                                               0.185185185185185
#>                           fcm_cat ~/~ phase_3 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_3
#> header_analysis_type                              prop_select_one
#> 1                                                0.32258064516129
#> 2                                               0.166666666666667
#> 3                                               0.111111111111111
#>                           fcm_cat ~/~ phase_4 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_4
#> header_analysis_type                              prop_select_one
#> 1                                               0.161290322580645
#> 2                                               0.208333333333333
#> 3                                               0.222222222222222
#>                           fcm_cat ~/~ phase_5 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_5
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                               0.291666666666667
#> 3                                               0.259259259259259
#>                           fcls_cat ~/~ phase_1 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_1
#> header_analysis_type                               prop_select_one
#> 1                                                0.161290322580645
#> 2                                               0.0833333333333333
#> 3                                                0.111111111111111
#>                           fcls_cat ~/~ phase_2 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_2
#> header_analysis_type                               prop_select_one
#> 1                                                0.225806451612903
#> 2                                               0.0833333333333333
#> 3                                                0.333333333333333
#>                           fcls_cat ~/~ phase_3 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_3
#> header_analysis_type                               prop_select_one
#> 1                                                0.258064516129032
#> 2                                                0.291666666666667
#> 3                                                0.185185185185185
#>                           fcls_cat ~/~ phase_4 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_4
#> header_analysis_type                               prop_select_one
#> 1                                                0.193548387096774
#> 2                                                0.208333333333333
#> 3                                                0.185185185185185
#>                           fcls_cat ~/~ phase_5 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_5
#> header_analysis_type                               prop_select_one
#> 1                                                0.161290322580645
#> 2                                                0.333333333333333
#> 3                                                0.185185185185185
#>                           rCSILessQlty ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      0
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.185185185185185
#>                           rCSILessQlty ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      1
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                             0.0416666666666667
#> 3                                              0.222222222222222
#>                           rCSILessQlty ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      2
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSILessQlty ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      3
#> header_analysis_type                             prop_select_one
#> 1                                              0.225806451612903
#> 2                                              0.208333333333333
#> 3                                              0.111111111111111
#>                           rCSILessQlty ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      4
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.111111111111111
#>                           rCSILessQlty ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      5
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                              0.166666666666667
#> 3                                             0.0740740740740741
#>                           rCSILessQlty ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      6
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                             0.0740740740740741
#>                           rCSILessQlty ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      7
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                             0.0416666666666667
#> 3                                             0.0740740740740741
#>                           rCSIBorrow ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    0
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.166666666666667
#> 3                                            0.259259259259259
#>                           rCSIBorrow ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    1
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                        0.125
#> 3                                            0.222222222222222
#>                           rCSIBorrow ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    2
#> header_analysis_type                           prop_select_one
#> 1                                           0.0645161290322581
#> 2                                            0.291666666666667
#> 3                                                         <NA>
#>                           rCSIBorrow ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    3
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                                        0.125
#> 3                                           0.0740740740740741
#>                           rCSIBorrow ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    4
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                           0.0833333333333333
#> 3                                            0.148148148148148
#>                           rCSIBorrow ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    5
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                           0.0833333333333333
#> 3                                           0.0740740740740741
#>                           rCSIBorrow ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    6
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                        0.125
#> 3                                            0.037037037037037
#>                           rCSIBorrow ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    7
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                         <NA>
#> 3                                            0.185185185185185
#>                           rCSIMealSize ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      0
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                                          0.125
#> 3                                              0.185185185185185
#>                           rCSIMealSize ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      1
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                             0.0416666666666667
#> 3                                              0.111111111111111
#>                           rCSIMealSize ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      2
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                             0.0833333333333333
#> 3                                              0.185185185185185
#>                           rCSIMealSize ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      3
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSIMealSize ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      4
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                                          0.125
#> 3                                              0.037037037037037
#>                           rCSIMealSize ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      5
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                              0.166666666666667
#> 3                                             0.0740740740740741
#>                           rCSIMealSize ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      6
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.111111111111111
#>                           rCSIMealSize ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      7
#> header_analysis_type                             prop_select_one
#> 1                                              0.193548387096774
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSIMealAdult ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       0
#> header_analysis_type                              prop_select_one
#> 1                                              0.0645161290322581
#> 2                                              0.0833333333333333
#> 3                                              0.0740740740740741
#>                           rCSIMealAdult ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       1
#> header_analysis_type                              prop_select_one
#> 1                                               0.258064516129032
#> 2                                                           0.125
#> 3                                              0.0740740740740741
#>                           rCSIMealAdult ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       2
#> header_analysis_type                              prop_select_one
#> 1                                               0.225806451612903
#> 2                                                           0.125
#> 3                                               0.185185185185185
#>                           rCSIMealAdult ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       3
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                              0.0833333333333333
#> 3                                               0.222222222222222
#>                           rCSIMealAdult ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       4
#> header_analysis_type                              prop_select_one
#> 1                                              0.0967741935483871
#> 2                                               0.208333333333333
#> 3                                               0.111111111111111
#>                           rCSIMealAdult ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       5
#> header_analysis_type                              prop_select_one
#> 1                                               0.032258064516129
#> 2                                                           0.125
#> 3                                               0.037037037037037
#>                           rCSIMealAdult ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       6
#> header_analysis_type                              prop_select_one
#> 1                                              0.0645161290322581
#> 2                                                           0.125
#> 3                                               0.148148148148148
#>                           rCSIMealAdult ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       7
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                                           0.125
#> 3                                               0.148148148148148
#>                           rCSIMealNb ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    0
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                        0.125
#> 3                                            0.185185185185185
#>                           rCSIMealNb ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    1
#> header_analysis_type                           prop_select_one
#> 1                                            0.161290322580645
#> 2                                                        0.125
#> 3                                            0.148148148148148
#>                           rCSIMealNb ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    2
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                                        0.125
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    3
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.208333333333333
#> 3                                            0.296296296296296
#>                           rCSIMealNb ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    4
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.166666666666667
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    5
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                        0.125
#> 3                                            0.111111111111111
#>                           rCSIMealNb ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    6
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                         <NA>
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    7
#> header_analysis_type                           prop_select_one
#> 1                                           0.0645161290322581
#> 2                                                        0.125
#> 3                                            0.037037037037037
#>                           liv_stress_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_1
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                                          0.125
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_1
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.208333333333333
#> 3                                                                0.259259259259259
#>                           liv_stress_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_1
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.290322580645161
#> 2                                                                0.291666666666667
#> 3                                                                0.185185185185185
#>                           liv_stress_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_1
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.258064516129032
#> 2                                                                 0.375
#> 3                                                     0.259259259259259
#>                           liv_stress_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_2
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                              0.208333333333333
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_2
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.290322580645161
#> 2                                                                0.166666666666667
#> 3                                                                0.222222222222222
#>                           liv_stress_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_2
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.291666666666667
#> 3                                                                0.259259259259259
#>                           liv_stress_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_2
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.258064516129032
#> 2                                                     0.333333333333333
#> 3                                                     0.222222222222222
#>                           liv_stress_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_3
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.258064516129032
#> 2                                                              0.291666666666667
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_3
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                 0.32258064516129
#> 2                                                                0.208333333333333
#> 3                                                                0.333333333333333
#>                           liv_stress_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_3
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                 0.32258064516129
#> 2                                                                             0.25
#> 3                                                               0.0740740740740741
#>                           liv_stress_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_3
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                    0.0967741935483871
#> 2                                                                  0.25
#> 3                                                     0.296296296296296
#>                           liv_stress_lcsi_4 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_4
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.387096774193548
#> 2                                                                          0.375
#> 3                                                              0.222222222222222
#>                           liv_stress_lcsi_4 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_4
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.129032258064516
#> 2                                                                            0.125
#> 3                                                                0.185185185185185
#>                           liv_stress_lcsi_4 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_4
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.291666666666667
#> 3                                                                0.222222222222222
#>                           liv_stress_lcsi_4 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_4
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.225806451612903
#> 2                                                     0.208333333333333
#> 3                                                      0.37037037037037
#>                           liv_crisis_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_1
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.290322580645161
#> 2                                                              0.208333333333333
#> 3                                                              0.259259259259259
#>                           liv_crisis_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_1
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.225806451612903
#> 2                                                                0.166666666666667
#> 3                                                                0.296296296296296
#>                           liv_crisis_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_1
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.161290322580645
#> 2                                                                             0.25
#> 3                                                                0.296296296296296
#>                           liv_crisis_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_1
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                      0.32258064516129
#> 2                                                                 0.375
#> 3                                                     0.148148148148148
#>                           liv_crisis_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_2
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.387096774193548
#> 2                                                                          0.375
#> 3                                                              0.259259259259259
#>                           liv_crisis_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_2
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.225806451612903
#> 2                                                                0.166666666666667
#> 3                                                                0.407407407407407
#>                           liv_crisis_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_2
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.161290322580645
#> 2                                                                0.166666666666667
#> 3                                                                0.148148148148148
#>                           liv_crisis_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_2
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.225806451612903
#> 2                                                     0.291666666666667
#> 3                                                     0.185185185185185
#>                           liv_crisis_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_3
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                              0.291666666666667
#> 3                                                               0.37037037037037
#>                           liv_crisis_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_3
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.129032258064516
#> 2                                                                            0.125
#> 3                                                                0.185185185185185
#>                           liv_crisis_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_3
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.387096774193548
#> 2                                                                0.333333333333333
#> 3                                                                0.222222222222222
#>                           liv_crisis_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_3
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.290322580645161
#> 2                                                                  0.25
#> 3                                                     0.222222222222222
#>                           liv_emerg_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_1
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.129032258064516
#> 2                                                             0.166666666666667
#> 3                                                             0.222222222222222
#>                           liv_emerg_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_1
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.193548387096774
#> 2                                                                            0.25
#> 3                                                               0.333333333333333
#>                           liv_emerg_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_1
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.290322580645161
#> 2                                                                            0.25
#> 3                                                               0.185185185185185
#>                           liv_emerg_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_1
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.387096774193548
#> 2                                                    0.333333333333333
#> 3                                                    0.259259259259259
#>                           liv_emerg_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_2
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.161290322580645
#> 2                                                             0.166666666666667
#> 3                                                             0.148148148148148
#>                           liv_emerg_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_2
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.387096774193548
#> 2                                                                            0.25
#> 3                                                               0.333333333333333
#>                           liv_emerg_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_2
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.193548387096774
#> 2                                                               0.416666666666667
#> 3                                                               0.222222222222222
#>                           liv_emerg_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_2
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.258064516129032
#> 2                                                    0.166666666666667
#> 3                                                    0.296296296296296
#>                           liv_emerg_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_3
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.225806451612903
#> 2                                                                          0.25
#> 3                                                             0.296296296296296
#>                           liv_emerg_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_3
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.161290322580645
#> 2                                                               0.333333333333333
#> 3                                                               0.296296296296296
#>                           liv_emerg_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_3
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.419354838709677
#> 2                                                               0.291666666666667
#> 3                                                               0.222222222222222
#>                           liv_emerg_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_3
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.193548387096774
#> 2                                                                0.125
#> 3                                                    0.185185185185185
#>                           fs_hhs_nofood_yn ~/~ no ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_nofood_yn
#> header_analysis_var_value                                          no
#> header_analysis_type                                  prop_select_one
#> 1                                                   0.419354838709677
#> 2                                                                 0.5
#> 3                                                   0.518518518518518
#>                           fs_hhs_nofood_yn ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   fs_hhs_nofood_yn
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.580645161290323
#> 2                                                                  0.5
#> 3                                                    0.481481481481481
#>                           fs_hhs_nofood_freq ~/~ often_10_times ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_nofood_freq
#> header_analysis_var_value                                            often_10_times
#> header_analysis_type                                                prop_select_one
#> 1                                                                 0.333333333333333
#> 2                                                                0.0833333333333333
#> 3                                                                 0.384615384615385
#>                           fs_hhs_nofood_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> header_analysis_var                                          fs_hhs_nofood_freq
#> header_analysis_var_value                                            rarely_1_2
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.555555555555556
#> 2                                                                           0.5
#> 3                                                            0.0769230769230769
#>                           fs_hhs_nofood_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_nofood_freq
#> header_analysis_var_value                                            sometimes_3_10
#> header_analysis_type                                                prop_select_one
#> 1                                                                 0.111111111111111
#> 2                                                                 0.416666666666667
#> 3                                                                 0.538461538461539
#>                           fs_hhs_nofood_freq ~/~ NA ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_nofood_freq
#> header_analysis_var_value                                          <NA>
#> header_analysis_type                                    prop_select_one
#> 1                                                                     0
#> 2                                                                     0
#> 3                                                                     0
#>                           fs_hhs_sleephungry_yn ~/~ no ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_sleephungry_yn
#> header_analysis_var_value                                               no
#> header_analysis_type                                       prop_select_one
#> 1                                                        0.483870967741935
#> 2                                                        0.416666666666667
#> 3                                                        0.555555555555556
#>                           fs_hhs_sleephungry_yn ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   fs_hhs_sleephungry_yn
#> header_analysis_var_value                                               yes
#> header_analysis_type                                        prop_select_one
#> 1                                                         0.516129032258065
#> 2                                                         0.583333333333333
#> 3                                                         0.444444444444444
#>                           fs_hhs_sleephungry_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> header_analysis_var                                          fs_hhs_sleephungry_freq
#> header_analysis_var_value                                                 rarely_1_2
#> header_analysis_type                                                 prop_select_one
#> 1                                                                               0.75
#> 2                                                                                0.4
#> 3                                                                  0.176470588235294
#>                           fs_hhs_sleephungry_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_sleephungry_freq
#> header_analysis_var_value                                                 sometimes_3_10
#> header_analysis_type                                                     prop_select_one
#> 1                                                                                   0.25
#> 2                                                                      0.466666666666667
#> 3                                                                      0.294117647058824
#>                           fs_hhs_sleephungry_freq ~/~ NA ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_sleephungry_freq
#> header_analysis_var_value                                               <NA>
#> header_analysis_type                                         prop_select_one
#> 1                                                                          0
#> 2                                                                          0
#> 3                                                                          0
#>                           fs_hhs_sleephungry_freq ~/~ often_10_times ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_sleephungry_freq
#> header_analysis_var_value                                                 often_10_times
#> header_analysis_type                                                     prop_select_one
#> 1                                                                                   <NA>
#> 2                                                                      0.133333333333333
#> 3                                                                      0.529411764705882
#>                           fs_hhs_daynoteating_yn ~/~ no ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_daynoteating_yn
#> header_analysis_var_value                                                no
#> header_analysis_type                                        prop_select_one
#> 1                                                         0.612903225806452
#> 2                                                                     0.375
#> 3                                                          0.37037037037037
#>                           fs_hhs_daynoteating_yn ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   fs_hhs_daynoteating_yn
#> header_analysis_var_value                                                yes
#> header_analysis_type                                         prop_select_one
#> 1                                                          0.387096774193548
#> 2                                                                      0.625
#> 3                                                           0.62962962962963
#>                           fs_hhs_daynoteating_freq ~/~ often_10_times ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_daynoteating_freq
#> header_analysis_var_value                                                  often_10_times
#> header_analysis_type                                                      prop_select_one
#> 1                                                                                     0.5
#> 2                                                                       0.166666666666667
#> 3                                                                       0.384615384615385
#>                           fs_hhs_daynoteating_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> header_analysis_var                                          fs_hhs_daynoteating_freq
#> header_analysis_var_value                                                  rarely_1_2
#> header_analysis_type                                                  prop_select_one
#> 1                                                                   0.277777777777778
#> 2                                                                   0.666666666666667
#> 3                                                                   0.384615384615385
#>                           fs_hhs_daynoteating_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> header_analysis_var                                              fs_hhs_daynoteating_freq
#> header_analysis_var_value                                                  sometimes_3_10
#> header_analysis_type                                                      prop_select_one
#> 1                                                                       0.222222222222222
#> 2                                                                       0.166666666666667
#> 3                                                                       0.230769230769231
#>                           fs_hhs_daynoteating_freq ~/~ NA ~/~ prop_select_one
#> header_analysis_var                                  fs_hhs_daynoteating_freq
#> header_analysis_var_value                                                <NA>
#> header_analysis_type                                          prop_select_one
#> 1                                                                           0
#> 2                                                                           0
#> 3                                                                           0
#>                           fs_food_sources_top1 ~/~ begging ~/~ prop_select_one
#> header_analysis_var                                       fs_food_sources_top1
#> header_analysis_var_value                                              begging
#> header_analysis_type                                           prop_select_one
#> 1                                                            0.129032258064516
#> 2                                                                        0.125
#> 3                                                                         <NA>
#>                           fs_food_sources_top1 ~/~ borrowed ~/~ prop_select_one
#> header_analysis_var                                        fs_food_sources_top1
#> header_analysis_var_value                                              borrowed
#> header_analysis_type                                            prop_select_one
#> 1                                                            0.0645161290322581
#> 2                                                            0.0833333333333333
#> 3                                                            0.0740740740740741
#>                           fs_food_sources_top1 ~/~ dont_know ~/~ prop_select_one
#> header_analysis_var                                         fs_food_sources_top1
#> header_analysis_var_value                                              dont_know
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.032258064516129
#> 2                                                             0.0416666666666667
#> 3                                                                           <NA>
#>                           fs_food_sources_top1 ~/~ exchange ~/~ prop_select_one
#> header_analysis_var                                        fs_food_sources_top1
#> header_analysis_var_value                                              exchange
#> header_analysis_type                                            prop_select_one
#> 1                                                            0.0967741935483871
#> 2                                                            0.0416666666666667
#> 3                                                             0.111111111111111
#>                           fs_food_sources_top1 ~/~ gathering ~/~ prop_select_one
#> header_analysis_var                                         fs_food_sources_top1
#> header_analysis_var_value                                              gathering
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.032258064516129
#> 2                                                                           <NA>
#> 3                                                              0.037037037037037
#>                           fs_food_sources_top1 ~/~ gift ~/~ prop_select_one
#> header_analysis_var                                    fs_food_sources_top1
#> header_analysis_var_value                                              gift
#> header_analysis_type                                        prop_select_one
#> 1                                                         0.032258064516129
#> 2                                                                      <NA>
#> 3                                                        0.0740740740740741
#>                           fs_food_sources_top1 ~/~ hunting_fishing ~/~ prop_select_one
#> header_analysis_var                                               fs_food_sources_top1
#> header_analysis_var_value                                              hunting_fishing
#> header_analysis_type                                                   prop_select_one
#> 1                                                                   0.0967741935483871
#> 2                                                                                 <NA>
#> 3                                                                                 <NA>
#>                           fs_food_sources_top1 ~/~ in_kind_aid ~/~ prop_select_one
#> header_analysis_var                                           fs_food_sources_top1
#> header_analysis_var_value                                              in_kind_aid
#> header_analysis_type                                               prop_select_one
#> 1                                                               0.0645161290322581
#> 2                                                                0.208333333333333
#> 3                                                               0.0740740740740741
#>                           fs_food_sources_top1 ~/~ none ~/~ prop_select_one
#> header_analysis_var                                    fs_food_sources_top1
#> header_analysis_var_value                                              none
#> header_analysis_type                                        prop_select_one
#> 1                                                        0.0645161290322581
#> 2                                                         0.166666666666667
#> 3                                                        0.0740740740740741
#>                           fs_food_sources_top1 ~/~ other ~/~ prop_select_one
#> header_analysis_var                                     fs_food_sources_top1
#> header_analysis_var_value                                              other
#> header_analysis_type                                         prop_select_one
#> 1                                                          0.129032258064516
#> 2                                                                       <NA>
#> 3                                                                       <NA>
#>                           fs_food_sources_top1 ~/~ own_production ~/~ prop_select_one
#> header_analysis_var                                              fs_food_sources_top1
#> header_analysis_var_value                                              own_production
#> header_analysis_type                                                  prop_select_one
#> 1                                                                   0.032258064516129
#> 2                                                                                <NA>
#> 3                                                                  0.0740740740740741
#>                           fs_food_sources_top1 ~/~ prefer_not_to_answer ~/~ prop_select_one
#> header_analysis_var                                                    fs_food_sources_top1
#> header_analysis_var_value                                              prefer_not_to_answer
#> header_analysis_type                                                        prop_select_one
#> 1                                                                        0.0645161290322581
#> 2                                                                        0.0833333333333333
#> 3                                                                        0.0740740740740741
#>                           fs_food_sources_top1 ~/~ purchased ~/~ prop_select_one
#> header_analysis_var                                         fs_food_sources_top1
#> header_analysis_var_value                                              purchased
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.129032258064516
#> 2                                                             0.0833333333333333
#> 3                                                              0.185185185185185
#>                           fs_food_sources_top1 ~/~ purchased_cash ~/~ prop_select_one
#> header_analysis_var                                              fs_food_sources_top1
#> header_analysis_var_value                                              purchased_cash
#> header_analysis_type                                                  prop_select_one
#> 1                                                                   0.032258064516129
#> 2                                                                  0.0833333333333333
#> 3                                                                   0.148148148148148
#>                           fs_food_sources_top1 ~/~ cva ~/~ prop_select_one
#> header_analysis_var                                   fs_food_sources_top1
#> header_analysis_var_value                                              cva
#> header_analysis_type                                       prop_select_one
#> 1                                                                     <NA>
#> 2                                                       0.0833333333333333
#> 3                                                       0.0740740740740741
#>                           rCSILessQlty ~/~ NA ~/~ mean
#> header_analysis_var                       rCSILessQlty
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.09677419354839
#> 2                                                3.375
#> 3                                     2.62962962962963
#>                           rCSIBorrow ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIBorrow
#> header_analysis_var_value                       <NA>
#> header_analysis_type                            mean
#> 1                                   3.48387096774194
#> 2                                   2.58333333333333
#> 3                                   2.92592592592593
#>                           rCSIMealSize ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealSize
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.80645161290323
#> 2                                     3.95833333333333
#> 3                                     3.14814814814815
#>                           rCSIMealAdult ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealAdult
#> header_analysis_var_value                          <NA>
#> header_analysis_type                               mean
#> 1                                      2.93548387096774
#> 2                                      3.70833333333333
#> 3                                      3.66666666666667
#>                           rCSIMealNb ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealNb
#> header_analysis_var_value                       <NA>
#> header_analysis_type                            mean
#> 1                                   2.96774193548387
#> 2                                   3.16666666666667
#> 3                                   2.74074074074074
#>                           fs_fcs_cereals_grains_roots_tubers ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_cereals_grains_roots_tubers
#> header_analysis_var_value                                               <NA>
#> header_analysis_type                                                    mean
#> 1                                                           3.67741935483871
#> 2                                                           3.54166666666667
#> 3                                                           3.74074074074074
#>                           fs_fcs_beans_nuts ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_beans_nuts
#> header_analysis_var_value                              <NA>
#> header_analysis_type                                   mean
#> 1                                          3.45161290322581
#> 2                                          3.66666666666667
#> 3                                          3.03703703703704
#>                           fs_fcs_dairy ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_dairy
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.35483870967742
#> 2                                     3.95833333333333
#> 3                                     3.48148148148148
#>                           fs_fcs_meat_fish_eggs ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_meat_fish_eggs
#> header_analysis_var_value                                  <NA>
#> header_analysis_type                                       mean
#> 1                                              3.16129032258065
#> 2                                              3.91666666666667
#> 3                                               4.2962962962963
#>                           fs_fcs_vegetables_leaves ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_vegetables_leaves
#> header_analysis_var_value                                     <NA>
#> header_analysis_type                                          mean
#> 1                                                 3.45161290322581
#> 2                                                 3.16666666666667
#> 3                                                 3.18518518518519
#>                           fs_fcs_fruit ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_fruit
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.45161290322581
#> 2                                                3.875
#> 3                                      3.7037037037037
#>                           fs_fcs_oil_fat_butter ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_oil_fat_butter
#> header_analysis_var_value                                  <NA>
#> header_analysis_type                                       mean
#> 1                                              3.64516129032258
#> 2                                              4.41666666666667
#> 3                                              3.55555555555556
#>                           fs_fcs_sugar ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_sugar
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                      3.2258064516129
#> 2                                                    4
#> 3                                     3.92592592592593
#>                           fs_fcs_condiment ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_condiment
#> header_analysis_var_value                             <NA>
#> header_analysis_type                                  mean
#> 1                                         4.06451612903226
#> 2                                         3.70833333333333
#> 3                                         2.59259259259259
#>                           income_v2_sum ~/~ NA ~/~ mean
#> header_analysis_var                       income_v2_sum
#> header_analysis_var_value                          <NA>
#> header_analysis_type                               mean
#> 1                                                  <NA>
#> 2                                                  <NA>
#> 3                                                  <NA>
#>                           expenditure_food ~/~ NA ~/~ mean
#> header_analysis_var                       expenditure_food
#> header_analysis_var_value                             <NA>
#> header_analysis_type                                  mean
#> 1                                         20.1935483870968
#> 2                                         20.2916666666667
#> 3                                         19.7037037037037
```

## Create an IPC TWG table

``` r
example_ipc <- create_ipctwg_table(
  .results = presentresults_resultstable,
  fclc_matrix_var = "fcls_cat",
  fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
  fc_matrix_var = "fcm_cat",
  fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
  with_fclc = TRUE,
  fcs_cat_values = c("low", "medium", "high"),
  rcsi_cat_values = c("low", "medium", "high"),
  lcsi_cat_var = "lcs_cat",
  lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
  hhs_cat_var = "hhs_cat",
  hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
  lcsi_set = c(
    "liv_stress_lcsi_1",
    "liv_stress_lcsi_2",
    "liv_stress_lcsi_3",
    "liv_stress_lcsi_4",
    "liv_crisis_lcsi_1",
    "liv_crisis_lcsi_2",
    "liv_crisis_lcsi_3",
    "liv_emerg_lcsi_1",
    "liv_emerg_lcsi_2",
    "liv_emerg_lcsi_3"
  ),
  other_variables = c("income_v2_sum", "expenditure_food")
)
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].
#> Joining with `by = join_by(analysis_key)`
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 242 rows [5, 6, 11, 12,
#> 17, 18, 23, 24, 29, 30, 35, 36, 41, 42, 46, 47, 52, 53, 58, 59, ...].
head(example_ipc)
#>                                       group_var_value
#> header_analysis_var                   group_var_value
#> header_analysis_var_value             group_var_value
#> header_analysis_type                  group_var_value
#> 1                             locationA ~/~ displaced
#> 2                         locationA ~/~ non-displaced
#> 3                             locationB ~/~ displaced
#>                           fcls_cat ~/~ phase_1 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_1
#> header_analysis_type                               prop_select_one
#> 1                                                0.161290322580645
#> 2                                               0.0833333333333333
#> 3                                                0.111111111111111
#>                           fcls_cat ~/~ phase_2 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_2
#> header_analysis_type                               prop_select_one
#> 1                                                0.225806451612903
#> 2                                               0.0833333333333333
#> 3                                                0.333333333333333
#>                           fcls_cat ~/~ phase_3 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_3
#> header_analysis_type                               prop_select_one
#> 1                                                0.258064516129032
#> 2                                                0.291666666666667
#> 3                                                0.185185185185185
#>                           fcls_cat ~/~ phase_4 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_4
#> header_analysis_type                               prop_select_one
#> 1                                                0.193548387096774
#> 2                                                0.208333333333333
#> 3                                                0.185185185185185
#>                           fcls_cat ~/~ phase_5 ~/~ prop_select_one
#> header_analysis_var                                       fcls_cat
#> header_analysis_var_value                                  phase_5
#> header_analysis_type                               prop_select_one
#> 1                                                0.161290322580645
#> 2                                                0.333333333333333
#> 3                                                0.185185185185185
#>                           fcm_cat ~/~ phase_1 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_1
#> header_analysis_type                              prop_select_one
#> 1                                               0.290322580645161
#> 2                                                            0.25
#> 3                                               0.222222222222222
#>                           fcm_cat ~/~ phase_2 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_2
#> header_analysis_type                              prop_select_one
#> 1                                              0.0967741935483871
#> 2                                              0.0833333333333333
#> 3                                               0.185185185185185
#>                           fcm_cat ~/~ phase_3 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_3
#> header_analysis_type                              prop_select_one
#> 1                                                0.32258064516129
#> 2                                               0.166666666666667
#> 3                                               0.111111111111111
#>                           fcm_cat ~/~ phase_4 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_4
#> header_analysis_type                              prop_select_one
#> 1                                               0.161290322580645
#> 2                                               0.208333333333333
#> 3                                               0.222222222222222
#>                           fcm_cat ~/~ phase_5 ~/~ prop_select_one
#> header_analysis_var                                       fcm_cat
#> header_analysis_var_value                                 phase_5
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                               0.291666666666667
#> 3                                               0.259259259259259
#>                           fcs_cat ~/~ low ~/~ prop_select_one
#> header_analysis_var                                   fcs_cat
#> header_analysis_var_value                                 low
#> header_analysis_type                          prop_select_one
#> 1                                           0.258064516129032
#> 2                                                        0.25
#> 3                                            0.37037037037037
#>                           fcs_cat ~/~ medium ~/~ prop_select_one
#> header_analysis_var                                      fcs_cat
#> header_analysis_var_value                                 medium
#> header_analysis_type                             prop_select_one
#> 1                                               0.32258064516129
#> 2                                                          0.375
#> 3                                              0.407407407407407
#>                           fcs_cat ~/~ high ~/~ prop_select_one
#> header_analysis_var                                    fcs_cat
#> header_analysis_var_value                                 high
#> header_analysis_type                           prop_select_one
#> 1                                            0.419354838709677
#> 2                                                        0.375
#> 3                                            0.222222222222222
#>                           rcsi_cat ~/~ low ~/~ prop_select_one
#> header_analysis_var                                   rcsi_cat
#> header_analysis_var_value                                  low
#> header_analysis_type                           prop_select_one
#> 1                                            0.290322580645161
#> 2                                                        0.375
#> 3                                            0.259259259259259
#>                           rcsi_cat ~/~ medium ~/~ prop_select_one
#> header_analysis_var                                      rcsi_cat
#> header_analysis_var_value                                  medium
#> header_analysis_type                              prop_select_one
#> 1                                               0.258064516129032
#> 2                                               0.458333333333333
#> 3                                               0.518518518518518
#>                           rcsi_cat ~/~ high ~/~ prop_select_one
#> header_analysis_var                                    rcsi_cat
#> header_analysis_var_value                                  high
#> header_analysis_type                            prop_select_one
#> 1                                             0.451612903225806
#> 2                                             0.166666666666667
#> 3                                             0.222222222222222
#>                           lcs_cat ~/~ none ~/~ prop_select_one
#> header_analysis_var                                    lcs_cat
#> header_analysis_var_value                                 none
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                           0.0416666666666667
#> 3                                            0.296296296296296
#>                           lcs_cat ~/~ stress ~/~ prop_select_one
#> header_analysis_var                                      lcs_cat
#> header_analysis_var_value                                 stress
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                              0.458333333333333
#> 3                                              0.259259259259259
#>                           lcs_cat ~/~ emergency ~/~ prop_select_one
#> header_analysis_var                                         lcs_cat
#> header_analysis_var_value                                 emergency
#> header_analysis_type                                prop_select_one
#> 1                                                  0.32258064516129
#> 2                                                 0.291666666666667
#> 3                                                 0.185185185185185
#>                           lcs_cat ~/~ crisis ~/~ prop_select_one
#> header_analysis_var                                      lcs_cat
#> header_analysis_var_value                                 crisis
#> header_analysis_type                             prop_select_one
#> 1                                              0.354838709677419
#> 2                                              0.208333333333333
#> 3                                              0.259259259259259
#>                           hhs_cat ~/~ none ~/~ prop_select_one
#> header_analysis_var                                    hhs_cat
#> header_analysis_var_value                                 none
#> header_analysis_type                           prop_select_one
#> 1                                            0.225806451612903
#> 2                                            0.208333333333333
#> 3                                            0.222222222222222
#>                           hhs_cat ~/~ slight ~/~ prop_select_one
#> header_analysis_var                                      hhs_cat
#> header_analysis_var_value                                 slight
#> header_analysis_type                             prop_select_one
#> 1                                              0.258064516129032
#> 2                                              0.291666666666667
#> 3                                              0.222222222222222
#>                           hhs_cat ~/~ moderate ~/~ prop_select_one
#> header_analysis_var                                        hhs_cat
#> header_analysis_var_value                                 moderate
#> header_analysis_type                               prop_select_one
#> 1                                                0.225806451612903
#> 2                                               0.0833333333333333
#> 3                                                0.222222222222222
#>                           hhs_cat ~/~ severe ~/~ prop_select_one
#> header_analysis_var                                      hhs_cat
#> header_analysis_var_value                                 severe
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                                           0.25
#> 3                                              0.222222222222222
#>                           hhs_cat ~/~ very_severe ~/~ prop_select_one
#> header_analysis_var                                           hhs_cat
#> header_analysis_var_value                                 very_severe
#> header_analysis_type                                  prop_select_one
#> 1                                                   0.193548387096774
#> 2                                                   0.166666666666667
#> 3                                                   0.111111111111111
#>                           fs_fcs_cereals_grains_roots_tubers ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_cereals_grains_roots_tubers
#> header_analysis_var_value                                               <NA>
#> header_analysis_type                                                    mean
#> 1                                                           3.67741935483871
#> 2                                                           3.54166666666667
#> 3                                                           3.74074074074074
#>                           fs_fcs_beans_nuts ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_beans_nuts
#> header_analysis_var_value                              <NA>
#> header_analysis_type                                   mean
#> 1                                          3.45161290322581
#> 2                                          3.66666666666667
#> 3                                          3.03703703703704
#>                           fs_fcs_dairy ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_dairy
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.35483870967742
#> 2                                     3.95833333333333
#> 3                                     3.48148148148148
#>                           fs_fcs_meat_fish_eggs ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_meat_fish_eggs
#> header_analysis_var_value                                  <NA>
#> header_analysis_type                                       mean
#> 1                                              3.16129032258065
#> 2                                              3.91666666666667
#> 3                                               4.2962962962963
#>                           fs_fcs_vegetables_leaves ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_vegetables_leaves
#> header_analysis_var_value                                     <NA>
#> header_analysis_type                                          mean
#> 1                                                 3.45161290322581
#> 2                                                 3.16666666666667
#> 3                                                 3.18518518518519
#>                           fs_fcs_fruit ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_fruit
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.45161290322581
#> 2                                                3.875
#> 3                                      3.7037037037037
#>                           fs_fcs_oil_fat_butter ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_oil_fat_butter
#> header_analysis_var_value                                  <NA>
#> header_analysis_type                                       mean
#> 1                                              3.64516129032258
#> 2                                              4.41666666666667
#> 3                                              3.55555555555556
#>                           fs_fcs_sugar ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_sugar
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                      3.2258064516129
#> 2                                                    4
#> 3                                     3.92592592592593
#>                           fs_fcs_condiment ~/~ NA ~/~ mean
#> header_analysis_var                       fs_fcs_condiment
#> header_analysis_var_value                             <NA>
#> header_analysis_type                                  mean
#> 1                                         4.06451612903226
#> 2                                         3.70833333333333
#> 3                                         2.59259259259259
#>                           rCSILessQlty ~/~ NA ~/~ mean
#> header_analysis_var                       rCSILessQlty
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.09677419354839
#> 2                                                3.375
#> 3                                     2.62962962962963
#>                           rCSIBorrow ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIBorrow
#> header_analysis_var_value                       <NA>
#> header_analysis_type                            mean
#> 1                                   3.48387096774194
#> 2                                   2.58333333333333
#> 3                                   2.92592592592593
#>                           rCSIMealSize ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealSize
#> header_analysis_var_value                         <NA>
#> header_analysis_type                              mean
#> 1                                     3.80645161290323
#> 2                                     3.95833333333333
#> 3                                     3.14814814814815
#>                           rCSIMealAdult ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealAdult
#> header_analysis_var_value                          <NA>
#> header_analysis_type                               mean
#> 1                                      2.93548387096774
#> 2                                      3.70833333333333
#> 3                                      3.66666666666667
#>                           rCSIMealNb ~/~ NA ~/~ mean
#> header_analysis_var                       rCSIMealNb
#> header_analysis_var_value                       <NA>
#> header_analysis_type                            mean
#> 1                                   2.96774193548387
#> 2                                   3.16666666666667
#> 3                                   2.74074074074074
#>                           rCSILessQlty ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      0
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.185185185185185
#>                           rCSILessQlty ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      1
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                             0.0416666666666667
#> 3                                              0.222222222222222
#>                           rCSILessQlty ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      2
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSILessQlty ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      3
#> header_analysis_type                             prop_select_one
#> 1                                              0.225806451612903
#> 2                                              0.208333333333333
#> 3                                              0.111111111111111
#>                           rCSILessQlty ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      4
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.111111111111111
#>                           rCSILessQlty ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      5
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                              0.166666666666667
#> 3                                             0.0740740740740741
#>                           rCSILessQlty ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      6
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                             0.0740740740740741
#>                           rCSILessQlty ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSILessQlty
#> header_analysis_var_value                                      7
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                             0.0416666666666667
#> 3                                             0.0740740740740741
#>                           rCSIBorrow ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    0
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.166666666666667
#> 3                                            0.259259259259259
#>                           rCSIBorrow ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    1
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                        0.125
#> 3                                            0.222222222222222
#>                           rCSIBorrow ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    2
#> header_analysis_type                           prop_select_one
#> 1                                           0.0645161290322581
#> 2                                            0.291666666666667
#> 3                                                         <NA>
#>                           rCSIBorrow ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    3
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                                        0.125
#> 3                                           0.0740740740740741
#>                           rCSIBorrow ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    4
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                           0.0833333333333333
#> 3                                            0.148148148148148
#>                           rCSIBorrow ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    5
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                           0.0833333333333333
#> 3                                           0.0740740740740741
#>                           rCSIBorrow ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    6
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                        0.125
#> 3                                            0.037037037037037
#>                           rCSIBorrow ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIBorrow
#> header_analysis_var_value                                    7
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                         <NA>
#> 3                                            0.185185185185185
#>                           rCSIMealSize ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      0
#> header_analysis_type                             prop_select_one
#> 1                                             0.0967741935483871
#> 2                                                          0.125
#> 3                                              0.185185185185185
#>                           rCSIMealSize ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      1
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                             0.0416666666666667
#> 3                                              0.111111111111111
#>                           rCSIMealSize ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      2
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                             0.0833333333333333
#> 3                                              0.185185185185185
#>                           rCSIMealSize ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      3
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSIMealSize ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      4
#> header_analysis_type                             prop_select_one
#> 1                                             0.0645161290322581
#> 2                                                          0.125
#> 3                                              0.037037037037037
#>                           rCSIMealSize ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      5
#> header_analysis_type                             prop_select_one
#> 1                                              0.161290322580645
#> 2                                              0.166666666666667
#> 3                                             0.0740740740740741
#>                           rCSIMealSize ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      6
#> header_analysis_type                             prop_select_one
#> 1                                              0.129032258064516
#> 2                                                          0.125
#> 3                                              0.111111111111111
#>                           rCSIMealSize ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealSize
#> header_analysis_var_value                                      7
#> header_analysis_type                             prop_select_one
#> 1                                              0.193548387096774
#> 2                                              0.166666666666667
#> 3                                              0.148148148148148
#>                           rCSIMealAdult ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       0
#> header_analysis_type                              prop_select_one
#> 1                                              0.0645161290322581
#> 2                                              0.0833333333333333
#> 3                                              0.0740740740740741
#>                           rCSIMealAdult ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       1
#> header_analysis_type                              prop_select_one
#> 1                                               0.258064516129032
#> 2                                                           0.125
#> 3                                              0.0740740740740741
#>                           rCSIMealAdult ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       2
#> header_analysis_type                              prop_select_one
#> 1                                               0.225806451612903
#> 2                                                           0.125
#> 3                                               0.185185185185185
#>                           rCSIMealAdult ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       3
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                              0.0833333333333333
#> 3                                               0.222222222222222
#>                           rCSIMealAdult ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       4
#> header_analysis_type                              prop_select_one
#> 1                                              0.0967741935483871
#> 2                                               0.208333333333333
#> 3                                               0.111111111111111
#>                           rCSIMealAdult ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       5
#> header_analysis_type                              prop_select_one
#> 1                                               0.032258064516129
#> 2                                                           0.125
#> 3                                               0.037037037037037
#>                           rCSIMealAdult ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       6
#> header_analysis_type                              prop_select_one
#> 1                                              0.0645161290322581
#> 2                                                           0.125
#> 3                                               0.148148148148148
#>                           rCSIMealAdult ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealAdult
#> header_analysis_var_value                                       7
#> header_analysis_type                              prop_select_one
#> 1                                               0.129032258064516
#> 2                                                           0.125
#> 3                                               0.148148148148148
#>                           rCSIMealNb ~/~ 0 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    0
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                                        0.125
#> 3                                            0.185185185185185
#>                           rCSIMealNb ~/~ 1 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    1
#> header_analysis_type                           prop_select_one
#> 1                                            0.161290322580645
#> 2                                                        0.125
#> 3                                            0.148148148148148
#>                           rCSIMealNb ~/~ 2 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    2
#> header_analysis_type                           prop_select_one
#> 1                                            0.193548387096774
#> 2                                                        0.125
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 3 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    3
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.208333333333333
#> 3                                            0.296296296296296
#>                           rCSIMealNb ~/~ 4 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    4
#> header_analysis_type                           prop_select_one
#> 1                                            0.129032258064516
#> 2                                            0.166666666666667
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 5 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    5
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                        0.125
#> 3                                            0.111111111111111
#>                           rCSIMealNb ~/~ 6 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    6
#> header_analysis_type                           prop_select_one
#> 1                                           0.0967741935483871
#> 2                                                         <NA>
#> 3                                           0.0740740740740741
#>                           rCSIMealNb ~/~ 7 ~/~ prop_select_one
#> header_analysis_var                                 rCSIMealNb
#> header_analysis_var_value                                    7
#> header_analysis_type                           prop_select_one
#> 1                                           0.0645161290322581
#> 2                                                        0.125
#> 3                                            0.037037037037037
#>                           liv_stress_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_1
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.258064516129032
#> 2                                                                 0.375
#> 3                                                     0.259259259259259
#>                           liv_stress_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_1
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.208333333333333
#> 3                                                                0.259259259259259
#>                           liv_stress_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_1
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                                          0.125
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_1
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.290322580645161
#> 2                                                                0.291666666666667
#> 3                                                                0.185185185185185
#>                           liv_stress_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_2
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.258064516129032
#> 2                                                     0.333333333333333
#> 3                                                     0.222222222222222
#>                           liv_stress_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_2
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.290322580645161
#> 2                                                                0.166666666666667
#> 3                                                                0.222222222222222
#>                           liv_stress_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_2
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                              0.208333333333333
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_2
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.291666666666667
#> 3                                                                0.259259259259259
#>                           liv_stress_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_3
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                    0.0967741935483871
#> 2                                                                  0.25
#> 3                                                     0.296296296296296
#>                           liv_stress_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_3
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                 0.32258064516129
#> 2                                                                0.208333333333333
#> 3                                                                0.333333333333333
#>                           liv_stress_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_3
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.258064516129032
#> 2                                                              0.291666666666667
#> 3                                                              0.296296296296296
#>                           liv_stress_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_3
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                 0.32258064516129
#> 2                                                                             0.25
#> 3                                                               0.0740740740740741
#>                           liv_stress_lcsi_4 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_stress_lcsi_4
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.225806451612903
#> 2                                                     0.208333333333333
#> 3                                                      0.37037037037037
#>                           liv_stress_lcsi_4 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_4
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.129032258064516
#> 2                                                                            0.125
#> 3                                                                0.185185185185185
#>                           liv_stress_lcsi_4 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_stress_lcsi_4
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.387096774193548
#> 2                                                                          0.375
#> 3                                                              0.222222222222222
#>                           liv_stress_lcsi_4 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_stress_lcsi_4
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.258064516129032
#> 2                                                                0.291666666666667
#> 3                                                                0.222222222222222
#>                           liv_crisis_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_1
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                      0.32258064516129
#> 2                                                                 0.375
#> 3                                                     0.148148148148148
#>                           liv_crisis_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_1
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.225806451612903
#> 2                                                                0.166666666666667
#> 3                                                                0.296296296296296
#>                           liv_crisis_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_1
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.290322580645161
#> 2                                                              0.208333333333333
#> 3                                                              0.259259259259259
#>                           liv_crisis_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_1
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.161290322580645
#> 2                                                                             0.25
#> 3                                                                0.296296296296296
#>                           liv_crisis_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_2
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.225806451612903
#> 2                                                     0.291666666666667
#> 3                                                     0.185185185185185
#>                           liv_crisis_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_2
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.225806451612903
#> 2                                                                0.166666666666667
#> 3                                                                0.407407407407407
#>                           liv_crisis_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_2
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.387096774193548
#> 2                                                                          0.375
#> 3                                                              0.259259259259259
#>                           liv_crisis_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_2
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.161290322580645
#> 2                                                                0.166666666666667
#> 3                                                                0.148148148148148
#>                           liv_crisis_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_crisis_lcsi_3
#> header_analysis_var_value                                           yes
#> header_analysis_type                                    prop_select_one
#> 1                                                     0.290322580645161
#> 2                                                                  0.25
#> 3                                                     0.222222222222222
#>                           liv_crisis_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_3
#> header_analysis_var_value                                           no_had_no_need
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.129032258064516
#> 2                                                                            0.125
#> 3                                                                0.185185185185185
#>                           liv_crisis_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_crisis_lcsi_3
#> header_analysis_var_value                                           no_exhausted
#> header_analysis_type                                             prop_select_one
#> 1                                                              0.193548387096774
#> 2                                                              0.291666666666667
#> 3                                                               0.37037037037037
#>                           liv_crisis_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_crisis_lcsi_3
#> header_analysis_var_value                                           not_applicable
#> header_analysis_type                                               prop_select_one
#> 1                                                                0.387096774193548
#> 2                                                                0.333333333333333
#> 3                                                                0.222222222222222
#>                           liv_emerg_lcsi_1 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_1
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.387096774193548
#> 2                                                    0.333333333333333
#> 3                                                    0.259259259259259
#>                           liv_emerg_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_1
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.193548387096774
#> 2                                                                            0.25
#> 3                                                               0.333333333333333
#>                           liv_emerg_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_1
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.129032258064516
#> 2                                                             0.166666666666667
#> 3                                                             0.222222222222222
#>                           liv_emerg_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_1
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.290322580645161
#> 2                                                                            0.25
#> 3                                                               0.185185185185185
#>                           liv_emerg_lcsi_2 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_2
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.258064516129032
#> 2                                                    0.166666666666667
#> 3                                                    0.296296296296296
#>                           liv_emerg_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_2
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.387096774193548
#> 2                                                                            0.25
#> 3                                                               0.333333333333333
#>                           liv_emerg_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_2
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.161290322580645
#> 2                                                             0.166666666666667
#> 3                                                             0.148148148148148
#>                           liv_emerg_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_2
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.193548387096774
#> 2                                                               0.416666666666667
#> 3                                                               0.222222222222222
#>                           liv_emerg_lcsi_3 ~/~ yes ~/~ prop_select_one
#> header_analysis_var                                   liv_emerg_lcsi_3
#> header_analysis_var_value                                          yes
#> header_analysis_type                                   prop_select_one
#> 1                                                    0.193548387096774
#> 2                                                                0.125
#> 3                                                    0.185185185185185
#>                           liv_emerg_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_3
#> header_analysis_var_value                                          no_had_no_need
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.161290322580645
#> 2                                                               0.333333333333333
#> 3                                                               0.296296296296296
#>                           liv_emerg_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> header_analysis_var                                            liv_emerg_lcsi_3
#> header_analysis_var_value                                          no_exhausted
#> header_analysis_type                                            prop_select_one
#> 1                                                             0.225806451612903
#> 2                                                                          0.25
#> 3                                                             0.296296296296296
#>                           liv_emerg_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> header_analysis_var                                              liv_emerg_lcsi_3
#> header_analysis_var_value                                          not_applicable
#> header_analysis_type                                              prop_select_one
#> 1                                                               0.419354838709677
#> 2                                                               0.291666666666667
#> 3                                                               0.222222222222222
#>                           income_v2_sum ~/~ NA ~/~ mean
#> header_analysis_var                       income_v2_sum
#> header_analysis_var_value                          <NA>
#> header_analysis_type                               mean
#> 1                                                  <NA>
#> 2                                                  <NA>
#> 3                                                  <NA>
#>                           expenditure_food ~/~ NA ~/~ mean
#> header_analysis_var                       expenditure_food
#> header_analysis_var_value                             <NA>
#> header_analysis_type                                  mean
#> 1                                         20.1935483870968
#> 2                                         20.2916666666667
#> 3                                         19.7037037037037
```

## Export a table group per variable in Excel

``` r
presentresults_resultstable %>%
  create_table_group_x_variable() %>%
  create_xlsx_group_x_variable("mytable.xlsx")

example_ipc %>%
  create_xlsx_group_x_variable("ipc_table.xlsx")
```

## Converting the analysis index into a table

This is is how to turn the analysis index into a table

``` r
resultstable <- data.frame(analysis_index = c(
  "mean @/@ v1 ~/~ NA @/@ NA ~/~ NA",
  "mean @/@ v1 ~/~ NA @/@ gro ~/~ A",
  "mean @/@ v1 ~/~ NA @/@ gro ~/~ B"
))

key_table <- create_analysis_key_table(resultstable, "analysis_index")
key_table
#>                     analysis_index analysis_type analysis_var_1
#> 1 mean @/@ v1 ~/~ NA @/@ NA ~/~ NA          mean             v1
#> 2 mean @/@ v1 ~/~ NA @/@ gro ~/~ A          mean             v1
#> 3 mean @/@ v1 ~/~ NA @/@ gro ~/~ B          mean             v1
#>   analysis_var_value_1 group_var_1 group_var_value_1 nb_analysis_var
#> 1                   NA          NA                NA               1
#> 2                   NA         gro                 A               1
#> 3                   NA         gro                 B               1
#>   nb_group_var
#> 1            1
#> 2            1
#> 3            1
```

You can then unite the analysis and grouping variables if needed.

``` r
unite_variables(key_table)
#>                     analysis_index analysis_type analysis_var
#> 1 mean @/@ v1 ~/~ NA @/@ NA ~/~ NA          mean           v1
#> 2 mean @/@ v1 ~/~ NA @/@ gro ~/~ A          mean           v1
#> 3 mean @/@ v1 ~/~ NA @/@ gro ~/~ B          mean           v1
#>   analysis_var_value group_var group_var_value nb_analysis_var nb_group_var
#> 1                 NA        NA              NA               1            1
#> 2                 NA       gro               A               1            1
#> 3                 NA       gro               B               1            1
```
