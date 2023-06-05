test_that("if the format is not correct, returns an error", {
  analysis_key_test <- c("analysis_type @/@ analysis_var ~/~ analysis_var_value")
  expect_error(verify_analysis_key(analysis_key_test))
})
