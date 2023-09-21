
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

``` r
library(presentresults)
```

## Large table variables (lines) per groups (columns)

This is how to turn a results table into a wide table variable per
group.

``` r
example_variable_x_group <- presentresults_resultstable %>%
  create_table_variable_x_group()
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].

example_variable_x_group[1:6, 1:9]
#> # A tibble: 6 × 9
#>   analysis_type   analysis_var analysis_var_value `stat_locationA ~/~ displaced`
#>   <chr>           <chr>        <chr>                                       <dbl>
#> 1 prop_select_one fcs_cat      low                                         0.258
#> 2 prop_select_one fcs_cat      medium                                      0.323
#> 3 prop_select_one fcs_cat      high                                        0.419
#> 4 prop_select_one rcsi_cat     low                                         0.290
#> 5 prop_select_one rcsi_cat     medium                                      0.258
#> 6 prop_select_one rcsi_cat     high                                        0.452
#> # ℹ 5 more variables: `stat_low_locationA ~/~ displaced` <dbl>,
#> #   `stat_upp_locationA ~/~ displaced` <dbl>,
#> #   `stat_locationA ~/~ non-displaced` <dbl>,
#> #   `stat_low_locationA ~/~ non-displaced` <dbl>,
#> #   `stat_upp_locationA ~/~ non-displaced` <dbl>
```

``` r
example_variable_x_group %>%
  create_xlsx_variable_x_group(file_path = "mytable.xlsx")
```

The table without the higher and lower confidence bound.

``` r
example_variable_x_group <- presentresults_resultstable %>%
  create_table_variable_x_group(value_columns = "stat")
#> Warning: Expected 4 pieces. Missing pieces filled with `NA` in 305 rows [525, 526, 527,
#> 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
#> 544, ...].

example_variable_x_group[1:6, 1:9]
#> # A tibble: 6 × 9
#>   analysis_type   analysis_var analysis_var_value `locationA ~/~ displaced`
#>   <chr>           <chr>        <chr>                                  <dbl>
#> 1 prop_select_one fcs_cat      low                                    0.258
#> 2 prop_select_one fcs_cat      medium                                 0.323
#> 3 prop_select_one fcs_cat      high                                   0.419
#> 4 prop_select_one rcsi_cat     low                                    0.290
#> 5 prop_select_one rcsi_cat     medium                                 0.258
#> 6 prop_select_one rcsi_cat     high                                   0.452
#> # ℹ 5 more variables: `locationA ~/~ non-displaced` <dbl>,
#> #   `locationB ~/~ displaced` <dbl>, `locationB ~/~ non-displaced` <dbl>,
#> #   locationA <dbl>, locationB <dbl>
```

``` r
presentresults_resultstable %>%
  create_table_variable_x_group() %>%
  create_xlsx_variable_x_group(
    file_path = "mytable.xlsx",
    value_columns = "stat"
  )
```

## Large table groups (lines) per variables (columns)

This is how to turn a results table into a wide group per variable. This
format is made to be read in Excel.

``` r
example_group_x_variable <- create_table_group_x_variable(presentresults_resultstable, value_columns = "stat")

example_group_x_variable[1:6, 1:10]
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
```

## Export a table group per variable in Excel

``` r
presentresults_resultstable %>%
  create_table_group_x_variable() %>%
  create_xlsx_group_x_variable(file_path = "mytable.xlsx")
```

### Example for the IPC TWG table

``` r
example_ipc <- create_ipctwg_table(
  .results = presentresults_resultstable,
  dataset = presentresults_MSNA_template_data,
  cluster_name = "cluster_id",
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
#> Joining with `by = join_by(analysis_key)`
#> Joining with `by = join_by(group_var_value)`

example_ipc[["ipctwg_table"]][1:6, 1:10]
#>                                       group_var_value number_of_cluster
#> header_analysis_var                   group_var_value number_of_cluster
#> header_analysis_var_value             group_var_value              <NA>
#> header_analysis_type                  group_var_value              <NA>
#> 1                             locationA ~/~ displaced                 2
#> 2                         locationA ~/~ non-displaced                 2
#> 3                             locationB ~/~ displaced                 2
#>                           number_of_hh fcls_cat ~/~ phase_1 ~/~ prop_select_one
#> header_analysis_var       number_of_hh                                 fcls_cat
#> header_analysis_var_value         <NA>                                  phase_1
#> header_analysis_type              <NA>                          prop_select_one
#> 1                                   31                        0.161290322580645
#> 2                                   24                       0.0833333333333333
#> 3                                   27                        0.111111111111111
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
```

``` r
example_ipc %>%
  create_xlsx_group_x_variable(example_ipc, table_name = "ipctwg_table", file_path = "ipc_table.xlsx")
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

## `create_group_clusters()`

The function `create_group_clusters()` creates number of cluster and
number of hh surveyed per group/strata

``` r
create_group_clusters(
  result = presentresults_resultstable,
  dataset = presentresults_MSNA_template_data,
  cluster_name = "cluster_id"
) |> head()
#> # A tibble: 6 × 3
#>   group_var_value             number_of_cluster number_of_hh
#>   <chr>                                   <int>        <int>
#> 1 locationA ~/~ displaced                     2           31
#> 2 locationA ~/~ non-displaced                 2           24
#> 3 locationB ~/~ displaced                     2           27
#> 4 locationB ~/~ non-displaced                 2           18
#> 5 locationA                                   2           55
#> 6 locationB                                   2           45
```

## Code of Conduct

Please note that the presentresults project is released with a
[Contributor Code of
Conduct](https://impact-initiatives.github.io/presentresults/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
