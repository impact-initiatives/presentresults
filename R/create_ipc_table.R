#' Helper to check the results for the IPC table
#'
#' Helper to make sure the results contains all the IPC information
#'
#' @param results_table results table with analysis key
#' @param analysis_key String with the name of the analysis key. Default is "analysis_key"
#' @param fcs_cat_var String with the name of the Food Consumption Score. Default is "fsl_fcs_cat"
#' @param fcs_cat_values String with the options of the Food Consumption Score. Default is
#' c("Poor", "Borderline", "Acceptable")
#' @param fcs_set String for the Food Consumption Score questions set. Default is
#' c("fcs_cereal", "fcs_pulses", "fcs_milk", "fcs_meat", "fcs_veg", "fcs_fruit", "fcs_oil",
#' "fcs_sugar", "fcs_spices")
#' @param rcsi_cat_var String with the name of the reduced Coping Strategy Index. Default is "fsl_rcsi_cat"
#' @param rcsi_cat_values String with the options of the reduced Coping Strategy Index. Default is
#' c("No to Low", "Medium", "High")
#' @param rcsi_set String for the reduced Coping Strategy Index questions set. Default is
#' c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb")
#' @param lcsi_cat_var String with the name of the Livelihood Coping Strategy Index. Default is
#' "fsl_lcsi_cat"
#' @param lcsi_cat_values String with the options of the Livelihood Coping Strategy Index. Default
#' is c("None", "Stress", "Crisis", "Emergency")
#' @param lcsi_set String for the Livelihood Coping Strategy Index questions set. Default is
#' c("fsl_lcsi_stress1", "fsl_lcsi_stress2", "fsl_lcsi_stress3", "fsl_lcsi_stress4",
#' "fsl_lcsi_crisis1", "fsl_lcsi_crisis2", "fsl_lcsi_crisis3", "fsl_lcsi_emergency1",
#' "fsl_lcsi_emergency2", "fsl_lcsi_emergency3")
#' @param lcsi_value_set String for the values of the Livelihood Coping Strategy Index questions
#' set. Default is c("yes", "no_had_no_need", "no_exhausted", "not_applicable")
#' @param hhs_cat_var String with the name of the Household Hunger Scale. Default is "fsl_hhs_cat_ipc"
#' @param hhs_cat_values String with the options of the Household Hunger Scale. Default is
#' c("None", "No or Little", "Moderate", "Severe", "Very Severe")
#' @param hhs_cat_yesno_set String for the Household Hunger Scale yes-no questions set. Default is
#' c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight")
#' @param hhs_value_yesno_set String for the values of the Household Hunger Scale yes-no questions
#' set. Default is c("yes", "no")
#' @param hhs_cat_freq_set String for the Household Hunger Scale frequency questions set. Default is
#' c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq")
#' @param hhs_value_freq_set String for the values of the Household Hunger Scale frequency questions
#' set. Default is c("rarely", "sometimes", "often")
#' @param with_hdds TRUE or FALSE, whether to include the FCLC and FC values.
#' @param hdds_cat String with the name of the Household Dietary Diversity Score. Default is "fsl_hdds_cat"
#' @param hdds_cat_values String with the options of the Household Dietary Diversity Score. Default is
#' c("Low", "Medium", "High")
#' @param hdds_set String for the Household Dietary Diversity Score. Default is
#' c("fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
#' "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
#' "fsl_hdds_sugar", "fsl_hdds_condiments")
#' @param hdds_value_set String for the values of the Household Dietary Diversity Score questions
#' set. Default is c("yes", "no")
#' @param with_fclc TRUE or FALSE, whether to include the FCLC and FC values.
#' @param fclc_matrix_var String with the name of the food consumption livelihood matrix from FEWSNET.
#' Default is "fclcm_phase"
#' @param fclc_matrix_values String with the options of the food consumption livelihood matrix
#' Default is c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC")
#' @param fc_matrix_var String with the name of the food consumption matrix from FEWSNET.
#' Default is "fsl_fc_phase"
#' @param fc_matrix_values String with the options of the food consumption matrix. Default is
#'  c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC")
#' Default is set to FALSE.
#' @param other_variables String for the names of other variables to include. Default is NULL
#' @param stat_col String for the name of the column with the mean or the proportion. Default is
#' "stat"
#' @param proportion_name String how a proportion is called in the analysis key. Default is
#' "prop_select_one"
#' @param mean_name String how a mean is called in the analysis key. Default is "mean"
#'
#' @return a list for 3 objects:
#' - dictionary: list of all the variables and their values.
#' - ipc_key_table: key_table from the analysis_key.
#' - value_checked_ipc_key_table: list of key_table where all values are checked for each
#' variables.
#'
#' @keywords internal
#' @export
#'
#' @examples
#' no_nas_presentresults_resultstable <- presentresults_resultstable %>%
#'   dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
#'
#' review_ipc_results(
#'   results_table = no_nas_presentresults_resultstable,
#'   fcs_cat_var = "fcs_cat",
#'   fcs_cat_values = c("low", "medium", "high"),
#'   fcs_set = c(
#'     "fs_fcs_cereals_grains_roots_tubers",
#'     "fs_fcs_beans_nuts",
#'     "fs_fcs_dairy",
#'     "fs_fcs_meat_fish_eggs",
#'     "fs_fcs_vegetables_leaves",
#'     "fs_fcs_fruit",
#'     "fs_fcs_oil_fat_butter",
#'     "fs_fcs_sugar",
#'     "fs_fcs_condiment"
#'   ),
#'   hhs_cat_var = "hhs_cat",
#'   hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
#'   hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
#'   hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
#'   hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
#'   rcsi_cat_var = "rcsi_cat",
#'   rcsi_cat_values = c("low", "medium", "high"),
#'   rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
#'   lcsi_cat_var = "lcs_cat",
#'   lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
#'   lcsi_set = c(
#'     "liv_stress_lcsi_1",
#'     "liv_stress_lcsi_2",
#'     "liv_stress_lcsi_3",
#'     "liv_stress_lcsi_4",
#'     "liv_crisis_lcsi_1",
#'     "liv_crisis_lcsi_2",
#'     "liv_crisis_lcsi_3",
#'     "liv_emerg_lcsi_1",
#'     "liv_emerg_lcsi_2",
#'     "liv_emerg_lcsi_3"
#'   ),
#'   with_hdds = FALSE,
#'   with_fclc = TRUE,
#'   fclc_matrix_var = "fcls_cat",
#'   fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
#'   fc_matrix_var = "fcm_cat",
#'   fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5")
#' )
review_ipc_results <- function(results_table,
                               analysis_key = "analysis_key",
                               fcs_cat_var = "fsl_fcs_cat",
                               fcs_cat_values = c("Poor", "Borderline", "Acceptable"),
                               fcs_set = c(
                                 "fcs_cereal",
                                 "fcs_pulses",
                                 "fcs_milk",
                                 "fcs_meat",
                                 "fcs_veg",
                                 "fcs_fruit",
                                 "fcs_oil",
                                 "fcs_sugar",
                                 "fcs_spices"
                               ),
                               hhs_cat_var = "fsl_hhs_cat_ipc",
                               hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
                               hhs_cat_yesno_set = c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight"),
                               hhs_value_yesno_set = c("yes", "no"),
                               hhs_cat_freq_set = c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq"),
                               hhs_value_freq_set = c("rarely", "sometimes", "often"),
                               rcsi_cat_var = "fsl_rcsi_cat",
                               rcsi_cat_values = c("No to Low", "Medium", "High"),
                               rcsi_set = c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb"),
                               lcsi_cat_var = "fsl_lcsi_cat",
                               lcsi_cat_values = c("None", "Stress", "Crisis", "Emergency"),
                               lcsi_set = c(
                                 "fsl_lcsi_stress1",
                                 "fsl_lcsi_stress2",
                                 "fsl_lcsi_stress3",
                                 "fsl_lcsi_stress4",
                                 "fsl_lcsi_crisis1",
                                 "fsl_lcsi_crisis2",
                                 "fsl_lcsi_crisis3",
                                 "fsl_lcsi_emergency1",
                                 "fsl_lcsi_emergency2",
                                 "fsl_lcsi_emergency3"
                               ),
                               lcsi_value_set = c("yes", "no_had_no_need", "no_exhausted", "not_applicable"),
                               with_hdds = TRUE,
                               hdds_cat = "fsl_hdds_cat",
                               hdds_cat_values = c("Low", "Medium", "High"),
                               hdds_set = c(
                                 "fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
                                 "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
                                 "fsl_hdds_sugar", "fsl_hdds_condiments"
                               ),
                               hdds_value_set = c("yes", "no"),
                               with_fclc = FALSE,
                               fclc_matrix_var = "fclcm_phase",
                               fclc_matrix_values = c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC"),
                               fc_matrix_var = "fsl_fc_phase",
                               fc_matrix_values = c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC"),
                               other_variables = NULL,
                               stat_col = "stat",
                               proportion_name = "prop_select_one",
                               mean_name = "mean") {
  # verify number of values.
  verify_numbers_values("fcs_cat_values", fcs_cat_values, 3)
  verify_numbers_values("hhs_cat_values", hhs_cat_values, 5)
  verify_numbers_values("rcsi_cat_values", rcsi_cat_values, 3)
  verify_numbers_values("lcsi_cat_values", lcsi_cat_values, 4)
  verify_numbers_values("hhs_cat_yesno_set", hhs_cat_yesno_set, 3)
  verify_numbers_values("hhs_value_yesno_set", hhs_value_yesno_set, 2)
  verify_numbers_values("hhs_cat_freq_set", hhs_cat_freq_set, 3)
  verify_numbers_values("hhs_value_freq_set", hhs_value_freq_set, 3)
  verify_numbers_values("lcsi_set", lcsi_set, 10)
  verify_numbers_values("lcsi_value_set", lcsi_value_set, 4)

  # create a dictionary for each set
  dictionary <- list(
    fcs = list(var_name = fcs_cat_var, values_set = fcs_cat_values, analysis_type = proportion_name),
    hhs = list(var_name = hhs_cat_var, values_set = hhs_cat_values, analysis_type = proportion_name),
    rcsi = list(var_name = rcsi_cat_var, values_set = rcsi_cat_values, analysis_type = proportion_name),
    lcsi = list(var_name = lcsi_cat_var, values_set = lcsi_cat_values, analysis_type = proportion_name),
    fcs_set_mean = list(var_name = fcs_set, values_set = NA, analysis_type = mean_name),
    hhs_yesno_set_prop = list(var_name = hhs_cat_yesno_set, values_set = hhs_value_yesno_set, analysis_type = proportion_name),
    hhs_freq_set_prop = list(var_name = hhs_cat_freq_set, values_set = hhs_value_freq_set, analysis_type = proportion_name),
    rcsi_set_mean = list(var_name = rcsi_set, values_set = NA, analysis_type = mean_name),
    rcsi_set_prop = list(var_name = rcsi_set, values_set = c(0:7), analysis_type = proportion_name),
    lcsi_set_prop = list(var_name = lcsi_set, values_set = lcsi_value_set, analysis_type = proportion_name)
  )
  if (with_hdds) {
    verify_numbers_values("hdds_cat_values", hdds_cat_values, 3)

    hdds <- list(hdds = list(var_name = hdds_cat, values_set = hdds_cat_values, analysis_type = proportion_name))
    hdds_set_prop <- list(hdds_set_prop = list(var_name = hdds_set, values_set = hdds_value_set, analysis_type = proportion_name))

    dictionary <- append(dictionary, hdds, after = 4)
    dictionary <- append(dictionary, hdds_set_prop)
  }

  if (with_fclc) {
    verify_numbers_values("fclc_matrix_values", fclc_matrix_values, 5)
    verify_numbers_values("fc_matrix_values", fc_matrix_values, 5)

    fclc_dictionary <- list(
      fclc_matrix = list(var_name = fclc_matrix_var, values_set = fclc_matrix_values, analysis_type = proportion_name),
      fc_matrix = list(var_name = fc_matrix_var, values_set = fc_matrix_values, analysis_type = proportion_name)
    )
    dictionary <- append(fclc_dictionary, dictionary)
  }

  # check all the var exists
  var_names_to_check <- dictionary %>%
    purrr::map(purrr::pluck("var_name")) %>%
    purrr::flatten() %>%
    do.call(c, .) %>%
    c(other_variables)

  var_names_check <- verify_grep_AinB(
    .A = var_names_to_check,
    .B = results_table[[analysis_key]]
  )

  if (any(!var_names_check)) {
    msg <- var_names_to_check[!var_names_check] %>%
      glue::glue_collapse(sep = ", ") %>%
      glue::glue("Following variables: ", ., " cannot be found in the results table")
    stop(msg)
  }

  # check all the values in the results are in the choices arguments from the function
  ipc_key_table <- analysistools::create_analysis_key_table(results_table = results_table, analysis_key = analysis_key) %>%
    analysistools::unite_variables()

  # check all the values in the results are in the choices arguments from the function
  value_checked_ipc_key_table <- dictionary %>%
    purrr::map(function(xx) {
      filtered_table <- ipc_key_table %>%
        dplyr::filter(
          analysis_var %in% xx[["var_name"]],
          analysis_type == xx[["analysis_type"]]
        )

      if (xx[["analysis_type"]] == mean_name) {
        return(filtered_table)
      }
      var_values_to_check <- filtered_table$analysis_var_value
      var_values_check <- var_values_to_check %in% xx[["values_set"]]

      if (any(!var_values_check)) {
        values_with_error <- var_values_to_check[!var_values_check] %>%
          unique() %>%
          glue::glue_collapse(sep = ", ")
        variables_with_error <- glue::glue_collapse(xx[["var_name"]], sep = ", ")
        msg <- glue::glue(
          variables_with_error,
          ":",
          values_with_error,
          " are in the results table as options but are not defined in the function arguments"
        )
        stop(msg)
      }
      return(filtered_table)
    })
  return(list(
    dictionary = dictionary,
    ipc_key_table = ipc_key_table,
    value_checked_ipc_key_table = value_checked_ipc_key_table
  ))
}

