
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

## Large table groups (lines) per variables (columns)

This is how to turn a results table into a wide group per variable.

``` r
example_group_x_variable <- create_table_group_x_variable(presentresults_resultstable, value_columns = "stat")
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].

head(example_group_x_variable)
#>               group_var_value fcs_cat ~/~ low ~/~ prop_select_one
#> 1             group_var_value                             fcs_cat
#> 2             group_var_value                                 low
#> 3             group_var_value                     prop_select_one
#> 4     locationA ~/~ displaced                   0.258064516129032
#> 5 locationA ~/~ non-displaced                                0.25
#> 6     locationB ~/~ displaced                    0.37037037037037
#>   fcs_cat ~/~ medium ~/~ prop_select_one fcs_cat ~/~ high ~/~ prop_select_one
#> 1                                fcs_cat                              fcs_cat
#> 2                                 medium                                 high
#> 3                        prop_select_one                      prop_select_one
#> 4                       0.32258064516129                    0.419354838709677
#> 5                                  0.375                                0.375
#> 6                      0.407407407407407                    0.222222222222222
#>   rcsi_cat ~/~ low ~/~ prop_select_one rcsi_cat ~/~ medium ~/~ prop_select_one
#> 1                             rcsi_cat                                rcsi_cat
#> 2                                  low                                  medium
#> 3                      prop_select_one                         prop_select_one
#> 4                    0.290322580645161                       0.258064516129032
#> 5                                0.375                       0.458333333333333
#> 6                    0.259259259259259                       0.518518518518518
#>   rcsi_cat ~/~ high ~/~ prop_select_one lcs_cat ~/~ none ~/~ prop_select_one
#> 1                              rcsi_cat                              lcs_cat
#> 2                                  high                                 none
#> 3                       prop_select_one                      prop_select_one
#> 4                     0.451612903225806                    0.193548387096774
#> 5                     0.166666666666667                   0.0416666666666667
#> 6                     0.222222222222222                    0.296296296296296
#>   lcs_cat ~/~ stress ~/~ prop_select_one
#> 1                                lcs_cat
#> 2                                 stress
#> 3                        prop_select_one
#> 4                      0.129032258064516
#> 5                      0.458333333333333
#> 6                      0.259259259259259
#>   lcs_cat ~/~ emergency ~/~ prop_select_one
#> 1                                   lcs_cat
#> 2                                 emergency
#> 3                           prop_select_one
#> 4                          0.32258064516129
#> 5                         0.291666666666667
#> 6                         0.185185185185185
#>   lcs_cat ~/~ crisis ~/~ prop_select_one hhs_cat ~/~ none ~/~ prop_select_one
#> 1                                lcs_cat                              hhs_cat
#> 2                                 crisis                                 none
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.354838709677419                    0.225806451612903
#> 5                      0.208333333333333                    0.208333333333333
#> 6                      0.259259259259259                    0.222222222222222
#>   hhs_cat ~/~ slight ~/~ prop_select_one
#> 1                                hhs_cat
#> 2                                 slight
#> 3                        prop_select_one
#> 4                      0.258064516129032
#> 5                      0.291666666666667
#> 6                      0.222222222222222
#>   hhs_cat ~/~ moderate ~/~ prop_select_one
#> 1                                  hhs_cat
#> 2                                 moderate
#> 3                          prop_select_one
#> 4                        0.225806451612903
#> 5                       0.0833333333333333
#> 6                        0.222222222222222
#>   hhs_cat ~/~ severe ~/~ prop_select_one
#> 1                                hhs_cat
#> 2                                 severe
#> 3                        prop_select_one
#> 4                     0.0967741935483871
#> 5                                   0.25
#> 6                      0.222222222222222
#>   hhs_cat ~/~ very_severe ~/~ prop_select_one
#> 1                                     hhs_cat
#> 2                                 very_severe
#> 3                             prop_select_one
#> 4                           0.193548387096774
#> 5                           0.166666666666667
#> 6                           0.111111111111111
#>   fcm_cat ~/~ phase_1 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_1
#> 3                         prop_select_one
#> 4                       0.290322580645161
#> 5                                    0.25
#> 6                       0.222222222222222
#>   fcm_cat ~/~ phase_2 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_2
#> 3                         prop_select_one
#> 4                      0.0967741935483871
#> 5                      0.0833333333333333
#> 6                       0.185185185185185
#>   fcm_cat ~/~ phase_3 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_3
#> 3                         prop_select_one
#> 4                        0.32258064516129
#> 5                       0.166666666666667
#> 6                       0.111111111111111
#>   fcm_cat ~/~ phase_4 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_4
#> 3                         prop_select_one
#> 4                       0.161290322580645
#> 5                       0.208333333333333
#> 6                       0.222222222222222
#>   fcm_cat ~/~ phase_5 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_5
#> 3                         prop_select_one
#> 4                       0.129032258064516
#> 5                       0.291666666666667
#> 6                       0.259259259259259
#>   fcls_cat ~/~ phase_1 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_1
#> 3                          prop_select_one
#> 4                        0.161290322580645
#> 5                       0.0833333333333333
#> 6                        0.111111111111111
#>   fcls_cat ~/~ phase_2 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_2
#> 3                          prop_select_one
#> 4                        0.225806451612903
#> 5                       0.0833333333333333
#> 6                        0.333333333333333
#>   fcls_cat ~/~ phase_3 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_3
#> 3                          prop_select_one
#> 4                        0.258064516129032
#> 5                        0.291666666666667
#> 6                        0.185185185185185
#>   fcls_cat ~/~ phase_4 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_4
#> 3                          prop_select_one
#> 4                        0.193548387096774
#> 5                        0.208333333333333
#> 6                        0.185185185185185
#>   fcls_cat ~/~ phase_5 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_5
#> 3                          prop_select_one
#> 4                        0.161290322580645
#> 5                        0.333333333333333
#> 6                        0.185185185185185
#>   rCSILessQlty ~/~ 0 ~/~ prop_select_one rCSILessQlty ~/~ 1 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSILessQlty
#> 2                                      0                                      1
#> 3                        prop_select_one                        prop_select_one
#> 4                      0.129032258064516                      0.161290322580645
#> 5                                  0.125                     0.0416666666666667
#> 6                      0.185185185185185                      0.222222222222222
#>   rCSILessQlty ~/~ 2 ~/~ prop_select_one rCSILessQlty ~/~ 3 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSILessQlty
#> 2                                      2                                      3
#> 3                        prop_select_one                        prop_select_one
#> 4                     0.0967741935483871                      0.225806451612903
#> 5                      0.166666666666667                      0.208333333333333
#> 6                      0.148148148148148                      0.111111111111111
#>   rCSILessQlty ~/~ 4 ~/~ prop_select_one rCSILessQlty ~/~ 5 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSILessQlty
#> 2                                      4                                      5
#> 3                        prop_select_one                        prop_select_one
#> 4                      0.129032258064516                     0.0645161290322581
#> 5                                  0.125                      0.166666666666667
#> 6                      0.111111111111111                     0.0740740740740741
#>   rCSILessQlty ~/~ 6 ~/~ prop_select_one rCSILessQlty ~/~ 7 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSILessQlty
#> 2                                      6                                      7
#> 3                        prop_select_one                        prop_select_one
#> 4                      0.129032258064516                     0.0645161290322581
#> 5                                  0.125                     0.0416666666666667
#> 6                     0.0740740740740741                     0.0740740740740741
#>   rCSIBorrow ~/~ 0 ~/~ prop_select_one rCSIBorrow ~/~ 1 ~/~ prop_select_one
#> 1                           rCSIBorrow                           rCSIBorrow
#> 2                                    0                                    1
#> 3                      prop_select_one                      prop_select_one
#> 4                    0.129032258064516                    0.129032258064516
#> 5                    0.166666666666667                                0.125
#> 6                    0.259259259259259                    0.222222222222222
#>   rCSIBorrow ~/~ 2 ~/~ prop_select_one rCSIBorrow ~/~ 3 ~/~ prop_select_one
#> 1                           rCSIBorrow                           rCSIBorrow
#> 2                                    2                                    3
#> 3                      prop_select_one                      prop_select_one
#> 4                   0.0645161290322581                    0.193548387096774
#> 5                    0.291666666666667                                0.125
#> 6                                 <NA>                   0.0740740740740741
#>   rCSIBorrow ~/~ 4 ~/~ prop_select_one rCSIBorrow ~/~ 5 ~/~ prop_select_one
#> 1                           rCSIBorrow                           rCSIBorrow
#> 2                                    4                                    5
#> 3                      prop_select_one                      prop_select_one
#> 4                    0.129032258064516                    0.129032258064516
#> 5                   0.0833333333333333                   0.0833333333333333
#> 6                    0.148148148148148                   0.0740740740740741
#>   rCSIBorrow ~/~ 6 ~/~ prop_select_one rCSIBorrow ~/~ 7 ~/~ prop_select_one
#> 1                           rCSIBorrow                           rCSIBorrow
#> 2                                    6                                    7
#> 3                      prop_select_one                      prop_select_one
#> 4                   0.0967741935483871                    0.129032258064516
#> 5                                0.125                                 <NA>
#> 6                    0.037037037037037                    0.185185185185185
#>   rCSIMealSize ~/~ 0 ~/~ prop_select_one rCSIMealSize ~/~ 1 ~/~ prop_select_one
#> 1                           rCSIMealSize                           rCSIMealSize
#> 2                                      0                                      1
#> 3                        prop_select_one                        prop_select_one
#> 4                     0.0967741935483871                      0.161290322580645
#> 5                                  0.125                     0.0416666666666667
#> 6                      0.185185185185185                      0.111111111111111
#>   rCSIMealSize ~/~ 2 ~/~ prop_select_one rCSIMealSize ~/~ 3 ~/~ prop_select_one
#> 1                           rCSIMealSize                           rCSIMealSize
#> 2                                      2                                      3
#> 3                        prop_select_one                        prop_select_one
#> 4                      0.129032258064516                     0.0645161290322581
#> 5                     0.0833333333333333                      0.166666666666667
#> 6                      0.185185185185185                      0.148148148148148
#>   rCSIMealSize ~/~ 4 ~/~ prop_select_one rCSIMealSize ~/~ 5 ~/~ prop_select_one
#> 1                           rCSIMealSize                           rCSIMealSize
#> 2                                      4                                      5
#> 3                        prop_select_one                        prop_select_one
#> 4                     0.0645161290322581                      0.161290322580645
#> 5                                  0.125                      0.166666666666667
#> 6                      0.037037037037037                     0.0740740740740741
#>   rCSIMealSize ~/~ 6 ~/~ prop_select_one rCSIMealSize ~/~ 7 ~/~ prop_select_one
#> 1                           rCSIMealSize                           rCSIMealSize
#> 2                                      6                                      7
#> 3                        prop_select_one                        prop_select_one
#> 4                      0.129032258064516                      0.193548387096774
#> 5                                  0.125                      0.166666666666667
#> 6                      0.111111111111111                      0.148148148148148
#>   rCSIMealAdult ~/~ 0 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       0
#> 3                         prop_select_one
#> 4                      0.0645161290322581
#> 5                      0.0833333333333333
#> 6                      0.0740740740740741
#>   rCSIMealAdult ~/~ 1 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       1
#> 3                         prop_select_one
#> 4                       0.258064516129032
#> 5                                   0.125
#> 6                      0.0740740740740741
#>   rCSIMealAdult ~/~ 2 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       2
#> 3                         prop_select_one
#> 4                       0.225806451612903
#> 5                                   0.125
#> 6                       0.185185185185185
#>   rCSIMealAdult ~/~ 3 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       3
#> 3                         prop_select_one
#> 4                       0.129032258064516
#> 5                      0.0833333333333333
#> 6                       0.222222222222222
#>   rCSIMealAdult ~/~ 4 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       4
#> 3                         prop_select_one
#> 4                      0.0967741935483871
#> 5                       0.208333333333333
#> 6                       0.111111111111111
#>   rCSIMealAdult ~/~ 5 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       5
#> 3                         prop_select_one
#> 4                       0.032258064516129
#> 5                                   0.125
#> 6                       0.037037037037037
#>   rCSIMealAdult ~/~ 6 ~/~ prop_select_one
#> 1                           rCSIMealAdult
#> 2                                       6
#> 3                         prop_select_one
#> 4                      0.0645161290322581
#> 5                                   0.125
#> 6                       0.148148148148148
#>   rCSIMealAdult ~/~ 7 ~/~ prop_select_one rCSIMealNb ~/~ 0 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       7                                    0
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.129032258064516                    0.129032258064516
#> 5                                   0.125                                0.125
#> 6                       0.148148148148148                    0.185185185185185
#>   rCSIMealNb ~/~ 1 ~/~ prop_select_one rCSIMealNb ~/~ 2 ~/~ prop_select_one
#> 1                           rCSIMealNb                           rCSIMealNb
#> 2                                    1                                    2
#> 3                      prop_select_one                      prop_select_one
#> 4                    0.161290322580645                    0.193548387096774
#> 5                                0.125                                0.125
#> 6                    0.148148148148148                   0.0740740740740741
#>   rCSIMealNb ~/~ 3 ~/~ prop_select_one rCSIMealNb ~/~ 4 ~/~ prop_select_one
#> 1                           rCSIMealNb                           rCSIMealNb
#> 2                                    3                                    4
#> 3                      prop_select_one                      prop_select_one
#> 4                    0.129032258064516                    0.129032258064516
#> 5                    0.208333333333333                    0.166666666666667
#> 6                    0.296296296296296                   0.0740740740740741
#>   rCSIMealNb ~/~ 5 ~/~ prop_select_one rCSIMealNb ~/~ 6 ~/~ prop_select_one
#> 1                           rCSIMealNb                           rCSIMealNb
#> 2                                    5                                    6
#> 3                      prop_select_one                      prop_select_one
#> 4                   0.0967741935483871                   0.0967741935483871
#> 5                                0.125                                 <NA>
#> 6                    0.111111111111111                   0.0740740740740741
#>   rCSIMealNb ~/~ 7 ~/~ prop_select_one
#> 1                           rCSIMealNb
#> 2                                    7
#> 3                      prop_select_one
#> 4                   0.0645161290322581
#> 5                                0.125
#> 6                    0.037037037037037
#>   liv_stress_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_1
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                                  0.125
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_1
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.208333333333333
#> 6                                        0.259259259259259
#>   liv_stress_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_1
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.290322580645161
#> 5                                        0.291666666666667
#> 6                                        0.185185185185185
#>   liv_stress_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_1
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.258064516129032
#> 5                                         0.375
#> 6                             0.259259259259259
#>   liv_stress_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_2
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                      0.208333333333333
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_2
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.290322580645161
#> 5                                        0.166666666666667
#> 6                                        0.222222222222222
#>   liv_stress_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_2
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.291666666666667
#> 6                                        0.259259259259259
#>   liv_stress_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_2
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.258064516129032
#> 5                             0.333333333333333
#> 6                             0.222222222222222
#>   liv_stress_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_3
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.258064516129032
#> 5                                      0.291666666666667
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_3
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                         0.32258064516129
#> 5                                        0.208333333333333
#> 6                                        0.333333333333333
#>   liv_stress_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_3
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                         0.32258064516129
#> 5                                                     0.25
#> 6                                       0.0740740740740741
#>   liv_stress_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_3
#> 2                                           yes
#> 3                               prop_select_one
#> 4                            0.0967741935483871
#> 5                                          0.25
#> 6                             0.296296296296296
#>   liv_stress_lcsi_4 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_4
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.387096774193548
#> 5                                                  0.375
#> 6                                      0.222222222222222
#>   liv_stress_lcsi_4 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_4
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.129032258064516
#> 5                                                    0.125
#> 6                                        0.185185185185185
#>   liv_stress_lcsi_4 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_4
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.291666666666667
#> 6                                        0.222222222222222
#>   liv_stress_lcsi_4 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_4
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.225806451612903
#> 5                             0.208333333333333
#> 6                              0.37037037037037
#>   liv_crisis_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_1
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.290322580645161
#> 5                                      0.208333333333333
#> 6                                      0.259259259259259
#>   liv_crisis_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_1
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.225806451612903
#> 5                                        0.166666666666667
#> 6                                        0.296296296296296
#>   liv_crisis_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_1
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.161290322580645
#> 5                                                     0.25
#> 6                                        0.296296296296296
#>   liv_crisis_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_1
#> 2                                           yes
#> 3                               prop_select_one
#> 4                              0.32258064516129
#> 5                                         0.375
#> 6                             0.148148148148148
#>   liv_crisis_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_2
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.387096774193548
#> 5                                                  0.375
#> 6                                      0.259259259259259
#>   liv_crisis_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_2
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.225806451612903
#> 5                                        0.166666666666667
#> 6                                        0.407407407407407
#>   liv_crisis_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_2
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.161290322580645
#> 5                                        0.166666666666667
#> 6                                        0.148148148148148
#>   liv_crisis_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_2
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.225806451612903
#> 5                             0.291666666666667
#> 6                             0.185185185185185
#>   liv_crisis_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_3
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                      0.291666666666667
#> 6                                       0.37037037037037
#>   liv_crisis_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_3
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.129032258064516
#> 5                                                    0.125
#> 6                                        0.185185185185185
#>   liv_crisis_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_3
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.387096774193548
#> 5                                        0.333333333333333
#> 6                                        0.222222222222222
#>   liv_crisis_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_3
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.290322580645161
#> 5                                          0.25
#> 6                             0.222222222222222
#>   liv_emerg_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_1
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.129032258064516
#> 5                                     0.166666666666667
#> 6                                     0.222222222222222
#>   liv_emerg_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_1
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.193548387096774
#> 5                                                    0.25
#> 6                                       0.333333333333333
#>   liv_emerg_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_1
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.290322580645161
#> 5                                                    0.25
#> 6                                       0.185185185185185
#>   liv_emerg_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_1
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.387096774193548
#> 5                            0.333333333333333
#> 6                            0.259259259259259
#>   liv_emerg_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_2
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.161290322580645
#> 5                                     0.166666666666667
#> 6                                     0.148148148148148
#>   liv_emerg_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_2
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.387096774193548
#> 5                                                    0.25
#> 6                                       0.333333333333333
#>   liv_emerg_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_2
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.193548387096774
#> 5                                       0.416666666666667
#> 6                                       0.222222222222222
#>   liv_emerg_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_2
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.258064516129032
#> 5                            0.166666666666667
#> 6                            0.296296296296296
#>   liv_emerg_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_3
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.225806451612903
#> 5                                                  0.25
#> 6                                     0.296296296296296
#>   liv_emerg_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_3
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.161290322580645
#> 5                                       0.333333333333333
#> 6                                       0.296296296296296
#>   liv_emerg_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_3
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.419354838709677
#> 5                                       0.291666666666667
#> 6                                       0.222222222222222
#>   liv_emerg_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_3
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.193548387096774
#> 5                                        0.125
#> 6                            0.185185185185185
#>   fs_hhs_nofood_yn ~/~ no ~/~ prop_select_one
#> 1                            fs_hhs_nofood_yn
#> 2                                          no
#> 3                             prop_select_one
#> 4                           0.419354838709677
#> 5                                         0.5
#> 6                           0.518518518518518
#>   fs_hhs_nofood_yn ~/~ yes ~/~ prop_select_one
#> 1                             fs_hhs_nofood_yn
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.580645161290323
#> 5                                          0.5
#> 6                            0.481481481481481
#>   fs_hhs_nofood_freq ~/~ often_10_times ~/~ prop_select_one
#> 1                                        fs_hhs_nofood_freq
#> 2                                            often_10_times
#> 3                                           prop_select_one
#> 4                                         0.333333333333333
#> 5                                        0.0833333333333333
#> 6                                         0.384615384615385
#>   fs_hhs_nofood_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> 1                                    fs_hhs_nofood_freq
#> 2                                            rarely_1_2
#> 3                                       prop_select_one
#> 4                                     0.555555555555556
#> 5                                                   0.5
#> 6                                    0.0769230769230769
#>   fs_hhs_nofood_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> 1                                        fs_hhs_nofood_freq
#> 2                                            sometimes_3_10
#> 3                                           prop_select_one
#> 4                                         0.111111111111111
#> 5                                         0.416666666666667
#> 6                                         0.538461538461539
#>   fs_hhs_nofood_freq ~/~ NA ~/~ prop_select_one
#> 1                            fs_hhs_nofood_freq
#> 2                                          <NA>
#> 3                               prop_select_one
#> 4                                             0
#> 5                                             0
#> 6                                             0
#>   fs_hhs_sleephungry_yn ~/~ no ~/~ prop_select_one
#> 1                            fs_hhs_sleephungry_yn
#> 2                                               no
#> 3                                  prop_select_one
#> 4                                0.483870967741935
#> 5                                0.416666666666667
#> 6                                0.555555555555556
#>   fs_hhs_sleephungry_yn ~/~ yes ~/~ prop_select_one
#> 1                             fs_hhs_sleephungry_yn
#> 2                                               yes
#> 3                                   prop_select_one
#> 4                                 0.516129032258065
#> 5                                 0.583333333333333
#> 6                                 0.444444444444444
#>   fs_hhs_sleephungry_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> 1                                    fs_hhs_sleephungry_freq
#> 2                                                 rarely_1_2
#> 3                                            prop_select_one
#> 4                                                       0.75
#> 5                                                        0.4
#> 6                                          0.176470588235294
#>   fs_hhs_sleephungry_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> 1                                        fs_hhs_sleephungry_freq
#> 2                                                 sometimes_3_10
#> 3                                                prop_select_one
#> 4                                                           0.25
#> 5                                              0.466666666666667
#> 6                                              0.294117647058824
#>   fs_hhs_sleephungry_freq ~/~ NA ~/~ prop_select_one
#> 1                            fs_hhs_sleephungry_freq
#> 2                                               <NA>
#> 3                                    prop_select_one
#> 4                                                  0
#> 5                                                  0
#> 6                                                  0
#>   fs_hhs_sleephungry_freq ~/~ often_10_times ~/~ prop_select_one
#> 1                                        fs_hhs_sleephungry_freq
#> 2                                                 often_10_times
#> 3                                                prop_select_one
#> 4                                                           <NA>
#> 5                                              0.133333333333333
#> 6                                              0.529411764705882
#>   fs_hhs_daynoteating_yn ~/~ no ~/~ prop_select_one
#> 1                            fs_hhs_daynoteating_yn
#> 2                                                no
#> 3                                   prop_select_one
#> 4                                 0.612903225806452
#> 5                                             0.375
#> 6                                  0.37037037037037
#>   fs_hhs_daynoteating_yn ~/~ yes ~/~ prop_select_one
#> 1                             fs_hhs_daynoteating_yn
#> 2                                                yes
#> 3                                    prop_select_one
#> 4                                  0.387096774193548
#> 5                                              0.625
#> 6                                   0.62962962962963
#>   fs_hhs_daynoteating_freq ~/~ often_10_times ~/~ prop_select_one
#> 1                                        fs_hhs_daynoteating_freq
#> 2                                                  often_10_times
#> 3                                                 prop_select_one
#> 4                                                             0.5
#> 5                                               0.166666666666667
#> 6                                               0.384615384615385
#>   fs_hhs_daynoteating_freq ~/~ rarely_1_2 ~/~ prop_select_one
#> 1                                    fs_hhs_daynoteating_freq
#> 2                                                  rarely_1_2
#> 3                                             prop_select_one
#> 4                                           0.277777777777778
#> 5                                           0.666666666666667
#> 6                                           0.384615384615385
#>   fs_hhs_daynoteating_freq ~/~ sometimes_3_10 ~/~ prop_select_one
#> 1                                        fs_hhs_daynoteating_freq
#> 2                                                  sometimes_3_10
#> 3                                                 prop_select_one
#> 4                                               0.222222222222222
#> 5                                               0.166666666666667
#> 6                                               0.230769230769231
#>   fs_hhs_daynoteating_freq ~/~ NA ~/~ prop_select_one
#> 1                            fs_hhs_daynoteating_freq
#> 2                                                <NA>
#> 3                                     prop_select_one
#> 4                                                   0
#> 5                                                   0
#> 6                                                   0
#>   fs_food_sources_top1 ~/~ begging ~/~ prop_select_one
#> 1                                 fs_food_sources_top1
#> 2                                              begging
#> 3                                      prop_select_one
#> 4                                    0.129032258064516
#> 5                                                0.125
#> 6                                                 <NA>
#>   fs_food_sources_top1 ~/~ borrowed ~/~ prop_select_one
#> 1                                  fs_food_sources_top1
#> 2                                              borrowed
#> 3                                       prop_select_one
#> 4                                    0.0645161290322581
#> 5                                    0.0833333333333333
#> 6                                    0.0740740740740741
#>   fs_food_sources_top1 ~/~ dont_know ~/~ prop_select_one
#> 1                                   fs_food_sources_top1
#> 2                                              dont_know
#> 3                                        prop_select_one
#> 4                                      0.032258064516129
#> 5                                     0.0416666666666667
#> 6                                                   <NA>
#>   fs_food_sources_top1 ~/~ exchange ~/~ prop_select_one
#> 1                                  fs_food_sources_top1
#> 2                                              exchange
#> 3                                       prop_select_one
#> 4                                    0.0967741935483871
#> 5                                    0.0416666666666667
#> 6                                     0.111111111111111
#>   fs_food_sources_top1 ~/~ gathering ~/~ prop_select_one
#> 1                                   fs_food_sources_top1
#> 2                                              gathering
#> 3                                        prop_select_one
#> 4                                      0.032258064516129
#> 5                                                   <NA>
#> 6                                      0.037037037037037
#>   fs_food_sources_top1 ~/~ gift ~/~ prop_select_one
#> 1                              fs_food_sources_top1
#> 2                                              gift
#> 3                                   prop_select_one
#> 4                                 0.032258064516129
#> 5                                              <NA>
#> 6                                0.0740740740740741
#>   fs_food_sources_top1 ~/~ hunting_fishing ~/~ prop_select_one
#> 1                                         fs_food_sources_top1
#> 2                                              hunting_fishing
#> 3                                              prop_select_one
#> 4                                           0.0967741935483871
#> 5                                                         <NA>
#> 6                                                         <NA>
#>   fs_food_sources_top1 ~/~ in_kind_aid ~/~ prop_select_one
#> 1                                     fs_food_sources_top1
#> 2                                              in_kind_aid
#> 3                                          prop_select_one
#> 4                                       0.0645161290322581
#> 5                                        0.208333333333333
#> 6                                       0.0740740740740741
#>   fs_food_sources_top1 ~/~ none ~/~ prop_select_one
#> 1                              fs_food_sources_top1
#> 2                                              none
#> 3                                   prop_select_one
#> 4                                0.0645161290322581
#> 5                                 0.166666666666667
#> 6                                0.0740740740740741
#>   fs_food_sources_top1 ~/~ other ~/~ prop_select_one
#> 1                               fs_food_sources_top1
#> 2                                              other
#> 3                                    prop_select_one
#> 4                                  0.129032258064516
#> 5                                               <NA>
#> 6                                               <NA>
#>   fs_food_sources_top1 ~/~ own_production ~/~ prop_select_one
#> 1                                        fs_food_sources_top1
#> 2                                              own_production
#> 3                                             prop_select_one
#> 4                                           0.032258064516129
#> 5                                                        <NA>
#> 6                                          0.0740740740740741
#>   fs_food_sources_top1 ~/~ prefer_not_to_answer ~/~ prop_select_one
#> 1                                              fs_food_sources_top1
#> 2                                              prefer_not_to_answer
#> 3                                                   prop_select_one
#> 4                                                0.0645161290322581
#> 5                                                0.0833333333333333
#> 6                                                0.0740740740740741
#>   fs_food_sources_top1 ~/~ purchased ~/~ prop_select_one
#> 1                                   fs_food_sources_top1
#> 2                                              purchased
#> 3                                        prop_select_one
#> 4                                      0.129032258064516
#> 5                                     0.0833333333333333
#> 6                                      0.185185185185185
#>   fs_food_sources_top1 ~/~ purchased_cash ~/~ prop_select_one
#> 1                                        fs_food_sources_top1
#> 2                                              purchased_cash
#> 3                                             prop_select_one
#> 4                                           0.032258064516129
#> 5                                          0.0833333333333333
#> 6                                           0.148148148148148
#>   fs_food_sources_top1 ~/~ cva ~/~ prop_select_one rCSILessQlty ~/~ NA ~/~ mean
#> 1                             fs_food_sources_top1                 rCSILessQlty
#> 2                                              cva                         <NA>
#> 3                                  prop_select_one                         mean
#> 4                                             <NA>             3.09677419354839
#> 5                               0.0833333333333333                        3.375
#> 6                               0.0740740740740741             2.62962962962963
#>   rCSIBorrow ~/~ NA ~/~ mean rCSIMealSize ~/~ NA ~/~ mean
#> 1                 rCSIBorrow                 rCSIMealSize
#> 2                       <NA>                         <NA>
#> 3                       mean                         mean
#> 4           3.48387096774194             3.80645161290323
#> 5           2.58333333333333             3.95833333333333
#> 6           2.92592592592593             3.14814814814815
#>   rCSIMealAdult ~/~ NA ~/~ mean rCSIMealNb ~/~ NA ~/~ mean
#> 1                 rCSIMealAdult                 rCSIMealNb
#> 2                          <NA>                       <NA>
#> 3                          mean                       mean
#> 4              2.93548387096774           2.96774193548387
#> 5              3.70833333333333           3.16666666666667
#> 6              3.66666666666667           2.74074074074074
#>   fs_fcs_cereals_grains_roots_tubers ~/~ NA ~/~ mean
#> 1                 fs_fcs_cereals_grains_roots_tubers
#> 2                                               <NA>
#> 3                                               mean
#> 4                                   3.67741935483871
#> 5                                   3.54166666666667
#> 6                                   3.74074074074074
#>   fs_fcs_beans_nuts ~/~ NA ~/~ mean fs_fcs_dairy ~/~ NA ~/~ mean
#> 1                 fs_fcs_beans_nuts                 fs_fcs_dairy
#> 2                              <NA>                         <NA>
#> 3                              mean                         mean
#> 4                  3.45161290322581             3.35483870967742
#> 5                  3.66666666666667             3.95833333333333
#> 6                  3.03703703703704             3.48148148148148
#>   fs_fcs_meat_fish_eggs ~/~ NA ~/~ mean
#> 1                 fs_fcs_meat_fish_eggs
#> 2                                  <NA>
#> 3                                  mean
#> 4                      3.16129032258065
#> 5                      3.91666666666667
#> 6                       4.2962962962963
#>   fs_fcs_vegetables_leaves ~/~ NA ~/~ mean fs_fcs_fruit ~/~ NA ~/~ mean
#> 1                 fs_fcs_vegetables_leaves                 fs_fcs_fruit
#> 2                                     <NA>                         <NA>
#> 3                                     mean                         mean
#> 4                         3.45161290322581             3.45161290322581
#> 5                         3.16666666666667                        3.875
#> 6                         3.18518518518519              3.7037037037037
#>   fs_fcs_oil_fat_butter ~/~ NA ~/~ mean fs_fcs_sugar ~/~ NA ~/~ mean
#> 1                 fs_fcs_oil_fat_butter                 fs_fcs_sugar
#> 2                                  <NA>                         <NA>
#> 3                                  mean                         mean
#> 4                      3.64516129032258              3.2258064516129
#> 5                      4.41666666666667                            4
#> 6                      3.55555555555556             3.92592592592593
#>   fs_fcs_condiment ~/~ NA ~/~ mean income_v2_sum ~/~ NA ~/~ mean
#> 1                 fs_fcs_condiment                 income_v2_sum
#> 2                             <NA>                          <NA>
#> 3                             mean                          mean
#> 4                 4.06451612903226                          <NA>
#> 5                 3.70833333333333                          <NA>
#> 6                 2.59259259259259                          <NA>
#>   expenditure_food ~/~ NA ~/~ mean
#> 1                 expenditure_food
#> 2                             <NA>
#> 3                             mean
#> 4                 20.1935483870968
#> 5                 20.2916666666667
#> 6                 19.7037037037037
```

