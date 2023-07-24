test_that("returns the correct results", {
  results <- readRDS(testthat::test_path("fixtures", "results.rds"))

  expected_wide_table <-readRDS(testthat::test_path("fixtures", "widetable1.rds"))

  expected_wide_table <- expected_wide_table |> dplyr::mutate(
    analysis_var_value = dplyr::case_when(analysis_var_value == "NA" ~ NA_character_,
                                          T~analysis_var_value)
  )


  expect_equal(
    create_table_variable_x_group(results, "key_index", "stat"),
    expected_wide_table
  ) %>%
    suppressWarnings()
})

test_that("returns correct error message if index column is not correct.", {
  results <- readRDS(testthat::test_path("fixtures", "results.rds"))
  results <- results %>%
    dplyr::mutate(
      key_index = stringr::str_replace(key_index,
                                       pattern = " *[:alnum:] @/@",
                                       replacement = "XXXXXXXXXXXXX")
    )
  expected_wide_table <-
    readRDS(testthat::test_path("fixtures", "widetable1.rds"))
  expect_error(
    create_table_variable_x_group(results, "key_index", "stat"),
    "Analysis keys does not seem to follow the correct format"
  )
})

test_that("returns the correct results with 3 stats", {
  results <- readRDS(testthat::test_path("fixtures", "results.rds"))
  expected_wide_table <-
    readRDS(testthat::test_path("fixtures", "widetable1_3stats.rds"))


 actual <-  create_table_variable_x_group(results,
                                "key_index",
                                c("stat", "stat_low", "stat_upp"))%>%
   suppressWarnings()



  expect_equal(actual, expected_wide_table)
})

test_that("returns a list per grouping variables", {
  results <- readRDS(testthat::test_path("fixtures", "results.rds"))
  expected_wide_table <-
    readRDS(testthat::test_path("fixtures", "widetable1_list_excel.rds"))


  actual <- create_table_variable_x_group(results,
                                "key_index",
                                c("stat"),
                                list_for_excel = TRUE)

  expect_equal( actual,expected_wide_table
  )  %>%
    suppressWarnings()
  ###the results of create_table_variable_x_group(results, "key_index",
  ###c("stat"), list_for_excel = TRUE) differs within the expect_equal and when
  ### running it. try with debugonce to see that

})

