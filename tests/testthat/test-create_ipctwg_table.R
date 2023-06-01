test_that("that the results are correctly displayed", {
  all_vars_expected_output <- readRDS(testthat::test_path("fixtures", "export_fewsnet.RDS"))

  # removing non-core indicators
  with_fewsnet_matrix_output <- all_vars_expected_output %>%
    dplyr::select(-dplyr::contains(c("income_v2_sum", "expenditure_food")))

  # with fewsnet matrix
  actual_output <- create_ipctwg_table(
    .results = presentresults_resultstable,
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
    )
  ) %>%
    suppressWarnings()

  expect_equal(
    actual_output,
    with_fewsnet_matrix_output
  )

  # without fewsnet matrix phases
  no_fewsnet_phase_expected_output <- with_fewsnet_matrix_output %>%
    dplyr::select(-dplyr::contains(c("fcls_cat", "fcm_cat")))

  no_fewsnet_phase_actual_output <- create_ipctwg_table(
    .results = presentresults_resultstable,
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
    )
  ) %>%
    suppressWarnings()
  expect_equal(no_fewsnet_phase_actual_output, no_fewsnet_phase_expected_output)

  # with adding others variables (one cat, one number, one select multiple)
  all_vars_actual_output <- create_ipctwg_table(
    .results = presentresults_resultstable,
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
    other_variables = c("income_v2_sum", "expenditure_food")
  ) %>%
    suppressWarnings()
  expect_equal(all_vars_actual_output, all_vars_expected_output)
})

test_that("that if there is one missiong option, the variable still show in the table,
          for example, 0% of fcls_cat phase 1, and it does not appear in the results", {
  all_vars_expected_output <- readRDS(testthat::test_path("fixtures", "export_fewsnet.RDS"))

  # removing non-core indicators
  with_fewsnet_matrix_output <- all_vars_expected_output %>%
    dplyr::select(-dplyr::contains(c("income_v2_sum", "expenditure_food")))

  with_fewsnet_matrix_output[["fcls_cat ~/~ phase_1 ~/~ prop_select_one"]] <- c("fcls_cat", "phase_1", "prop_select_one", rep(NA, 6))

  # removing all phase_1 in fcls_cat
  presentresults_resultstable_trimed <- presentresults_resultstable %>%
    dplyr::filter(!(analysis_var == "fcls_cat" & analysis_var_value == "phase_1"))
  # with fewsnet matrix
  actual_output <- create_ipctwg_table(
    .results = presentresults_resultstable_trimed,
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
    )
  ) %>%
    suppressWarnings()

  expect_equal(
    actual_output,
    with_fewsnet_matrix_output
  )
})

test_that("If at least one variable is not present, there should be an error", {
  expect_error(
    check_ipctwg_results(
      .results = presentresults_resultstable,
      lcsi_set = "xx"
    ),
    "Following variables: lcsi_cat, hhs_cat_ipc, xx cannot be found in the results table"
  )

  expect_error(
    check_ipctwg_results(
      .results = presentresults_resultstable,
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      with_fclc = T
    ),
    "Following variables: fclc_phase, fc_phase, lcsi_cat, hhs_cat_ipc cannot be found in the results table"
  )

  expect_error(
    check_ipctwg_results(
      .results = presentresults_resultstable,
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      other_variables = c("number_lunch", "expenses")
    ),
    "Following variables: lcsi_cat, hhs_cat_ipc, number_lunch, expenses cannot be found in the results table"
  )
})

test_that("If one options present in the dataset is not part of the one in the table,
          there should be an error.", {
  expect_error(
    check_ipctwg_results(
      .results = presentresults_resultstable,
      lcsi_cat_var = "lcs_cat",
      hhs_cat_var = "hhs_cat",
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      with_fclc = F
    ) %>% suppressWarnings(),
    "fcs_cat:low, medium, high are in the results table as options but are not defined in the function arguments"
  )

  expect_error(
    check_ipctwg_results(
      .results = presentresults_resultstable,
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
      rcsi_cat_values = c("low", "medium", "high")
    ) %>% suppressWarnings(),
    "fcls_cat:phase_1, phase_2, phase_3, phase_4, phase_5 are in the results table as options but are not defined in the function arguments"
  )
})
