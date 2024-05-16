test_that("that the results are correctly displayed", {

  no_nas_presentresults_resultstable <- presentresults_resultstable %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))

  all_vars_expected_output <- readRDS(testthat::test_path("fixtures/group_x_variable", "table_group_x_variable_export_fewsnet.RDS"))

  # removing non-core indicators
  with_fewsnet_matrix_output <- all_vars_expected_output
  with_fewsnet_matrix_output$ipc_table <- with_fewsnet_matrix_output$ipc_table %>%
    dplyr::select(-dplyr::contains(c("income_v2_sum", "expenditure_food")))

  # tests output with the fewsnet matrix without hdds
  actual_output <- create_ipc_table(
    results_table = no_nas_presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
    with_hdds = FALSE,
    with_fclc = TRUE,
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5")
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
    results_table = no_nas_presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
    suppressWarnings()
  expect_equal(
    no_fewsnet_phase_actual_output,
    no_fewsnet_phase_expected_output
  )

  # tests output with the fewsnet  with others variables (one cat, one number, one select multiple)  without hdds
  all_vars_actual_output <- create_ipc_table(
    results_table = no_nas_presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
    with_hdds = FALSE,
    with_fclc = TRUE,
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    other_variables = c("income_v2_sum", "expenditure_food")
  ) %>%
    suppressWarnings()
  expect_equal(
    all_vars_actual_output,
    all_vars_expected_output
  )

  # tests output with hdds
  with_hdds_expected_output <- readRDS(testthat::test_path("fixtures/create_ipc_table", "example_ipc_with_hdds.rds"))

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  no_na_rows <- with_hdds_results_list$results_table %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
  with_hdds_actual_output <-  create_ipc_table(
    results_table = no_na_rows,
    dataset = with_hdds_results_list$dataset,
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
    hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
  ) %>%
    suppressWarnings()

  skip_on_os(os ="mac")
  # comment the skip and to be run manually with devtools::test()
  expect_equal(with_hdds_actual_output, with_hdds_expected_output)

})

test_that("that if there is one missiong option, the variable still show in the table,
          for example, 0% of fcls_cat phase 1, and it does not appear in the results", {
            all_vars_expected_output <- readRDS(testthat::test_path("fixtures/group_x_variable", "table_group_x_variable_export_fewsnet.RDS"))

            all_vars_expected_output$ipc_table[["fcls_cat %/% phase_1 %/% prop_select_one"]] <- c("fcls_cat", "phase_1", "prop_select_one", rep(NA, 6))

            no_nas_presentresults_resultstable <- presentresults_resultstable %>%
              dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))

            # removing all phase_1 in fcls_cat
            presentresults_resultstable_trimed <- no_nas_presentresults_resultstable %>%
              dplyr::filter(!(analysis_var == "fcls_cat" & analysis_var_value == "phase_1"))
            # with fewsnet matrix
            actual_output <- create_ipc_table(
              results_table = presentresults_resultstable_trimed,
              dataset = presentresults_MSNA_template_data,
              cluster_name = "cluster_id",
              fcs_cat_var = "fcs_cat",
              fcs_cat_values = c("low", "medium", "high"),
              fcs_set = c(
                "fs_fcs_cereals_grains_roots_tubers",
                "fs_fcs_beans_nuts",
                "fs_fcs_dairy",
                "fs_fcs_meat_fish_eggs",
                "fs_fcs_vegetables_leaves",
                "fs_fcs_fruit",
                "fs_fcs_oil_fat_butter",
                "fs_fcs_sugar",
                "fs_fcs_condiment"
              ),
              hhs_cat_var = "hhs_cat",
              hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
              hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
              hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
              hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
              rcsi_cat_var = "rcsi_cat",
              rcsi_cat_values = c("low", "medium", "high"),
              rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
              lcsi_cat_var = "lcs_cat",
              lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
              with_hdds = FALSE,
              with_fclc = TRUE,
              fclc_matrix_var = "fcls_cat",
              fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
              fc_matrix_var = "fcm_cat",
              fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
              other_variables = c("income_v2_sum", "expenditure_food")
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
              fcs_set = c("fcs_cereal",
                          "fcs_pulses",
                          "fcs_milk",
                          "fcs_meat",
                          "fcs_veg",
                          "fcs_fruit",
                          "fcs_oil",
                          "fcs_sugar",
                          "fcs_spices"),
              hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
              hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
            ) %>%
              suppressWarnings()

            skip_on_os(os ="mac")
            # comment the skip and to be run manually with devtools::test()
            expect_equal(
              with_hdds_actual_output,
              with_hdds_expected_output
            )
          })