#' Helper to order the ipc results
#'
#' @param results_table results table with analysis key
#' @param analysis_key String with the name of the analysis key. Default is "analysis_key"
#' @param fcs_cat_var The string with the name of the Food Consumption Score. Default is "fsl_fcs_cat"
#' @param fcs_cat_values String with the options of the Food Consumption Score. Default is
#' c("Poor", "Borderline", "Acceptable")
#' @param fcs_set String for the Food Consumption Score questions set. Default is
#' c("fcs_cereal", "fcs_pulses", "fcs_milk", "fcs_meat", "fcs_veg", "fcs_fruit", "fcs_oil",
#' "fcs_sugar", "fcs_spices")
#' @param rcsi_cat_var The string with the name of the reduced Coping Strategy Index. Default is "fsl_rcsi_cat"
#' @param rcsi_cat_values String with the options of the reduced Coping Strategy Index. Default is
#' c("No to Low", "Medium", "High")
#' @param rcsi_set String for the reduced Coping Strategy Index questions set. Default is
#' c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb")
#' @param lcsi_cat_var The string with the name of the Livelihood Coping Strategy Index. Default is
#' "fsl_lcsi_cat"
#' @param lcsi_cat_values String with the options of the Livelihood Coping Strategy Index. Default
#' is c("None", "Stress", "Crisis", "Emergency")
#' @param lcsi_set String for the Livelihood Coping Strategy Index questions set. Default is
#' c("fsl_lcsi_stress1", "fsl_lcsi_stress2", "fsl_lcsi_stress3", "fsl_lcsi_stress4",
#' "fsl_lcsi_crisis1", "fsl_lcsi_crisis2", "fsl_lcsi_crisis3", "fsl_lcsi_emergency1",
#' "fsl_lcsi_emergency2", "fsl_lcsi_emergency3")
#' @param lcsi_value_set String for the values of the Livelihood Coping Strategy Index questions
#' set. Default is c("yes", "no_had_no_need", "no_exhausted", "not_applicable")
#' @param hhs_cat_var The string with the name of the Household Hunger Scale. Default is "fsl_hhs_cat_ipc"
#' @param hhs_cat_values String with the options of the Household Hunger Scale. Default is
#' c("None", "No or Little", "Moderate", "Severe", "Very Severe")
#' @param hhs_cat_yesno_set String for the Household Hunger Scale yes-no questions set. Default is
#' c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight")
#' @param hhs_value_yesno_set String for the values of the Household Hunger Scale yes-no questions
#' set. Default is c("yes", "no")
#' @param hhs_cat_freq_set String for the Household Hunger Scale frequency questions set. Default is
#' c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq")
#' @param hhs_value_freq_set String for the values of the Household Hunger Scale frequency questions
#' set. Default is c("rarely", "sometimes", "often")
#' @param with_hdds TRUE or FALSE, whether to include the FCLC and FC values.
#' @param hdds_cat String with the name of the Household Dietary Diversity Score. Default is "fsl_hdds_cat"
#' @param hdds_cat_values String with the options of the Household Dietary Diversity Score. Default is
#' c("Low", "Medium", "High")
#' @param hdds_set String for the Household Dietary Diversity Score. Default is
#' c("fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
#' "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
#' "fsl_hdds_sugar", "fsl_hdds_condiments")
#' @param hdds_value_set String for the values of the Household Dietary Diversity Score questions
#' set. Default is c("yes", "no")
#' @param with_fclc TRUE or FALSE, whether to include the FCLC and FC values.
#' @param fclc_matrix_var String with the name of the food consumption livelihood matrix from FEWSNET.
#' Default is "fclcm_phase"
#' @param fclc_matrix_values String with the options of the food consumption livelihood matrix
#' Default is c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC")
#' @param fc_matrix_var String with the name of the food consumption matrix from FEWSNET.
#' Default is "fsl_fc_phase"
#' @param fc_matrix_values String with the options of the food consumption matrix. Default is
#'  c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC")
#' Default is set to FALSE.
#' @param other_variables String for the names of other variables to include. Default is NULL
#' @param stat_col String for the name of the column with the mean or the proportion. Default is
#' "stat"
#' @param proportion_name String how a proportion is called in the analysis key. Default is
#' "prop_select_one"
#' @param mean_name String how a mean is called in the analysis key. Default is "mean"
#'
#' @return one ordered group x variable table
#' @export
#'
#' @keywords internal
#'
#' @examples
#'
#' no_nas_presentresults_resultstable <- presentresults_resultstable %>%
#'   dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
#' create_ordered_ipc_table(
#'   results_table = no_nas_presentresults_resultstable,
#'   fcs_cat_var = "fcs_cat",
#'   fcs_cat_values = c("low", "medium", "high"),
#'   fcs_set = c(
#'     "fs_fcs_cereals_grains_roots_tubers",
#'     "fs_fcs_beans_nuts",
#'     "fs_fcs_dairy",
#'     "fs_fcs_meat_fish_eggs",
#'     "fs_fcs_vegetables_leaves",
#'     "fs_fcs_fruit",
#'     "fs_fcs_oil_fat_butter",
#'     "fs_fcs_sugar",
#'     "fs_fcs_condiment"
#'   ),
#'   hhs_cat_var = "hhs_cat",
#'   hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
#'   hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
#'   hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
#'   hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
#'   rcsi_cat_var = "rcsi_cat",
#'   rcsi_cat_values = c("low", "medium", "high"),
#'   rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
#'   lcsi_cat_var = "lcs_cat",
#'   lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
#'   lcsi_set = c(
#'     "liv_stress_lcsi_1",
#'     "liv_stress_lcsi_2",
#'     "liv_stress_lcsi_3",
#'     "liv_stress_lcsi_4",
#'     "liv_crisis_lcsi_1",
#'     "liv_crisis_lcsi_2",
#'     "liv_crisis_lcsi_3",
#'     "liv_emerg_lcsi_1",
#'     "liv_emerg_lcsi_2",
#'     "liv_emerg_lcsi_3"
#'   ),
#'   with_hdds = FALSE,
#'   with_fclc = TRUE,
#'   fclc_matrix_var = "fcls_cat",
#'   fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
#'   fc_matrix_var = "fcm_cat",
#'   fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
#'   other_variables = c("income_v2_sum", "expenditure_food")
#' )
create_ordered_ipc_table <- function(results_table,
                                     analysis_key = "analysis_key",
                                     fcs_cat_var = "fsl_fcs_cat",
                                     fcs_cat_values = c("Poor", "Borderline", "Acceptable"),
                                     fcs_set = c(
                                       "fcs_cereal",
                                       "fcs_pulses",
                                       "fcs_milk",
                                       "fcs_meat",
                                       "fcs_veg",
                                       "fcs_fruit",
                                       "fcs_oil",
                                       "fcs_sugar",
                                       "fcs_spices"
                                     ),
                                     hhs_cat_var = "fsl_hhs_cat_ipc",
                                     hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
                                     hhs_cat_yesno_set = c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight"),
                                     hhs_value_yesno_set = c("yes", "no"),
                                     hhs_cat_freq_set = c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq"),
                                     hhs_value_freq_set = c("rarely", "sometimes", "often"),
                                     rcsi_cat_var = "fsl_rcsi_cat",
                                     rcsi_cat_values = c("No to Low", "Medium", "High"),
                                     rcsi_set = c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb"),
                                     lcsi_cat_var = "fsl_lcsi_cat",
                                     lcsi_cat_values = c("None", "Stress", "Crisis", "Emergency"),
                                     lcsi_set = c(
                                       "fsl_lcsi_stress1",
                                       "fsl_lcsi_stress2",
                                       "fsl_lcsi_stress3",
                                       "fsl_lcsi_stress4",
                                       "fsl_lcsi_crisis1",
                                       "fsl_lcsi_crisis2",
                                       "fsl_lcsi_crisis3",
                                       "fsl_lcsi_emergency1",
                                       "fsl_lcsi_emergency2",
                                       "fsl_lcsi_emergency3"
                                     ),
                                     lcsi_value_set = c("yes", "no_had_no_need", "no_exhausted", "not_applicable"),
                                     with_hdds = TRUE,
                                     hdds_cat = "fsl_hdds_cat",
                                     hdds_cat_values = c("Low", "Medium", "High"),
                                     hdds_set = c(
                                       "fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
                                       "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
                                       "fsl_hdds_sugar", "fsl_hdds_condiments"
                                     ),
                                     hdds_value_set = c("yes", "no"),
                                     with_fclc = FALSE,
                                     fclc_matrix_var = "fclcm_phase",
                                     fclc_matrix_values = c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC"),
                                     fc_matrix_var = "fsl_fc_phase",
                                     fc_matrix_values = c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC"),
                                     other_variables = NULL,
                                     stat_col = "stat",
                                     proportion_name = "prop_select_one",
                                     mean_name = "mean") {
  # Checks the results table
  results_review <- review_ipc_results(
    results_table = results_table,
    analysis_key = analysis_key,
    fcs_cat_var = fcs_cat_var,
    fcs_cat_values = fcs_cat_values,
    fcs_set = fcs_set,
    hhs_cat_var = hhs_cat_var,
    hhs_cat_values = hhs_cat_values,
    hhs_cat_yesno_set = hhs_cat_yesno_set,
    hhs_value_yesno_set = hhs_value_yesno_set,
    hhs_cat_freq_set = hhs_cat_freq_set,
    hhs_value_freq_set = hhs_value_freq_set,
    rcsi_cat_var = rcsi_cat_var,
    rcsi_cat_values = rcsi_cat_values,
    rcsi_set = rcsi_set,
    lcsi_cat_var = lcsi_cat_var,
    lcsi_cat_values = lcsi_cat_values,
    lcsi_set = lcsi_set,
    lcsi_value_set = lcsi_value_set,
    with_hdds = with_hdds,
    hdds_cat = hdds_cat,
    hdds_cat_values = hdds_cat_values,
    hdds_set = hdds_set,
    hdds_value_set = hdds_value_set,
    with_fclc = with_fclc,
    fclc_matrix_var = fclc_matrix_var,
    fclc_matrix_values = fclc_matrix_values,
    fc_matrix_var = fc_matrix_var,
    fc_matrix_values = fc_matrix_values,
    other_variables = other_variables,
    stat_col = stat_col,
    proportion_name = proportion_name,
    mean_name = mean_name
  )

  # rearrange results in the order I want
  ## hhs set has to be by the order of the questions set (yes-no;freq;yes-no;freq;yes-no;freq)
  hhs_set <- results_review[["dictionary"]][c("hhs_yesno_set_prop", "hhs_freq_set_prop")] %>%
    purrr::map(~ expand.grid(.x, stringsAsFactors = F)) %>%
    purrr::map(~ dplyr::group_by(.x, var_name)) %>%
    purrr::map(~ dplyr::group_split(.x)) %>%
    purrr::list_transpose() %>%
    do.call(c, .) %>%
    purrr::list_rbind()

  ## rcsi, lcsi, and hdds has to be reorder with the options
  set_to_reoder <- c("rcsi_set_prop", "lcsi_set_prop")
  if (with_hdds) {
    set_to_reoder <- c(set_to_reoder, "hdds_set_prop")
  }

  all_options_in_order <- results_review[["dictionary"]] %>%
    purrr::map(expand.grid) %>%
    purrr::modify_at(
      .at = dplyr::all_of(set_to_reoder),
      .f = ~ dplyr::arrange(., var_name, values_set)
    )

  ## removing duplications of the hhs variables sets
  all_options_in_order[["hhs_yesno_set_prop"]] <- hhs_set
  all_options_in_order[["hhs_freq_set_prop"]] <- NULL
  names(all_options_in_order)[names(all_options_in_order) == "hhs_yesno_set_prop"] <- "hhs_set"

  all_options_in_order <- all_options_in_order %>%
    purrr::map(
      ~ dplyr::mutate(
        .,
        dplyr::across(
          .cols = dplyr::everything(),
          .fns = as.character
        )
      )
    ) %>%
    purrr::list_rbind() %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.character),
        ~ dplyr::na_if(., "NA")
      )
    )

  value_checked_ipc_df <- results_review[["value_checked_ipc_key_table"]] %>%
    do.call(rbind, .) %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.character),
        ~ dplyr::na_if(., "NA")
      )
    )

  orderered_ipc_table <- dplyr::left_join(all_options_in_order, value_checked_ipc_df,
    by = c("analysis_type",
      "var_name" = "analysis_var",
      "values_set" = "analysis_var_value"
    )
  )

  # Complete for missing values, i.e when an option is not calculated, i.e. 0% of FC phase 1
  missing_table <- orderered_ipc_table %>%
    dplyr::filter(is.na(analysis_key)) %>%
    dplyr::select(var_name, values_set, analysis_type)

  if (nrow(missing_table) > 0) {
    information_missing_table <- orderered_ipc_table %>%
      dplyr::filter(
        !is.na(analysis_key),
        analysis_type %in% missing_table$analysis_type
      ) %>%
      dplyr::group_by(var_name, values_set, analysis_type) %>%
      dplyr::group_split() %>%
      magrittr::extract2(1) %>%
      dplyr::select(analysis_type, analysis_key,
        var_to_change = var_name,
        values_set_to_change = values_set
      )

    complement_table <- missing_table %>%
      dplyr::left_join(information_missing_table, by = "analysis_type") %>%
      dplyr::mutate(
        analysis_key = stringr::str_replace_all(
          string = analysis_key,
          pattern = var_to_change,
          replacement = var_name
        ),
        analysis_key = stringr::str_replace_all(
          string = analysis_key, pattern = values_set_to_change,
          replacement = values_set
        )
      ) %>%
      dplyr::select(var_name, values_set, analysis_type, analysis_key)

    orderered_ipc_table <- orderered_ipc_table %>%
      dplyr::left_join(complement_table, by = c("var_name", "values_set", "analysis_type")) %>%
      dplyr::mutate(analysis_key.x = dplyr::if_else(is.na(analysis_key.x), analysis_key.y, analysis_key.x)) %>%
      dplyr::select(-analysis_key.y) %>%
      dplyr::rename(analysis_key = analysis_key.x)
  }

  # putting back the order and the names
  orderered_ipc_table <- orderered_ipc_table %>%
    dplyr::select(analysis_key,
      analysis_type,
      analysis_var = var_name,
      analysis_var_value = values_set,
      group_var,
      group_var_value,
      nb_analysis_var,
      nb_group_var
    )

  # adding the other variables
  if (!is.null(other_variables)) {
    other_variables_key_table <- results_review[["ipc_key_table"]] %>%
      dplyr::filter(analysis_var %in% other_variables)

    orderered_ipc_table <- rbind(orderered_ipc_table, other_variables_key_table)
  }

  # adding the proportion and mean again
  orderered_ipc_table <- orderered_ipc_table %>%
    dplyr::left_join(dplyr::select(results_table, dplyr::all_of(c(analysis_key, stat_col))))

  # create group x variable
  create_table_group_x_variable(orderered_ipc_table,
    analysis_key = analysis_key,
    value_columns = stat_col
  )
}