## Create an IPC TWG table

``` r
example_ipc <- create_ipctwg_table(.results = presentresults_resultstable,
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
                   lcsi_set = c("liv_stress_lcsi_1",
                                "liv_stress_lcsi_2",
                                "liv_stress_lcsi_3",
                                "liv_stress_lcsi_4",
                                "liv_crisis_lcsi_1",
                                "liv_crisis_lcsi_2",
                                "liv_crisis_lcsi_3",
                                "liv_emerg_lcsi_1",
                                "liv_emerg_lcsi_2",
                                "liv_emerg_lcsi_3"),
                   other_variables = c("income_v2_sum","expenditure_food"))
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].
#> Joining with `by = join_by(analysis_key)`
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 242 rows [5, 6, 11, 12,
#> 17, 18, 23, 24, 29, 30, 35, 36, 41, 42, 46, 47, 52, 53, 58, 59, ...].
head(example_ipc)
#>               group_var_value fcls_cat ~/~ phase_1 ~/~ prop_select_one
#> 1             group_var_value                                 fcls_cat
#> 2             group_var_value                                  phase_1
#> 3             group_var_value                          prop_select_one
#> 4     locationA ~/~ displaced                        0.161290322580645
#> 5 locationA ~/~ non-displaced                       0.0833333333333333
#> 6     locationB ~/~ displaced                        0.111111111111111
#>   fcls_cat ~/~ phase_2 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_2
#> 3                          prop_select_one
#> 4                        0.225806451612903
#> 5                       0.0833333333333333
#> 6                        0.333333333333333
#>   fcls_cat ~/~ phase_3 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_3
#> 3                          prop_select_one
#> 4                        0.258064516129032
#> 5                        0.291666666666667
#> 6                        0.185185185185185
#>   fcls_cat ~/~ phase_4 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_4
#> 3                          prop_select_one
#> 4                        0.193548387096774
#> 5                        0.208333333333333
#> 6                        0.185185185185185
#>   fcls_cat ~/~ phase_5 ~/~ prop_select_one
#> 1                                 fcls_cat
#> 2                                  phase_5
#> 3                          prop_select_one
#> 4                        0.161290322580645
#> 5                        0.333333333333333
#> 6                        0.185185185185185
#>   fcm_cat ~/~ phase_1 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_1
#> 3                         prop_select_one
#> 4                       0.290322580645161
#> 5                                    0.25
#> 6                       0.222222222222222
#>   fcm_cat ~/~ phase_2 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_2
#> 3                         prop_select_one
#> 4                      0.0967741935483871
#> 5                      0.0833333333333333
#> 6                       0.185185185185185
#>   fcm_cat ~/~ phase_3 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_3
#> 3                         prop_select_one
#> 4                        0.32258064516129
#> 5                       0.166666666666667
#> 6                       0.111111111111111
#>   fcm_cat ~/~ phase_4 ~/~ prop_select_one
#> 1                                 fcm_cat
#> 2                                 phase_4
#> 3                         prop_select_one
#> 4                       0.161290322580645
#> 5                       0.208333333333333
#> 6                       0.222222222222222
#>   fcm_cat ~/~ phase_5 ~/~ prop_select_one fcs_cat ~/~ low ~/~ prop_select_one
#> 1                                 fcm_cat                             fcs_cat
#> 2                                 phase_5                                 low
#> 3                         prop_select_one                     prop_select_one
#> 4                       0.129032258064516                   0.258064516129032
#> 5                       0.291666666666667                                0.25
#> 6                       0.259259259259259                    0.37037037037037
#>   fcs_cat ~/~ medium ~/~ prop_select_one fcs_cat ~/~ high ~/~ prop_select_one
#> 1                                fcs_cat                              fcs_cat
#> 2                                 medium                                 high
#> 3                        prop_select_one                      prop_select_one
#> 4                       0.32258064516129                    0.419354838709677
#> 5                                  0.375                                0.375
#> 6                      0.407407407407407                    0.222222222222222
#>   rcsi_cat ~/~ low ~/~ prop_select_one rcsi_cat ~/~ medium ~/~ prop_select_one
#> 1                             rcsi_cat                                rcsi_cat
#> 2                                  low                                  medium
#> 3                      prop_select_one                         prop_select_one
#> 4                    0.290322580645161                       0.258064516129032
#> 5                                0.375                       0.458333333333333
#> 6                    0.259259259259259                       0.518518518518518
#>   rcsi_cat ~/~ high ~/~ prop_select_one lcs_cat ~/~ none ~/~ prop_select_one
#> 1                              rcsi_cat                              lcs_cat
#> 2                                  high                                 none
#> 3                       prop_select_one                      prop_select_one
#> 4                     0.451612903225806                    0.193548387096774
#> 5                     0.166666666666667                   0.0416666666666667
#> 6                     0.222222222222222                    0.296296296296296
#>   lcs_cat ~/~ stress ~/~ prop_select_one
#> 1                                lcs_cat
#> 2                                 stress
#> 3                        prop_select_one
#> 4                      0.129032258064516
#> 5                      0.458333333333333
#> 6                      0.259259259259259
#>   lcs_cat ~/~ emergency ~/~ prop_select_one
#> 1                                   lcs_cat
#> 2                                 emergency
#> 3                           prop_select_one
#> 4                          0.32258064516129
#> 5                         0.291666666666667
#> 6                         0.185185185185185
#>   lcs_cat ~/~ crisis ~/~ prop_select_one hhs_cat ~/~ none ~/~ prop_select_one
#> 1                                lcs_cat                              hhs_cat
#> 2                                 crisis                                 none
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.354838709677419                    0.225806451612903
#> 5                      0.208333333333333                    0.208333333333333
#> 6                      0.259259259259259                    0.222222222222222
#>   hhs_cat ~/~ slight ~/~ prop_select_one
#> 1                                hhs_cat
#> 2                                 slight
#> 3                        prop_select_one
#> 4                      0.258064516129032
#> 5                      0.291666666666667
#> 6                      0.222222222222222
#>   hhs_cat ~/~ moderate ~/~ prop_select_one
#> 1                                  hhs_cat
#> 2                                 moderate
#> 3                          prop_select_one
#> 4                        0.225806451612903
#> 5                       0.0833333333333333
#> 6                        0.222222222222222
#>   hhs_cat ~/~ severe ~/~ prop_select_one
#> 1                                hhs_cat
#> 2                                 severe
#> 3                        prop_select_one
#> 4                     0.0967741935483871
#> 5                                   0.25
#> 6                      0.222222222222222
#>   hhs_cat ~/~ very_severe ~/~ prop_select_one
#> 1                                     hhs_cat
#> 2                                 very_severe
#> 3                             prop_select_one
#> 4                           0.193548387096774
#> 5                           0.166666666666667
#> 6                           0.111111111111111
#>   fs_fcs_cereals_grains_roots_tubers ~/~ NA ~/~ mean
#> 1                 fs_fcs_cereals_grains_roots_tubers
#> 2                                               <NA>
#> 3                                               mean
#> 4                                   3.67741935483871
#> 5                                   3.54166666666667
#> 6                                   3.74074074074074
#>   fs_fcs_beans_nuts ~/~ NA ~/~ mean fs_fcs_dairy ~/~ NA ~/~ mean
#> 1                 fs_fcs_beans_nuts                 fs_fcs_dairy
#> 2                              <NA>                         <NA>
#> 3                              mean                         mean
#> 4                  3.45161290322581             3.35483870967742
#> 5                  3.66666666666667             3.95833333333333
#> 6                  3.03703703703704             3.48148148148148
#>   fs_fcs_meat_fish_eggs ~/~ NA ~/~ mean
#> 1                 fs_fcs_meat_fish_eggs
#> 2                                  <NA>
#> 3                                  mean
#> 4                      3.16129032258065
#> 5                      3.91666666666667
#> 6                       4.2962962962963
#>   fs_fcs_vegetables_leaves ~/~ NA ~/~ mean fs_fcs_fruit ~/~ NA ~/~ mean
#> 1                 fs_fcs_vegetables_leaves                 fs_fcs_fruit
#> 2                                     <NA>                         <NA>
#> 3                                     mean                         mean
#> 4                         3.45161290322581             3.45161290322581
#> 5                         3.16666666666667                        3.875
#> 6                         3.18518518518519              3.7037037037037
#>   fs_fcs_oil_fat_butter ~/~ NA ~/~ mean fs_fcs_sugar ~/~ NA ~/~ mean
#> 1                 fs_fcs_oil_fat_butter                 fs_fcs_sugar
#> 2                                  <NA>                         <NA>
#> 3                                  mean                         mean
#> 4                      3.64516129032258              3.2258064516129
#> 5                      4.41666666666667                            4
#> 6                      3.55555555555556             3.92592592592593
#>   fs_fcs_condiment ~/~ NA ~/~ mean rCSILessQlty ~/~ NA ~/~ mean
#> 1                 fs_fcs_condiment                 rCSILessQlty
#> 2                             <NA>                         <NA>
#> 3                             mean                         mean
#> 4                 4.06451612903226             3.09677419354839
#> 5                 3.70833333333333                        3.375
#> 6                 2.59259259259259             2.62962962962963
#>   rCSIBorrow ~/~ NA ~/~ mean rCSIMealSize ~/~ NA ~/~ mean
#> 1                 rCSIBorrow                 rCSIMealSize
#> 2                       <NA>                         <NA>
#> 3                       mean                         mean
#> 4           3.48387096774194             3.80645161290323
#> 5           2.58333333333333             3.95833333333333
#> 6           2.92592592592593             3.14814814814815
#>   rCSIMealAdult ~/~ NA ~/~ mean rCSIMealNb ~/~ NA ~/~ mean
#> 1                 rCSIMealAdult                 rCSIMealNb
#> 2                          <NA>                       <NA>
#> 3                          mean                       mean
#> 4              2.93548387096774           2.96774193548387
#> 5              3.70833333333333           3.16666666666667
#> 6              3.66666666666667           2.74074074074074
#>   rCSILessQlty ~/~ 0 ~/~ prop_select_one rCSIBorrow ~/~ 0 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      0                                    0
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.129032258064516                    0.129032258064516
#> 5                                  0.125                    0.166666666666667
#> 6                      0.185185185185185                    0.259259259259259
#>   rCSIMealSize ~/~ 0 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      0
#> 3                        prop_select_one
#> 4                     0.0967741935483871
#> 5                                  0.125
#> 6                      0.185185185185185
#>   rCSIMealAdult ~/~ 0 ~/~ prop_select_one rCSIMealNb ~/~ 0 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       0                                    0
#> 3                         prop_select_one                      prop_select_one
#> 4                      0.0645161290322581                    0.129032258064516
#> 5                      0.0833333333333333                                0.125
#> 6                      0.0740740740740741                    0.185185185185185
#>   rCSILessQlty ~/~ 1 ~/~ prop_select_one rCSIBorrow ~/~ 1 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      1                                    1
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.161290322580645                    0.129032258064516
#> 5                     0.0416666666666667                                0.125
#> 6                      0.222222222222222                    0.222222222222222
#>   rCSIMealSize ~/~ 1 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      1
#> 3                        prop_select_one
#> 4                      0.161290322580645
#> 5                     0.0416666666666667
#> 6                      0.111111111111111
#>   rCSIMealAdult ~/~ 1 ~/~ prop_select_one rCSIMealNb ~/~ 1 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       1                                    1
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.258064516129032                    0.161290322580645
#> 5                                   0.125                                0.125
#> 6                      0.0740740740740741                    0.148148148148148
#>   rCSILessQlty ~/~ 2 ~/~ prop_select_one rCSIBorrow ~/~ 2 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      2                                    2
#> 3                        prop_select_one                      prop_select_one
#> 4                     0.0967741935483871                   0.0645161290322581
#> 5                      0.166666666666667                    0.291666666666667
#> 6                      0.148148148148148                                 <NA>
#>   rCSIMealSize ~/~ 2 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      2
#> 3                        prop_select_one
#> 4                      0.129032258064516
#> 5                     0.0833333333333333
#> 6                      0.185185185185185
#>   rCSIMealAdult ~/~ 2 ~/~ prop_select_one rCSIMealNb ~/~ 2 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       2                                    2
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.225806451612903                    0.193548387096774
#> 5                                   0.125                                0.125
#> 6                       0.185185185185185                   0.0740740740740741
#>   rCSILessQlty ~/~ 3 ~/~ prop_select_one rCSIBorrow ~/~ 3 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      3                                    3
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.225806451612903                    0.193548387096774
#> 5                      0.208333333333333                                0.125
#> 6                      0.111111111111111                   0.0740740740740741
#>   rCSIMealSize ~/~ 3 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      3
#> 3                        prop_select_one
#> 4                     0.0645161290322581
#> 5                      0.166666666666667
#> 6                      0.148148148148148
#>   rCSIMealAdult ~/~ 3 ~/~ prop_select_one rCSIMealNb ~/~ 3 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       3                                    3
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.129032258064516                    0.129032258064516
#> 5                      0.0833333333333333                    0.208333333333333
#> 6                       0.222222222222222                    0.296296296296296
#>   rCSILessQlty ~/~ 4 ~/~ prop_select_one rCSIBorrow ~/~ 4 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      4                                    4
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.129032258064516                    0.129032258064516
#> 5                                  0.125                   0.0833333333333333
#> 6                      0.111111111111111                    0.148148148148148
#>   rCSIMealSize ~/~ 4 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      4
#> 3                        prop_select_one
#> 4                     0.0645161290322581
#> 5                                  0.125
#> 6                      0.037037037037037
#>   rCSIMealAdult ~/~ 4 ~/~ prop_select_one rCSIMealNb ~/~ 4 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       4                                    4
#> 3                         prop_select_one                      prop_select_one
#> 4                      0.0967741935483871                    0.129032258064516
#> 5                       0.208333333333333                    0.166666666666667
#> 6                       0.111111111111111                   0.0740740740740741
#>   rCSILessQlty ~/~ 5 ~/~ prop_select_one rCSIBorrow ~/~ 5 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      5                                    5
#> 3                        prop_select_one                      prop_select_one
#> 4                     0.0645161290322581                    0.129032258064516
#> 5                      0.166666666666667                   0.0833333333333333
#> 6                     0.0740740740740741                   0.0740740740740741
#>   rCSIMealSize ~/~ 5 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      5
#> 3                        prop_select_one
#> 4                      0.161290322580645
#> 5                      0.166666666666667
#> 6                     0.0740740740740741
#>   rCSIMealAdult ~/~ 5 ~/~ prop_select_one rCSIMealNb ~/~ 5 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       5                                    5
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.032258064516129                   0.0967741935483871
#> 5                                   0.125                                0.125
#> 6                       0.037037037037037                    0.111111111111111
#>   rCSILessQlty ~/~ 6 ~/~ prop_select_one rCSIBorrow ~/~ 6 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      6                                    6
#> 3                        prop_select_one                      prop_select_one
#> 4                      0.129032258064516                   0.0967741935483871
#> 5                                  0.125                                0.125
#> 6                     0.0740740740740741                    0.037037037037037
#>   rCSIMealSize ~/~ 6 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      6
#> 3                        prop_select_one
#> 4                      0.129032258064516
#> 5                                  0.125
#> 6                      0.111111111111111
#>   rCSIMealAdult ~/~ 6 ~/~ prop_select_one rCSIMealNb ~/~ 6 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       6                                    6
#> 3                         prop_select_one                      prop_select_one
#> 4                      0.0645161290322581                   0.0967741935483871
#> 5                                   0.125                                 <NA>
#> 6                       0.148148148148148                   0.0740740740740741
#>   rCSILessQlty ~/~ 7 ~/~ prop_select_one rCSIBorrow ~/~ 7 ~/~ prop_select_one
#> 1                           rCSILessQlty                           rCSIBorrow
#> 2                                      7                                    7
#> 3                        prop_select_one                      prop_select_one
#> 4                     0.0645161290322581                    0.129032258064516
#> 5                     0.0416666666666667                                 <NA>
#> 6                     0.0740740740740741                    0.185185185185185
#>   rCSIMealSize ~/~ 7 ~/~ prop_select_one
#> 1                           rCSIMealSize
#> 2                                      7
#> 3                        prop_select_one
#> 4                      0.193548387096774
#> 5                      0.166666666666667
#> 6                      0.148148148148148
#>   rCSIMealAdult ~/~ 7 ~/~ prop_select_one rCSIMealNb ~/~ 7 ~/~ prop_select_one
#> 1                           rCSIMealAdult                           rCSIMealNb
#> 2                                       7                                    7
#> 3                         prop_select_one                      prop_select_one
#> 4                       0.129032258064516                   0.0645161290322581
#> 5                                   0.125                                0.125
#> 6                       0.148148148148148                    0.037037037037037
#>   liv_stress_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_1
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.258064516129032
#> 5                                         0.375
#> 6                             0.259259259259259
#>   liv_stress_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_2
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.258064516129032
#> 5                             0.333333333333333
#> 6                             0.222222222222222
#>   liv_stress_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_3
#> 2                                           yes
#> 3                               prop_select_one
#> 4                            0.0967741935483871
#> 5                                          0.25
#> 6                             0.296296296296296
#>   liv_stress_lcsi_4 ~/~ yes ~/~ prop_select_one
#> 1                             liv_stress_lcsi_4
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.225806451612903
#> 5                             0.208333333333333
#> 6                              0.37037037037037
#>   liv_crisis_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_1
#> 2                                           yes
#> 3                               prop_select_one
#> 4                              0.32258064516129
#> 5                                         0.375
#> 6                             0.148148148148148
#>   liv_crisis_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_2
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.225806451612903
#> 5                             0.291666666666667
#> 6                             0.185185185185185
#>   liv_crisis_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_crisis_lcsi_3
#> 2                                           yes
#> 3                               prop_select_one
#> 4                             0.290322580645161
#> 5                                          0.25
#> 6                             0.222222222222222
#>   liv_emerg_lcsi_1 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_1
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.387096774193548
#> 5                            0.333333333333333
#> 6                            0.259259259259259
#>   liv_emerg_lcsi_2 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_2
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.258064516129032
#> 5                            0.166666666666667
#> 6                            0.296296296296296
#>   liv_emerg_lcsi_3 ~/~ yes ~/~ prop_select_one
#> 1                             liv_emerg_lcsi_3
#> 2                                          yes
#> 3                              prop_select_one
#> 4                            0.193548387096774
#> 5                                        0.125
#> 6                            0.185185185185185
#>   liv_stress_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_1
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.208333333333333
#> 6                                        0.259259259259259
#>   liv_stress_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_2
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.290322580645161
#> 5                                        0.166666666666667
#> 6                                        0.222222222222222
#>   liv_stress_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_3
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                         0.32258064516129
#> 5                                        0.208333333333333
#> 6                                        0.333333333333333
#>   liv_stress_lcsi_4 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_4
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.129032258064516
#> 5                                                    0.125
#> 6                                        0.185185185185185
#>   liv_crisis_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_1
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.225806451612903
#> 5                                        0.166666666666667
#> 6                                        0.296296296296296
#>   liv_crisis_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_2
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.225806451612903
#> 5                                        0.166666666666667
#> 6                                        0.407407407407407
#>   liv_crisis_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_3
#> 2                                           no_had_no_need
#> 3                                          prop_select_one
#> 4                                        0.129032258064516
#> 5                                                    0.125
#> 6                                        0.185185185185185
#>   liv_emerg_lcsi_1 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_1
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.193548387096774
#> 5                                                    0.25
#> 6                                       0.333333333333333
#>   liv_emerg_lcsi_2 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_2
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.387096774193548
#> 5                                                    0.25
#> 6                                       0.333333333333333
#>   liv_emerg_lcsi_3 ~/~ no_had_no_need ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_3
#> 2                                          no_had_no_need
#> 3                                         prop_select_one
#> 4                                       0.161290322580645
#> 5                                       0.333333333333333
#> 6                                       0.296296296296296
#>   liv_stress_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_1
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                                  0.125
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_2
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                      0.208333333333333
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_3
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.258064516129032
#> 5                                      0.291666666666667
#> 6                                      0.296296296296296
#>   liv_stress_lcsi_4 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_stress_lcsi_4
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.387096774193548
#> 5                                                  0.375
#> 6                                      0.222222222222222
#>   liv_crisis_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_1
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.290322580645161
#> 5                                      0.208333333333333
#> 6                                      0.259259259259259
#>   liv_crisis_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_2
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.387096774193548
#> 5                                                  0.375
#> 6                                      0.259259259259259
#>   liv_crisis_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_crisis_lcsi_3
#> 2                                           no_exhausted
#> 3                                        prop_select_one
#> 4                                      0.193548387096774
#> 5                                      0.291666666666667
#> 6                                       0.37037037037037
#>   liv_emerg_lcsi_1 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_1
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.129032258064516
#> 5                                     0.166666666666667
#> 6                                     0.222222222222222
#>   liv_emerg_lcsi_2 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_2
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.161290322580645
#> 5                                     0.166666666666667
#> 6                                     0.148148148148148
#>   liv_emerg_lcsi_3 ~/~ no_exhausted ~/~ prop_select_one
#> 1                                      liv_emerg_lcsi_3
#> 2                                          no_exhausted
#> 3                                       prop_select_one
#> 4                                     0.225806451612903
#> 5                                                  0.25
#> 6                                     0.296296296296296
#>   liv_stress_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_1
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.290322580645161
#> 5                                        0.291666666666667
#> 6                                        0.185185185185185
#>   liv_stress_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_2
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.291666666666667
#> 6                                        0.259259259259259
#>   liv_stress_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_3
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                         0.32258064516129
#> 5                                                     0.25
#> 6                                       0.0740740740740741
#>   liv_stress_lcsi_4 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_stress_lcsi_4
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.258064516129032
#> 5                                        0.291666666666667
#> 6                                        0.222222222222222
#>   liv_crisis_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_1
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.161290322580645
#> 5                                                     0.25
#> 6                                        0.296296296296296
#>   liv_crisis_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_2
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.161290322580645
#> 5                                        0.166666666666667
#> 6                                        0.148148148148148
#>   liv_crisis_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_crisis_lcsi_3
#> 2                                           not_applicable
#> 3                                          prop_select_one
#> 4                                        0.387096774193548
#> 5                                        0.333333333333333
#> 6                                        0.222222222222222
#>   liv_emerg_lcsi_1 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_1
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.290322580645161
#> 5                                                    0.25
#> 6                                       0.185185185185185
#>   liv_emerg_lcsi_2 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_2
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.193548387096774
#> 5                                       0.416666666666667
#> 6                                       0.222222222222222
#>   liv_emerg_lcsi_3 ~/~ not_applicable ~/~ prop_select_one
#> 1                                        liv_emerg_lcsi_3
#> 2                                          not_applicable
#> 3                                         prop_select_one
#> 4                                       0.419354838709677
#> 5                                       0.291666666666667
#> 6                                       0.222222222222222
#>   income_v2_sum ~/~ NA ~/~ mean expenditure_food ~/~ NA ~/~ mean
#> 1                 income_v2_sum                 expenditure_food
#> 2                          <NA>                             <NA>
#> 3                          mean                             mean
#> 4                          <NA>                 20.1935483870968
#> 5                          <NA>                 20.2916666666667
#> 6                          <NA>                 19.7037037037037
```

## Converting the analysis index into a table

This is is how to turn the analysis index into a table

``` r

resultstable <- data.frame(analysis_index = c("mean @/@ v1 ~/~ NA @/@ NA ~/~ NA",
                                              "mean @/@ v1 ~/~ NA @/@ gro ~/~ A",
                                              "mean @/@ v1 ~/~ NA @/@ gro ~/~ B"))

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
