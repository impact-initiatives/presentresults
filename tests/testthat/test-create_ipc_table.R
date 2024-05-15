test_that("that the results are correctly displayed", {
  all_vars_expected_output <- readRDS(testthat::test_path("fixtures/create_X_group_x_variable", "table_group_x_variable_export_fewsnet.RDS"))

  # removing non-core indicators
  with_fewsnet_matrix_output <- all_vars_expected_output
  with_fewsnet_matrix_output$ipc_table <- with_fewsnet_matrix_output$ipc_table %>%
    dplyr::select(-dplyr::contains(c("income_v2_sum", "expenditure_food")))

  # tests output with the fewsnet matrix without hdds
  actual_output <- create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    with_fclc = T,
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
    with_hdds = F
  ) %>%
    suppressWarnings()

  expect_equal(
    actual_output,
    with_fewsnet_matrix_output
  )

  # tests output without the fewsnet matrix without hdds
  no_fewsnet_phase_expected_output <- with_fewsnet_matrix_output
  no_fewsnet_phase_expected_output$ipc_table <- with_fewsnet_matrix_output$ipc_table %>%
    dplyr::select(-dplyr::contains(c("fcls_cat", "fcm_cat")))

  no_fewsnet_phase_actual_output <- create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
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
    with_hdds = F
  ) %>%
    suppressWarnings()
  expect_equal(
    no_fewsnet_phase_actual_output,
    no_fewsnet_phase_expected_output
  )

  # tests output with the fewsnet  with others variables (one cat, one number, one select multiple)  without hdds
  all_vars_actual_output <- create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    with_fclc = T,
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
    other_variables = c("income_v2_sum", "expenditure_food"),
    with_hdds = F
  ) %>%
    suppressWarnings()
  expect_equal(
    all_vars_actual_output,
    all_vars_expected_output
  )

  # tests output without with hdds
  with_hdds_expected_output <- readRDS(testthat::test_path("fixtures/create_ipc_table", "example_ipc_with_hdds.rds"))

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  no_na_rows <- with_hdds_results_list$results_table %>% dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
  with_hdds_actual_output <-  create_ipc_table(
    results_table = no_na_rows,
    dataset = with_hdds_results_list$dataset,
    fcs_cat_var = "fsl_fcs_cat",
    rcsi_cat_var = "fsl_rcsi_cat",
    lcsi_cat_var = "fsl_lcsi_cat",
    hhs_cat_var = "fsl_hhs_cat_ipc",
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    rcsi_set = c("rcsi_lessquality",
                 "rcsi_borrow",
                 "rcsi_mealsize",
                 "rcsi_mealadult",
                 "rcsi_mealnb"),
    lcsi_set = c(
      "lcs_stress1",
      "lcs_stress2",
      "lcs_stress3",
      "lcs_stress4",
      "lcs_crisis5",
      "lcs_crisis6",
      "lcs_crisis7",
      "lcs_emergency8",
      "lcs_emergency9",
      "lcs_emergency10"
    ),
    lcsi_value_set = c("yes",
                       "no_nothungry",
                       "no_exhausted",
                       "not_applicable"),
    hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe")
  ) %>%
    suppressWarnings()

  expect_equal(with_hdds_actual_output, with_hdds_expected_output)

})

test_that("that if there is one missiong option, the variable still show in the table,
          for example, 0% of fcls_cat phase 1, and it does not appear in the results", {
  all_vars_expected_output <- readRDS(testthat::test_path("fixtures/create_X_group_x_variable", "table_group_x_variable_export_fewsnet.RDS"))

  all_vars_expected_output$ipc_table[["fcls_cat %/% phase_1 %/% prop_select_one"]] <- c("fcls_cat", "phase_1", "prop_select_one", rep(NA, 6))

  # removing all phase_1 in fcls_cat
  presentresults_resultstable_trimed <- presentresults_resultstable %>%
    dplyr::filter(!(analysis_var == "fcls_cat" & analysis_var_value == "phase_1"))
  # with fewsnet matrix
  actual_output <- create_ipc_table(
    results_table = presentresults_resultstable_trimed,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    with_fclc = T,
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
    other_variables = c("income_v2_sum", "expenditure_food"),
    with_hdds = FALSE
  ) %>%
    suppressWarnings()

  expect_equal(
    actual_output,
    all_vars_expected_output
  )

  # test with hdds cat missing
  with_hdds_expected_output <- readRDS(testthat::test_path("fixtures/create_ipc_table", "example_ipc_with_hdds.rds"))
  with_hdds_expected_output$ipc_table[["fsl_hdds_cat %/% High %/% prop_select_one"]] <- c("fsl_hdds_cat", "High", "prop_select_one", NA)

  # removing all High in fsl_hdds_cat
  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  trimmed_hdds_results <- with_hdds_results_list$results_table %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)),
                  !(analysis_var == "fsl_hdds_cat" & analysis_var_value == "High"))

  with_hdds_actual_output <- create_ipc_table(
    results_table = trimmed_hdds_results,
    dataset = with_hdds_results_list$dataset,
    with_fclc = FALSE,
    fcs_cat_var = "fsl_fcs_cat",
    rcsi_cat_var = "fsl_rcsi_cat",
    lcsi_cat_var = "fsl_lcsi_cat",
    hhs_cat_var = "fsl_hhs_cat_ipc",
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    rcsi_set = c("rcsi_lessquality",
                 "rcsi_borrow",
                 "rcsi_mealsize",
                 "rcsi_mealadult",
                 "rcsi_mealnb"),
    lcsi_set = c(
      "lcs_stress1",
      "lcs_stress2",
      "lcs_stress3",
      "lcs_stress4",
      "lcs_crisis5",
      "lcs_crisis6",
      "lcs_crisis7",
      "lcs_emergency8",
      "lcs_emergency9",
      "lcs_emergency10"
    ),
    lcsi_value_set = c("yes",
                       "no_nothungry",
                       "no_exhausted",
                       "not_applicable"),
    hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe")
  ) %>%
    suppressWarnings()

  expect_equal(
    with_hdds_actual_output,
    with_hdds_expected_output
  )
})

