test_that("Verifications work", {
  presentresults::presentresults_MSNA2024_results_table |>
    dplyr::filter(
      analysis_var == "wash_drinking_water_source_cat",
      analysis_var_value == "surface_water",
      group_var == "admin1"
    ) |>
    create_table_for_map(group_var_value_column = "Admin Group") |>
    expect_error("Cannot find Admin Group in the results table")

  presentresults::presentresults_MSNA2024_results_table |>
    dplyr::filter(
      analysis_var == "wash_drinking_water_source_cat",
      analysis_var_value == "surface_water",
      group_var == "admin1"
    ) |>
    create_table_for_map(analysis_var_column = "Water source cat") |>
    expect_error("Cannot find Water source cat in the results table")

  presentresults::presentresults_MSNA2024_results_table |>
    dplyr::filter(
      analysis_var == "wash_drinking_water_source_cat",
      analysis_var_value == "surface_water",
      group_var == "admin1"
    ) |>
    create_table_for_map(stat_column = "prop") |>
    expect_error("Cannot find prop in the results table")

  presentresults::presentresults_MSNA2024_results_table |>
    dplyr::filter(
      analysis_var == "wash_drinking_water_source_cat",
      analysis_var_value == "surface_water",
      group_var == "admin1"
    ) |>
    create_table_for_map(number_classes = 7) |>
    expect_error("There can only be 5 or 6 classes")
})

test_that("results are correct", {
  results_test_table <- data.frame(group_var_value = rep(paste("admin", 1:12),2),
                                   analysis_var = c(rep("indicator1",12),rep("indicator2",12)),
                                   stat = c(NA, seq(0,1.05,by=.05), NA))

  expected_results_5_classes <- data.frame(group_var_value = paste("admin", 1:12),
                                           indicator1 = c("",
                                                          "1",
                                                          "2", "2", "2", "2", "2",
                                                          "3", "3", "3", "3", "3"),
                                           indicator2 = c("4", "4", "4", "4", "4",
                                                          "5", "5", "5", "5", "5",
                                                          "", ""))

  expected_results_6_classes <- data.frame(group_var_value = paste("admin", 1:12),
                                           indicator1 = c("",
                                                          "1",
                                                          "2", "2", "2", "2",
                                                          "3", "3", "3", "3",
                                                          "4", "4"),
                                           indicator2 = c("4",
                                                          "5", "5", "5", "5", "5",
                                                          "6", "6", "6", "6",
                                                          "", ""))

  expect_equal(create_table_for_map(results_test_table, number_classes = 6) |>
                 as.data.frame(),
               expected_results_6_classes)

  expect_equal(create_table_for_map(results_test_table, number_classes = 5) |>
                 as.data.frame(),
               expected_results_5_classes)

  renamed_results_test_table <- results_test_table
  names(renamed_results_test_table) <- c("Group_Var_Value", "Analysis_Var", "Stat")

  renamed_expected_results_5_classes <- expected_results_5_classes
  names(renamed_expected_results_5_classes) <- c("Group_Var_Value", "indicator1", "indicator2")

  expect_equal(create_table_for_map(renamed_results_test_table,
                                    group_var_value_column = "Group_Var_Value",
                                    analysis_var_column = "Analysis_Var",
                                    stat_column = "Stat",
                                    number_classes = 5) |>
                 as.data.frame(),
               renamed_expected_results_5_classes)


})