#' Creates a table for the IPC
#'
#' Create a table from a results table with a key analysis in a format to be shared with the
#' IPC TWG.
#'
#' For arguments that are *_values or *_set, and other_variables, the order of appearance will be
#' the order in the table.
#'
#' @param results_table results table with analysis key
#' @param analysis_key String with the name of the analysis key. Default is "analysis_key"
#' @param dataset dataset used to create the analysis results to calculate the number of clusters
#' or number of survey.
#' @param cluster_name string with the name of column of the cluster in the dataset. Default is NULL,
#' it will calculate the number of interviews only.
#' @param fcs_cat_var The string with the name of the Food Consumption Score. Default is "fsl_fcs_cat"
#' @param fcs_cat_values String with the options of the Food Consumption Score. Default is
#' c("Poor", "Borderline", "Acceptable")
#' @param fcs_set String for the Food Consumption Score questions set. Default is
#' c("fcs_cereal", "fcs_pulses", "fcs_milk", "fcs_meat", "fcs_veg", "fcs_fruit", "fcs_oil",
#' "fcs_sugar", "fcs_spices")
#' @param hhs_cat_var The string with the name of the Household Hunger Scale. Default is "fsl_hhs_cat_ipc"
#' @param hhs_cat_values String with the options of the Household Hunger Scale. Default is
#' c("None", "No or Little", "Moderate", "Severe", "Very Severe")
#' @param hhs_cat_yesno_set String for the Household Hunger Scale yes-no questions set. Default is
#' c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight")
#' @param hhs_value_yesno_set String for the values of the Household Hunger Scale yes-no questions
#' set. Default is c("yes", "no")
#' @param hhs_cat_freq_set String for the Household Hunger Scale frequency questions set. Default is
#' c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq")
#' @param hhs_value_freq_set String for the values of the Household Hunger Scale frequency questions
#' set. Default is c("rarely", "sometimes", "often")
#' @param rcsi_cat_var The string with the name of the reduced Coping Strategy Index. Default is "fsl_rcsi_cat"
#' @param rcsi_cat_values String with the options of the reduced Coping Strategy Index. Default is
#' c("No to Low", "Medium", "High")
#' @param rcsi_set String for the reduced Coping Strategy Index questions set. Default is
#' c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb")
#' @param lcsi_cat_var The string with the name of the Livelihood Coping Strategy Index. Default is
#' "fsl_lcsi_cat"
#' @param lcsi_cat_values String with the options of the Livelihood Coping Strategy Index. Default
#' is c("None", "Stress", "Crisis", "Emergency")
#' @param lcsi_set String for the Livelihood Coping Strategy Index questions set. Default is
#' c("fsl_lcsi_stress1", "fsl_lcsi_stress2", "fsl_lcsi_stress3", "fsl_lcsi_stress4",
#' "fsl_lcsi_crisis1", "fsl_lcsi_crisis2", "fsl_lcsi_crisis3", "fsl_lcsi_emergency1",
#' "fsl_lcsi_emergency2", "fsl_lcsi_emergency3")
#' @param lcsi_value_set String for the values of the Livelihood Coping Strategy Index questions
#' set. Default is c("yes", "no_had_no_need", "no_exhausted", "not_applicable")
#' @param with_hdds TRUE or FALSE, whether to include the FCLC and FC values.
#' @param hdds_cat String with the name of the Household Dietary Diversity Score. Default is "fsl_hdds_cat"
#' @param hdds_cat_values String with the options of the Household Dietary Diversity Score. Default is
#' c("Low", "Medium", "High")
#' @param hdds_set String for the Household Dietary Diversity Score. Default is
#' c("fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
#' "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
#' "fsl_hdds_sugar", "fsl_hdds_condiments")
#' @param hdds_value_set String for the values of the Household Dietary Diversity Score questions
#' set. Default is c("yes", "no")
#' @param with_fclc TRUE or FALSE, whether to include the FCLC and FC values.
#' Default is set to FALSE.
#' @param fclc_matrix_var String with the name of the food consumption livelihood matrix from FEWSNET.
#' Default is "fclcm_phase"
#' @param fclc_matrix_values String with the options of the food consumption livelihood matrix
#' Default is c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC")
#' @param fc_matrix_var String with the name of the food consumption matrix from FEWSNET.
#' Default is "fsl_fc_phase"
#' @param fc_matrix_values String with the options of the food consumption matrix. Default is
#'  c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC")
#' @param other_variables String for the names of other variables to include. Default is NULL
#' @param stat_col String for the name of the column with the mean or the proportion. Default is
#' "stat"
#' @param proportion_name String how a proportion is called in the analysis key. Default is
#' "prop_select_one"
#' @param mean_name String how a mean is called in the analysis key. Default is "mean"
#'
#' @return a list with:
#' - a wide table with groups of interest in the rows, and the variables in the columns in a
#' format that can be shared to the IPC TWG. This table should be pass into
#' create_xlsx_group_x_variable
#' - the dataset that was provided.
#'
#' @export
#'
#' @examples
#' no_nas_presentresults_resultstable <- presentresults_resultstable %>%
#'   dplyr::filter(!(analysis_type == "prop_select_one" & is.na(analysis_var_value)))
#'
#' create_ipc_table(
#'   results_table = no_nas_presentresults_resultstable,
#'   dataset = presentresults_MSNA_template_data,
#'   cluster_name = "cluster_id",
#'   fcs_cat_var = "fcs_cat",
#'   fcs_cat_values = c("low", "medium", "high"),
#'   fcs_set = c(
#'     "fs_fcs_cereals_grains_roots_tubers",
#'     "fs_fcs_beans_nuts",
#'     "fs_fcs_dairy",
#'     "fs_fcs_meat_fish_eggs",
#'     "fs_fcs_vegetables_leaves",
#'     "fs_fcs_fruit",
#'     "fs_fcs_oil_fat_butter",
#'     "fs_fcs_sugar",
#'     "fs_fcs_condiment"
#'   ),
#'   hhs_cat_var = "hhs_cat",
#'   hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
#'   hhs_cat_yesno_set = c("fs_hhs_nofood_yn", "fs_hhs_sleephungry_yn", "fs_hhs_daynoteating_yn"),
#'   hhs_cat_freq_set = c("fs_hhs_nofood_freq", "fs_hhs_sleephungry_freq", "fs_hhs_daynoteating_freq"),
#'   hhs_value_freq_set = c("rarely_1_2", "sometimes_3_10", "often_10_times"),
#'   rcsi_cat_var = "rcsi_cat",
#'   rcsi_cat_values = c("low", "medium", "high"),
#'   rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
#'   lcsi_cat_var = "lcs_cat",
#'   lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
#'   lcsi_set = c(
#'     "liv_stress_lcsi_1",
#'     "liv_stress_lcsi_2",
#'     "liv_stress_lcsi_3",
#'     "liv_stress_lcsi_4",
#'     "liv_crisis_lcsi_1",
#'     "liv_crisis_lcsi_2",
#'     "liv_crisis_lcsi_3",
#'     "liv_emerg_lcsi_1",
#'     "liv_emerg_lcsi_2",
#'     "liv_emerg_lcsi_3"
#'   ),
#'   with_hdds = FALSE
#' )
#'
create_ipc_table <- function(results_table,
                             analysis_key = "analysis_key",
                             dataset,
                             cluster_name = NULL,
                             fcs_cat_var = "fsl_fcs_cat",
                             fcs_cat_values = c("Poor", "Borderline", "Acceptable"),
                             fcs_set = c(
                               "fsl_fcs_cereal",
                               "fsl_fcs_legumes",
                               "fsl_fcs_veg",
                               "fsl_fcs_fruit",
                               "fsl_fcs_meat",
                               "fsl_fcs_dairy",
                               "fsl_fcs_sugar",
                               "fsl_fcs_oil"
                             ),
                             hhs_cat_var = "fsl_hhs_cat_ipc",
                             hhs_cat_values = c("None", "No or Little", "Moderate", "Severe", "Very Severe"),
                             hhs_cat_yesno_set = c("fsl_hhs_nofoodhh", "fsl_hhs_sleephungry", "fsl_hhs_alldaynight"),
                             hhs_value_yesno_set = c("yes", "no"),
                             hhs_cat_freq_set = c("fsl_hhs_nofoodhh_freq", "fsl_hhs_sleephungry_freq", "fsl_hhs_alldaynight_freq"),
                             hhs_value_freq_set = c("rarely", "sometimes", "often"),
                             rcsi_cat_var = "fsl_rcsi_cat",
                             rcsi_cat_values = c("No to Low", "Medium", "High"),
                             rcsi_set = c("fsl_rcsi_lessquality", "fsl_rcsi_borrow", "fsl_rcsi_mealsize", "fsl_rcsi_mealadult", "fsl_rcsi_mealnb"),
                             lcsi_cat_var = "fsl_lcsi_cat",
                             lcsi_cat_values = c("None", "Stress", "Crisis", "Emergency"),
                             lcsi_set = c(
                               "fsl_lcsi_stress1",
                               "fsl_lcsi_stress2",
                               "fsl_lcsi_stress3",
                               "fsl_lcsi_stress4",
                               "fsl_lcsi_crisis1",
                               "fsl_lcsi_crisis2",
                               "fsl_lcsi_crisis3",
                               "fsl_lcsi_emergency1",
                               "fsl_lcsi_emergency2",
                               "fsl_lcsi_emergency3"
                             ),
                             lcsi_value_set = c("yes", "no_had_no_need", "no_exhausted", "not_applicable"),
                             with_hdds = TRUE,
                             hdds_cat = "fsl_hdds_cat",
                             hdds_cat_values = c("Low", "Medium", "High"),
                             hdds_set = c(
                               "fsl_hdds_cereals", "fsl_hdds_tubers", "fsl_hdds_veg", "fsl_hdds_fruit", "fsl_hdds_meat",
                               "fsl_hdds_eggs", "fsl_hdds_fish", "fsl_hdds_legumes", "fsl_hdds_dairy", "fsl_hdds_oil",
                               "fsl_hdds_sugar", "fsl_hdds_condiments"
                             ),
                             hdds_value_set = c("yes", "no"),
                             with_fclc = FALSE,
                             fclc_matrix_var = "fclcm_phase",
                             fclc_matrix_values = c("Phase 1 FCLC", "Phase 2 FCLC", "Phase 3 FCLC", "Phase 4 FCLC", "Phase 5 FCLC"),
                             fc_matrix_var = "fsl_fc_phase",
                             fc_matrix_values = c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC"),
                             other_variables = NULL,
                             stat_col = "stat",
                             proportion_name = "prop_select_one",
                             mean_name = "mean") {
  # Verifications
  if (fcs_cat_var %in% fcs_set) {
    msg <- glue::glue(
      fcs_cat_var, " is in the fcs_set, it should only contains the fcs initial variables."
    )
    stop(msg)
  }

  if (hhs_cat_var %in% hhs_cat_yesno_set) {
    msg <- glue::glue(
      hhs_cat_var, " is in the hhs_cat_yesno_set, it should only contains the hhs initial variables."
    )
    stop(msg)
  }

  if (hhs_cat_var %in% hhs_cat_freq_set) {
    msg <- glue::glue(
      hhs_cat_var, " is in the hhs_cat_freq_set, it should only contains the hhs initial variables."
    )
    stop(msg)
  }

  if (rcsi_cat_var %in% rcsi_set) {
    msg <- glue::glue(
      rcsi_cat_var, " is in the rcsi_set, it should only contains the rcsi initial variables."
    )
    stop(msg)
  }

  if (lcsi_cat_var %in% lcsi_set) {
    msg <- glue::glue(
      lcsi_cat_var, " is in the lcsi_set, it should only contains the lcsi initial variables."
    )
    stop(msg)
  }

  if (with_hdds & hdds_cat %in% hdds_set) {
    msg <- glue::glue(
      hdds_cat, " is in the hdds_set, it should only contains the hdds initial variables."
    )
    stop(msg)
  }
  # create group x variable
  analysis_info <- create_ordered_ipc_table(
    results_table = results_table,
    analysis_key = analysis_key,
    fcs_cat_var = fcs_cat_var,
    fcs_cat_values = fcs_cat_values,
    fcs_set = fcs_set,
    hhs_cat_var = hhs_cat_var,
    hhs_cat_values = hhs_cat_values,
    hhs_cat_yesno_set = hhs_cat_yesno_set,
    hhs_value_yesno_set = hhs_value_yesno_set,
    hhs_cat_freq_set = hhs_cat_freq_set,
    hhs_value_freq_set = hhs_value_freq_set,
    rcsi_cat_var = rcsi_cat_var,
    rcsi_cat_values = rcsi_cat_values,
    rcsi_set = rcsi_set,
    lcsi_cat_var = lcsi_cat_var,
    lcsi_cat_values = lcsi_cat_values,
    lcsi_set = lcsi_set,
    lcsi_value_set = lcsi_value_set,
    with_hdds = with_hdds,
    hdds_cat = hdds_cat,
    hdds_cat_values = hdds_cat_values,
    hdds_set = hdds_set,
    hdds_value_set = hdds_value_set,
    with_fclc = with_fclc,
    fclc_matrix_var = fclc_matrix_var,
    fclc_matrix_values = fclc_matrix_values,
    fc_matrix_var = fc_matrix_var,
    fc_matrix_values = fc_matrix_values,
    other_variables = other_variables,
    stat_col = stat_col,
    proportion_name = proportion_name,
    mean_name = mean_name
  )

  # get the cluster groups info
  cluster_groups_info <- create_group_clusters(
    results_table = results_table,
    analysis_key = analysis_key,
    dataset = dataset,
    cluster_name = cluster_name
  )

  # add the cluster numbers to the analysis information
  ipc_table <- analysis_info %>%
    dplyr::left_join(cluster_groups_info) %>%
    dplyr::select(group_var_value, names(cluster_groups_info), names(analysis_info)) %>%
    magrittr::set_rownames(row.names(analysis_info))

  # add the names in the first rows, name of the table will be removed in the xlsx.
  ipc_table[1, names(cluster_groups_info)] <- names(cluster_groups_info)

  return(list(
    ipc_table = ipc_table,
    dataset = dataset
  ))
}
