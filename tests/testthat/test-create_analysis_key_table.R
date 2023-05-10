test_that("returns correct results", {

  results_test <- data.frame(analysis_key = c("prop_select_one @/@ fcs_cat ~/~ low @/@ location ~/~ locationA ~/~ population ~/~ displaced",
                                              "mean @/@ expenditure_food ~/~ NA @/@ location ~/~ locationB"))

  expected_output <- results_test %>%
    dplyr::mutate(analysis_type = c("prop_select_one", "mean"),
      analysis_var_1 = c("fcs_cat", "expenditure_food"),
                  analysis_var_value_1 = c("low", "NA"),
                  group_var_1 = c("location", "location"),
                  group_var_value_1 = c("locationA", "locationB"),
                  group_var_2 = c("population", NA),
                  group_var_value_2 = c("displaced", NA),
      nb_analysis_var = c(1,1),
      nb_group_var = c(2,1))

  actual_output <- create_analysis_key_table(results_test) %>%
    suppressWarnings()

  expect_equal(actual_output,
               expected_output)
})

test_that("if index not in the correct format, stops", {
  result_test <- presentresults_resultstable %>%
    head() %>%
    dplyr::mutate(analysis_key = gsub("@/@", "@@", analysis_key))

  expect_error(create_analysis_key_table(.results = result_test),
               "Analysis keys does not seem to follow the correct format")
})



