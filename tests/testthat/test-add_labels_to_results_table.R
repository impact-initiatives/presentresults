testthat::test_that("final table for labels", {
  actual_output <- add_label_columns_to_results_table(
    presentresults_MSNA2024_results_table,
    presentresults_MSNA2024_dictionary
  )

  expected_results <- readRDS(testthat::test_path("fixtures/add_labels/", "label_results.rds"))

  testthat::expect_equal(actual_output, expected_results)
})


testthat::test_that("review_kobo_labels returns correct outputs", {
  actual_outcome <- review_kobo_labels(
    presentresults_MSNA2024_kobotool_template[["kobo_survey"]],
    presentresults_MSNA2024_kobotool_template[["kobo_choices"]]
  )
  expected_output <- readRDS(testthat::test_path("fixtures/add_labels/", "review_kobo_label_no_filter.rds"))
  testthat::expect_equal(actual_outcome, expected_output)

  actual_outcome_with_results_table <- review_kobo_labels(presentresults_MSNA2024_kobotool_template[["kobo_survey"]],
    presentresults_MSNA2024_kobotool_template[["kobo_choices"]],
    results_table = presentresults_MSNA2024_results_table
  )
  expected_output_with_results_table <- readRDS(testthat::test_path("fixtures/add_labels/", "review_kobo_label_with_filter.rds"))
  testthat::expect_equal(actual_outcome_with_results_table, expected_output_with_results_table)

  actual_outcome <- review_kobo_labels(
    presentresults_MSNA2024_kobotool_fixed[["kobo_survey"]],
    presentresults_MSNA2024_kobotool_fixed[["kobo_choices"]]
  )
  testthat::expect_equal(actual_outcome, dplyr::tibble(
    comments = character(),
    name = character(),
    list_name = character(),
    `label::english` = character(),
    n = integer()
  ))
})

testthat::test_that("creatre_dictionary returns correct list", {
  actual_output <- create_label_dictionary(
    presentresults_MSNA2024_kobotool_fixed[["kobo_survey"]],
    presentresults_MSNA2024_kobotool_fixed[["kobo_choices"]]
  )
  expected_output <- readRDS(testthat::test_path("fixtures/add_labels/", "MSNA2024_dictionary.rds"))

  testthat::expect_equal(actual_output, expected_output)
})