test_that("If at least one variable is not present, there should be an error", {
  expect_error(
    check_ipc_results(
      results_table = presentresults_resultstable,
      lcsi_set = "xx",
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: lcsi_cat, hhs_cat_ipc, xx cannot be found in the results table"
  )

  expect_error(
    check_ipc_results(
      results_table = presentresults_resultstable,
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      with_fclc = TRUE,
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: fclc_phase, fc_phase, lcsi_cat, hhs_cat_ipc cannot be found in the results table"
  )

  expect_error(
    check_ipc_results(
      results_table = presentresults_resultstable,
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      other_variables = c("number_lunch", "expenses"),
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: lcsi_cat, hhs_cat_ipc, number_lunch, expenses cannot be found in the results table"
  )

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  expect_error(
    check_ipc_results(
      results_table = with_hdds_results_list$results_table,
      fcs_cat_var = "fsl_fcs_cat",
      rcsi_cat_var = "fsl_rcsi_cat",
      lcsi_cat_var = "fsl_lcsi_cat",
      hhs_cat_var = "fsl_hhs_cat_ipc",
      fcs_set = c("fcs_cereal",
                  "fcs_pulses",
                  "fcs_milk",
                  "fcs_meat",
                  "fcs_veg",
                  "fcs_fruit",
                  "fcs_oil",
                  "fcs_sugar",
                  "fcs_spices"),
      rcsi_set = c("rcsi_lessquality",
                   "rcsi_borrow",
                   "rcsi_mealsize",
                   "rcsi_mealadult",
                   "rcsi_mealnb"),
      lcsi_set = c(
        "lcs_stress1",
        "lcs_stress2",
        "lcs_stress3",
        "lcs_stress4",
        "lcs_crisis5",
        "lcs_crisis6",
        "lcs_crisis7",
        "lcs_emergency8",
        "lcs_emergency9",
        "lcs_emergency10"
      ),
      lcsi_value_set = c("yes",
                         "no_nothungry",
                         "no_exhausted",
                         "not_applicable"),
      hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
      hdds_cat = "fsl_HDDS_cat",
      hdds_set = c("fsl_HDDS_cereals", "fsl_HDDS_tubers")
    ),
    "Following variables: fsl_HDDS_cat, fsl_HDDS_cereals, fsl_HDDS_tubers cannot be found in the results table"
  )
})

test_that("If one options present in the dataset is not part of the one in the table,
          there should be an error.", {
  expect_error(
    check_ipc_results(
      results_table = presentresults_resultstable,
      lcsi_cat_var = "lcs_cat",
      hhs_cat_var = "hhs_cat",
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      with_fclc = FALSE,
      with_hdds = FALSE
    ) %>% suppressWarnings(),
    "fcs_cat:low, medium, high are in the results table as options but are not defined in the function arguments"
  )

  expect_error(
    check_ipc_results(
      results_table = presentresults_resultstable,
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
      fclc_matrix_var = "fcls_cat",
      fc_matrix_var = "fcm_cat",
      with_fclc = T,
      lcsi_cat_var = "lcs_cat",
      lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
      hhs_cat_var = "hhs_cat",
      hhs_cat_values = c("none", "slight, moderate, severe, very_severe"),
      rcsi_cat_values = c("low", "medium", "high"),
      with_hdds = FALSE
    ) %>% suppressWarnings(),
    "fcls_cat:phase_1, phase_2, phase_3, phase_4, phase_5 are in the results table as options but are not defined in the function arguments"
  )

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))
  no_na_rows <- with_hdds_results_list$results_table %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
  expect_error(
    check_ipc_results(
      results_table = no_na_rows,
      fcs_cat_var = "fsl_fcs_cat",
      rcsi_cat_var = "fsl_rcsi_cat",
      lcsi_cat_var = "fsl_lcsi_cat",
      hhs_cat_var = "fsl_hhs_cat_ipc",
      fcs_set = c("fcs_cereal",
                  "fcs_pulses",
                  "fcs_milk",
                  "fcs_meat",
                  "fcs_veg",
                  "fcs_fruit",
                  "fcs_oil",
                  "fcs_sugar",
                  "fcs_spices"),
      rcsi_set = c("rcsi_lessquality",
                   "rcsi_borrow",
                   "rcsi_mealsize",
                   "rcsi_mealadult",
                   "rcsi_mealnb"),
      lcsi_set = c(
        "lcs_stress1",
        "lcs_stress2",
        "lcs_stress3",
        "lcs_stress4",
        "lcs_crisis5",
        "lcs_crisis6",
        "lcs_crisis7",
        "lcs_emergency8",
        "lcs_emergency9",
        "lcs_emergency10"
      ),
      lcsi_value_set = c("yes",
                         "no_nothungry",
                         "no_exhausted",
                         "not_applicable"),
      hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
      hdds_cat_values = c("Haut", "Moyen", "Bas")
    ) %>%
      suppressWarnings(),
    "fsl_hdds_cat:High, Low, Medium are in the results table as options but are not defined in the function arguments"
  )
})

