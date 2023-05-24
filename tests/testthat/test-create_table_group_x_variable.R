test_that("results are showned correclty", {
  expected_results <- readRDS(testthat::test_path("fixtures", "results_group_x_variable.RDS"))

  actual_output <- create_table_group_x_variable(presentresults_resultstable,
                                                 value_columns = "stat") %>%
    suppressWarnings()
  expect_equal(actual_output,
               expected_results)
})
test_that("if some arguments are missing, it throws an error.", {
  expect_error(create_table_group_x_variable(presentresults_resultstable,
                                             value_columns = "mean/pct"),
               "Cannot find at least one of the value_columns element")
})

test_that("returns correct error message if index column is not correct.", {
  results <- presentresults_resultstable %>%
    dplyr::mutate(
      analysis_key = stringr::str_replace(analysis_key,
                                       pattern = " *[:alnum:] @/@",
                                       replacement = "XXXXXXXXXXXXX")
    )

  expect_error(
    create_table_group_x_variable(results, "stat"),
    "Analysis keys does not seem to follow the correct format"
  )
})