test_that("If at least one variable is not present, there should be an error", {
  expect_error(
    review_ipc_results(
      results_table = presentresults_resultstable,
      fcs_cat_var = "fcs_cat",
      fcs_cat_values = c("low", "medium", "high"),
      fcs_set = c(
        "fs_fcs_cereals_grains_roots_tubers",
        "fs_fcs_beans_nuts",
        "fs_fcs_dairy",
        "fs_fcs_meat_fish_eggs",
        "fs_fcs_vegetables_leaves",
        "fs_fcs_fruit",
        "fs_fcs_oil_fat_butter",
        "fs_fcs_sugar",
        "fs_fcs_condiment"
      ),
      hhs_cat_var = "hhs_cat",
      hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
      hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
      hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
      hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
      rcsi_cat_var = "rcsi_cat",
      rcsi_cat_values = c("low", "medium", "high"),
      rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
      lcsi_cat_var = "lcsi_cat",
      lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
      lcsi_set = c(
        "xx"
      ),
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: lcsi_cat, xx cannot be found in the results table"
  )

  expect_error(
    review_ipc_results(
      results_table = presentresults_resultstable,
      fcs_cat_var = "fcs_cat",
      fcs_cat_values = c("low", "medium", "high"),
      fcs_set = c(
        "fs_fcs_cereals_grains_roots_tubers",
        "fs_fcs_beans_nuts",
        "fs_fcs_dairy",
        "fs_fcs_meat_fish_eggs",
        "fs_fcs_vegetables_leaves",
        "fs_fcs_fruit",
        "fs_fcs_oil_fat_butter",
        "fs_fcs_sugar",
        "fs_fcs_condiment"
      ),
      hhs_cat_var = "hhs_cat",
      hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
      hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
      hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
      hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
      rcsi_cat_var = "rcsi_cat",
      rcsi_cat_values = c("low", "medium", "high"),
      rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
      lcsi_cat_var = "lcsi_cat",
      lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
      lcsi_set = c("liv_stress_lcsi_1", "liv_stress_lcsi_2"),
      with_fclc = TRUE,
      fclc_matrix_var = "fclc_phase",
      fc_matrix_var = "fc_phase",
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: fclc_phase, fc_phase, lcsi_cat cannot be found in the results table"
  )

  expect_error(
    review_ipc_results(
      results_table = presentresults_resultstable,
      fcs_cat_var = "fcs_cat",
      fcs_cat_values = c("low", "medium", "high"),
      fcs_set = c(
        "fs_fcs_cereals_grains_roots_tubers",
        "fs_fcs_beans_nuts",
        "fs_fcs_dairy",
        "fs_fcs_meat_fish_eggs",
        "fs_fcs_vegetables_leaves",
        "fs_fcs_fruit",
        "fs_fcs_oil_fat_butter",
        "fs_fcs_sugar",
        "fs_fcs_condiment"
      ),
      hhs_cat_var = "hhs_cat",
      hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
      hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
      hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
      hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
      rcsi_cat_var = "rcsi_cat",
      rcsi_cat_values = c("low", "medium", "high"),
      rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
      lcsi_cat_var = "lcsi_cat",
      lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
      other_variables = c("number_lunch", "expenses"),
      with_hdds = FALSE
    ) %>%
      suppressWarnings(),
    "Following variables: lcsi_cat, number_lunch, expenses cannot be found in the results table"
  )

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  expect_error(
    review_ipc_results(
      results_table = with_hdds_results_list$results_table,
      fcs_set = c("fcs_cereal",
                  "fcs_pulses",
                  "fcs_milk",
                  "fcs_meat",
                  "fcs_veg",
                  "fcs_fruit",
                  "fcs_oil",
                  "fcs_sugar",
                  "fcs_spices"),
      hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
      hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
      hdds_cat = "fsl_HDDS_cat",
      hdds_set = c("fsl_HDDS_cereals", "fsl_HDDS_tubers")
    ),
    "Following variables: fsl_HDDS_cat, fsl_HDDS_cereals, fsl_HDDS_tubers cannot be found in the results table"
  )
})

test_that("If one options present in the dataset is not part of the one in the table,
          there should be an error.", {
            expect_error(
              review_ipc_results(
                results_table = presentresults_resultstable,
                fcs_cat_var = "fcs_cat",
                fcs_set = c(
                  "fs_fcs_cereals_grains_roots_tubers",
                  "fs_fcs_beans_nuts",
                  "fs_fcs_dairy",
                  "fs_fcs_meat_fish_eggs",
                  "fs_fcs_vegetables_leaves",
                  "fs_fcs_fruit",
                  "fs_fcs_oil_fat_butter",
                  "fs_fcs_sugar",
                  "fs_fcs_condiment"
                ),
                hhs_cat_var = "hhs_cat",
                hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
                hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
                hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
                hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
                rcsi_cat_var = "rcsi_cat",
                rcsi_cat_values = c("low", "medium", "high"),
                rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
                lcsi_cat_var = "lcs_cat",
                lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
                with_fclc = FALSE,
                with_hdds = FALSE
              ) %>% suppressWarnings(),
              "fcs_cat:low, medium, high are in the results table as options but are not defined in the function arguments"
            )

            expect_error(
              review_ipc_results(
                results_table = presentresults_resultstable,
                fcs_cat_var = "fcs_cat",
                fcs_cat_values = c("low", "medium", "high"),
                fcs_set = c(
                  "fs_fcs_cereals_grains_roots_tubers",
                  "fs_fcs_beans_nuts",
                  "fs_fcs_dairy",
                  "fs_fcs_meat_fish_eggs",
                  "fs_fcs_vegetables_leaves",
                  "fs_fcs_fruit",
                  "fs_fcs_oil_fat_butter",
                  "fs_fcs_sugar",
                  "fs_fcs_condiment"
                ),
                hhs_cat_var = "hhs_cat",
                hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
                hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
                hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
                hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
                rcsi_cat_var = "rcsi_cat",
                rcsi_cat_values = c("low", "medium", "high"),
                rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
                lcsi_cat_var = "lcs_cat",
                lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
                with_hdds = FALSE,
                with_fclc = TRUE,
                fclc_matrix_var = "fcls_cat",
                fc_matrix_var = "fcm_cat",
                fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5")
              ) %>% suppressWarnings(),
              "fcls_cat:phase_1, phase_2, phase_3, phase_4, phase_5 are in the results table as options but are not defined in the function arguments"
            )

            with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))
            no_na_rows <- with_hdds_results_list$results_table %>%
              dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
            expect_error(
              review_ipc_results(
                results_table = no_na_rows,
                fcs_set = c("fcs_cereal",
                            "fcs_pulses",
                            "fcs_milk",
                            "fcs_meat",
                            "fcs_veg",
                            "fcs_fruit",
                            "fcs_oil",
                            "fcs_sugar",
                            "fcs_spices"),
                hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
                hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
                hdds_cat_values = c("Haut", "Moyen", "Bas")
              ) %>%
                suppressWarnings(),
              "fsl_hdds_cat:High, Low, Medium are in the results table as options but are not defined in the function arguments"
            )
          })

