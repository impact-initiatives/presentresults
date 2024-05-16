test_that("Test that outputs have not changed", {
  temp_dir_to_test <- withr::local_tempdir(fileext = "test")

  expected_output <- openxlsx::read.xlsx(testthat::test_path("fixtures/group_x_variable", "ipc_table.xlsx"))

  export_fewsnet <- readRDS(testthat::test_path("fixtures/group_x_variable", "table_group_x_variable_export_fewsnet.RDS"))
  export_fewsnet %>%
    create_xlsx_group_x_variable(
      table_name = "ipc_table",
      file_path = paste0(temp_dir_to_test, "\\testing_ipc_table.xlsx")
    ) %>%
    suppressWarnings()
  actual_output <- openxlsx::read.xlsx(paste0(temp_dir_to_test, "\\testing_ipc_table.xlsx"))

  # rounding and reading text makes the tolerance not work
  expect_equal(names(expected_output), names(actual_output))

  # check headers
  expect_equal(expected_output[1:2,], actual_output[1:2,])

  numeric_expected_output <- expected_output[3:nrow(expected_output),] %>%
    `names<-`(1:ncol(expected_output) %>% as.character()) %>%
    dplyr::mutate(dplyr::across(-all_of("1"), as.numeric))

  numeric_actual_output <- actual_output[3:nrow(actual_output),] %>%
    `names<-`(1:ncol(actual_output) %>% as.character()) %>%
    dplyr::mutate(dplyr::across(-all_of("1"), as.numeric))
  expect_equal(numeric_expected_output, numeric_actual_output)
})
