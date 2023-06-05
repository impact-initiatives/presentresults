test_that("Test that outputs have not changed", {
  temp_dir_to_test <- withr::local_tempdir(fileext = "test")

  expected_output <- openxlsx::read.xlsx(testthat::test_path("fixtures", "ipctwg_table.xlsx"))

  export_fewsnet <- readRDS(testthat::test_path("fixtures", "export_fewsnet.RDS"))
  export_fewsnet %>%
    create_xlsx_group_x_variable(paste0(temp_dir_to_test, "\\testing_ipctwg_table.xlsx")) %>%
    suppressWarnings()
  actual_output <- openxlsx::read.xlsx(paste0(temp_dir_to_test, "\\testing_ipctwg_table.xlsx"))

  expect_equal(actual_output, expected_output)
})