test_that("if number of expected values is different it will show a warning", {
  no_nas_presentresults_resultstable <- presentresults_resultstable %>%
    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
  # Adding None to fclc_matrix_values
  review_ipc_results(
    results_table = no_nas_presentresults_resultstable,
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
    with_hdds = FALSE,
    with_fclc = TRUE,
    fclc_matrix_var = "fcls_cat",
    fclc_matrix_values = c("None", "phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
    fc_matrix_var = "fcm_cat",
    fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5")
  ) %>%
    expect_warning("Expecting 5 of values in fclc_matrix_values but got 6 unique values.")

  # removing high in fcs.
  no_high_results <- no_nas_presentresults_resultstable %>%
    dplyr::filter(!(analysis_var_value == "high" & analysis_var == "fcs_cat"))
  review_ipc_results(
    results_table = no_high_results,
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
  review_ipc_results(
    results_table = no_nas_presentresults_resultstable,
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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

  review_ipc_results(
    results_table = no_na_rows,
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
    hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
    hdds_cat_values = c("Medium", "Low")
  )  %>%
    expect_warning("Expecting 3 of values in hdds_cat_values but got 2 unique values.")

})

test_that("When the category of variable is provided in a set, it throws an error", {
  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fcs_cat",
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
  ),
  "fcs_cat is in the fcs_set, it should only contains the fcs initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("hhs_cat", "fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
  ),
  "hhs_cat is in the hhs_cat_yesno_set, it should only contains the hhs initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("hhs_cat", "fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
  ),
  "hhs_cat is in the hhs_cat_freq_set, it should only contains the hhs initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rcsi_cat", "rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
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
  ),
  "rcsi_cat is in the rcsi_set, it should only contains the rcsi initial variables.")

  expect_error(create_ipc_table(
    results_table = presentresults_resultstable,
    dataset = presentresults_MSNA_template_data,
    cluster_name = "cluster_id",
    fcs_cat_var = "fcs_cat",
    fcs_cat_values = c("low", "medium", "high"),
    fcs_set = c(
      "fs_fcs_cereals_grains_roots_tubers",
      "fs_fcs_beans_nuts",
      "fs_fcs_dairy",
      "fs_fcs_meat_fish_eggs",
      "fs_fcs_vegetables_leaves",
      "fs_fcs_fruit",
      "fs_fcs_oil_fat_butter",
      "fs_fcs_sugar",
      "fs_fcs_condiment"
    ),
    hhs_cat_var = "hhs_cat",
    hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
    hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
    hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
    hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
    rcsi_cat_var = "rcsi_cat",
    rcsi_cat_values = c("low", "medium", "high"),
    rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
    lcsi_cat_var = "lcs_cat",
    lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
    lcsi_set = c(
      "lcs_cat",
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
  ),
  "lcs_cat is in the lcsi_set, it should only contains the lcsi initial variables.")

  with_hdds_results_list <- readRDS(testthat::test_path("fixtures/create_ipc_table", "ipc_table_results_with_hdds.RDS"))

  no_na_rows <- with_hdds_results_list$results_table %>%

    dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
  expect_error(create_ipc_table(
    results_table = no_na_rows,
    dataset = with_hdds_results_list$dataset,
    fcs_set = c("fcs_cereal",
                "fcs_pulses",
                "fcs_milk",
                "fcs_meat",
                "fcs_veg",
                "fcs_fruit",
                "fcs_oil",
                "fcs_sugar",
                "fcs_spices"),
    hhs_cat_yesno_set = c("hhs_1", "hhs_3", "hhs_5"),
    hhs_cat_freq_set = c("hhs_2", "hhs_4", "hhs_6"),
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
    hdds_set = c(
      "fsl_hdds_cat",
      "fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
      "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
      "fsl_hdds_sugar", "fsl_hdds_condiments"
    )),
    "fsl_hdds_cat is in the hdds_set, it should only contains the hdds initial variables.")
})