test_that("if number of expected values is different it will show a warning", {
  # Adding None to fclc_matrix_values
  check_ipc_results(
    results_table = presentresults_resultstable,
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("None", "phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
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
    with_hdds = FALSE
  ) %>%
    expect_warning("Expecting 5 of values in fclc_matrix_values but got 6 unique values.")

  # removing high in fcs.
  no_high_results <- presentresults_resultstable %>%
    dplyr::filter(!(analysis_var_value == "high" & analysis_var == "fcs_cat"))
  check_ipc_results(
    results_table = no_high_results,
    fcs_cat_values = c("low", "medium"),
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
    with_hdds = FALSE
  ) %>%
    expect_warning("Expecting 3 of values in fcs_cat_values but got 2 unique values.")

  # removing some LCSI variables
  check_ipc_results(
    results_table = presentresults_resultstable,
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
      "liv_emerg_lcsi_1"
    ),
    with_hdds = FALSE
  ) %>%
    expect_warning("Expecting 10 of values in lcsi_set but got 8 unique values.")


  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))
  no_na_rows <- with_hdds_results_list$results_table %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)),
                  !(analysis_var == "fsl_hdds_cat" & analysis_var_value == "High"))

  check_ipc_results(
    results_table = no_na_rows,
    fcs_cat_var = "fsl_fcs_cat",
    rcsi_cat_var = "fsl_rcsi_cat",
    lcsi_cat_var = "fsl_lcsi_cat",
    hhs_cat_var = "fsl_hhs_cat_ipc",
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    rcsi_set = c("rcsi_lessquality",
                 "rcsi_borrow",
                 "rcsi_mealsize",
                 "rcsi_mealadult",
                 "rcsi_mealnb"),
    lcsi_set = c(
      "lcs_stress1",
      "lcs_stress2",
      "lcs_stress3",
      "lcs_stress4",
      "lcs_crisis5",
      "lcs_crisis6",
      "lcs_crisis7",
      "lcs_emergency8",
      "lcs_emergency9",
      "lcs_emergency10"
    ),
    lcsi_value_set = c("yes",
                       "no_nothungry",
                       "no_exhausted",
                       "not_applicable"),
    hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
    hdds_cat_values = c("Medium", "Low")
  )  %>%
    expect_warning("Expecting 3 of values in hdds_cat_values but got 2 unique values.")

})

test_that("When the category of variable is provided in a set, it throws an error", {
  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c("fcs_cat",
                "fs_fcs_cereals_grains_roots_tubers",
                "fs_fcs_beans_nuts",
                "fs_fcs_dairy",
                "fs_fcs_meat_fish_eggs",
                "fs_fcs_vegetables_leaves",
                "fs_fcs_fruit",
                "fs_fcs_oil_fat_butter",
                "fs_fcs_sugar",
                "fs_fcs_condiment"),
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
    with_hdds = F
  ),
  "fcs_cat is in the fcs_set, it should only contains the fcs initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rcsi_cat","rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult",
                 "rCSIMealNb"),
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
    with_hdds = F
  ),
  "rcsi_cat is in the rcsi_set, it should only contains the rcsi initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_values = c("low", "medium", "high"),
    rcsi_cat_values =  c("low", "medium", "high"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    lcsi_set = c("lcs_cat",
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
    with_hdds = F
  ),
  "lcs_cat is in the lcsi_set, it should only contains the lcsi initial variables.")

    expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_values = c("low", "medium", "high"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    lcsi_set = c("liv_stress_lcsi_1",
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
    hdds_set = c("fsl_hdds_cat","fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
                 "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
                 "fsl_hdds_sugar", "fsl_hdds_condiments")
  ),
  "fsl_hdds_cat is in the hdds_set, it should only contains the hdds initial variables.")

    ### to add for hhs?

})

