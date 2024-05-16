test_that("Test that outputs have not changed", {
  temp_dir_to_test <- withr::local_tempdir(fileext = "test")

  # 3 stats
  results_variable_x_group_3stats <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.RDS"))
  results_variable_x_group_3stats %>%
    create_xlsx_variable_x_group(
      file_path = paste0(temp_dir_to_test, "\\testing_table_variable_x_group_3stats.xlsx"),
      overwrite = TRUE
    )

  ## readme
  expected_readme_output <- openxlsx::read.xlsx(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.xlsx"),
    sheet = "readme"
  ) %>%
    suppressWarnings()

  actual_readme_output <- openxlsx::read.xlsx(paste0(temp_dir_to_test, "\\testing_table_variable_x_group_3stats.xlsx"),
    sheet = "readme"
  ) %>%
    suppressWarnings()

  expect_equal(actual_readme_output, expected_readme_output)

  ## table
  expected_table_output <- openxlsx::read.xlsx(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.xlsx"),
    sheet = "variable_x_group_table"
  ) %>%
    suppressWarnings()

  actual_table_output <- openxlsx::read.xlsx(paste0(temp_dir_to_test, "\\testing_table_variable_x_group_3stats.xlsx"),
    sheet = "variable_x_group_table"
  ) %>%
    suppressWarnings()

  expect_equal(actual_table_output, expected_table_output)

  # 1 stat
  skip_on_os(os ="mac","Skip as workbook object seems to behave differently on github virtual machines, rounding is different")
  # comment the skip and to be run manually with devtools::test()
  results_variable_x_group_1stat <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_1stat.RDS"))
  results_variable_x_group_1stat %>%
    create_xlsx_variable_x_group(
      file_path = paste0(temp_dir_to_test, "\\results_variable_x_group_1stats.xlsx"),
      value_columns = "stat",
      overwrite = TRUE
    ) %>%
    suppressWarnings()

  ## table
  expected_table_1stat_output <- openxlsx::read.xlsx(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_1stats.xlsx"),
    sheet = "variable_x_group_table"
  ) %>%
    suppressWarnings()

  actual_table_1stat_output <- openxlsx::read.xlsx(paste0(temp_dir_to_test, "\\results_variable_x_group_1stats.xlsx"),
    sheet = "variable_x_group_table"
  ) %>%
    suppressWarnings()

  expect_equal(actual_table_output, expected_table_output)
})

test_that("if file path is null, it returns a wb object", {
  results_variable_x_group_3stats <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.RDS"))
  actual_output <- create_xlsx_variable_x_group(results_variable_x_group_3stats)
  expect_true(class(actual_output) == "Workbook")
})

test_that("if file path is not null, the file path should have the correct format", {
  results_variable_x_group_3stats <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.RDS"))

  expect_error(
    create_xlsx_variable_x_group(results_variable_x_group_3stats,
      file_path = "folder/xs"
    ),
    "file_path does not containts \\.xlsx"
  )
})

test_that("test that value_columns throw errors when not matching", {
  results_variable_x_group_1stat <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_1stat.RDS"))

  expect_error(
    create_xlsx_variable_x_group(results_variable_x_group_1stat),
    "Length of value_columns does not match with the table."
  )
})

test_that("test that value_columns length is one, the warning say it cannot be verified.", {
  temp_dir_to_test <- withr::local_tempdir(fileext = "test")

  results_variable_x_group_3stats <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.RDS"))

  expect_warning(
    create_xlsx_variable_x_group(results_variable_x_group_3stats,
      value_columns = c("stat"),
      file_path = paste0(temp_dir_to_test, "\\xx.xlsx"),
      overwrite = T
    ),
    "Length of value_columns is one, function cannot checks the number of columns."
  )
})

test_that("Test that outputs have not changed", {
  skip("Skip as workbook object seems to behave differently on github virtual machines")
  # comment the skip and to be run manually with devtools::test()

  temp_dir_to_test <- withr::local_tempdir(fileext = "test")

  # 3 stats
  results_variable_x_group_3stats <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_3stats.RDS"))

  ## wb object
  expected_wb_output <- readRDS(testthat::test_path("fixtures/variable_x_group", "wb_variable_x_group_3stats.RDS"))
  actual_wb_output <- results_variable_x_group_3stats %>%
    create_xlsx_variable_x_group()

  # core have the date the file was created and will always be different.
  expected_wb_output$core <- ""
  actual_wb_output$core <- ""

  expect_equal(actual_wb_output, expected_wb_output)

  # 1 stat
  results_variable_x_group_1stat <- readRDS(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_1stat.RDS"))

  ## wb object
  expected_1stat_wb_output <- readRDS(testthat::test_path("fixtures/variable_x_group", "wb_variable_x_group_1stat.RDS"))

  expected_table_1stat_output <- openxlsx::read.xlsx(testthat::test_path("fixtures/variable_x_group", "table_variable_x_group_1stats.xlsx"),
                                                     sheet = "variable_x_group_table"
  ) %>%
    suppressWarnings()
  actual_1stat_wb_output <- expected_table_1stat_output %>%
    create_xlsx_variable_x_group(value_columns = "stat") %>%
    suppressWarnings()

  # core have the date the file was created and will always be different.
  expected_1stat_wb_output$core <- ""
  actual_1stat_wb_output$core <- ""

  expect_equal(actual_1stat_wb_output, expected_1stat_wb_output)
})
