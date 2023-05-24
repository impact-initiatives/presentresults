#' Creates a table for the IPCTWG
#'
#' Create a table from a results table with a key analysis in a format to be shared with the
#' IPC TWG.
#' For arguments that are *_values or *_set, and other_variables, the order of appereance will be
#' the order in the table
#'
#' @param .results results table with analysis key
#' @param analysis_key String with the name of the analysis key. Default is "analysis_key"
#' @param fclc_matrix_var String with the name of the food consumption livelihood matrix from FEWSNET.
#' Default is "fclc_phase"
#' @param fclc_matrix_values String with the options of the food consumption livelihood matrix
#' Default is c("Phase 1 - FCLC", "Phase 2 - FCLC", "Phase 3 - FCLC", "Phase 4 - FCLC", "Phase 5 - FCLC")
#' @param fc_matrix_var String with the name of the food consumption matrix from FEWSNET.
#' Default is "fc_phase"
#' @param fc_matrix_values String with the options of the food consumption matrix. Defautl is
#'  c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC")
#' @param with_fclc TRUE or FALSE, whether to include the FCLC and FC values.
#' Default is set to FALSE.
#' @param fcs_cat_var The string with the name of the Food Consumption Score. Default is "fcs_cat"
#' @param fcs_cat_values String with the options of the Food Consumption Score. Default is
#' c("Poor", "Borderline", "Acceptable")
#' @param rcsi_cat_var The string with the name of the reduced Coping Strategy Index. Default is "rcsi_cat"
#' @param rcsi_cat_values String with the options of the reduced Coping Strategy Index. Default is
#' c("No to Low", "Medium", "High")
#' @param lcsi_cat_var The string with the name of the Livelihood Coping Strategy Index. Default is
#' "lcsi_cat"
#' @param lcsi_cat_values String with the options of the Livelihood Coping Strategy Index. Default
#' is c("None", "Stress", "Crisis", "Emergency")
#' @param hhs_cat_var The string with the name of the Household Hunger Scale. Default is "hhs_cat_ipc"
#' @param hhs_cat_values String with the options of the Household Hunger Scale. Default is
#' c("None", "Little", "Moderate", "Severe", "Very Severe")
#' @param fcs_set String for the Food Consumption Score questions set. Default is
#' c("fs_fcs_cereals_grains_roots_tubers", "fs_fcs_beans_nuts", "fs_fcs_dairy",
#' "fs_fcs_meat_fish_eggs", "fs_fcs_vegetables_leaves", "fs_fcs_fruit", "fs_fcs_oil_fat_butter",
#' "fs_fcs_sugar", "fs_fcs_condiment")
#' @param rcsi_set String for the reduced Coping Strategy Index questions set. Default is
#' c("No to Low", "Medium", "High")
#' @param lcsi_set String for the Livelihood Coping Strategy Index questions set. There is
#' no default
#' @param lcsi_value_set String for the values of the Livelihood Coping Strategy Index questions
#' set. Default is c("yes", "no_had_no_need", "no_exhausted", "not_applicable")
#' @param other_variables String for the names of other variables to include. Default is NULL
#' @param stat_col String for the name of the column with the mean or the proportion. Default is
#' "stat"
#' @param proportion_name String how a proportion is called in the analysis key. Default is
#' "prop_select_one"
#' @param mean_name String how a mean is called in the analysis key. Default is "mean"
#'
#' @return a wide table with groups of interest in the rows, and the variables in the columns in a
#' format that can be shared to the IPC TWG.
#' @export
#'
#' @examples
#' create_ipctwg_table(.results = presentresults_resultstable,
#'                   fclc_matrix_var = "fcls_cat",
#'                   fclc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
#'                   fc_matrix_var = "fcm_cat",
#'                   fc_matrix_values = c("phase_1", "phase_2", "phase_3", "phase_4", "phase_5"),
#'                   with_fclc = TRUE,
#'                   fcs_cat_values = c("low", "medium", "high"),
#'                   rcsi_cat_values = c("low", "medium", "high"),
#'                   lcsi_cat_var = "lcs_cat",
#'                   lcsi_cat_values = c("none", "stress", "emergency", "crisis"),
#'                   hhs_cat_var = "hhs_cat",
#'                   hhs_cat_values = c("none", "slight", "moderate", "severe", "very_severe"),
#'                   lcsi_set = c("liv_stress_lcsi_1",
#'                                "liv_stress_lcsi_2",
#'                                "liv_stress_lcsi_3",
#'                                "liv_stress_lcsi_4",
#'                                "liv_crisis_lcsi_1",
#'                                "liv_crisis_lcsi_2",
#'                                "liv_crisis_lcsi_3",
#'                                "liv_emerg_lcsi_1",
#'                                "liv_emerg_lcsi_2",
#'                                "liv_emerg_lcsi_3"),
#'                   other_variables = c("income_v2_sum","expenditure_food"))
#'
create_ipctwg_table <- function(.results,
                                analysis_key = "analysis_key",
                                fclc_matrix_var = "fclc_phase",
                                fclc_matrix_values = c("Phase 1 - FCLC", "Phase 2 - FCLC", "Phase 3 - FCLC", "Phase 4 - FCLC", "Phase 5 - FCLC"),
                                fc_matrix_var = "fc_phase",
                                fc_matrix_values = c("Phase 1 FC", "Phase 2 FC", "Phase 3 FC", "Phase 4 FC", "Phase 5 FC"),
                                with_fclc = FALSE,
                                fcs_cat_var = "fcs_cat",
                                fcs_cat_values = c("Poor", "Borderline", "Acceptable"),
                                rcsi_cat_var = "rcsi_cat",
                                rcsi_cat_values = c("No to Low", "Medium", "High"),
                                lcsi_cat_var = "lcsi_cat",
                                lcsi_cat_values = c("None", "Stress", "Crisis", "Emergency"),
                                hhs_cat_var = "hhs_cat_ipc",
                                hhs_cat_values = c("None", "Little", "Moderate", "Severe", "Very Severe"),
                                fcs_set = c("fs_fcs_cereals_grains_roots_tubers",
                                            "fs_fcs_beans_nuts",
                                            "fs_fcs_dairy",
                                            "fs_fcs_meat_fish_eggs",
                                            "fs_fcs_vegetables_leaves",
                                            "fs_fcs_fruit",
                                            "fs_fcs_oil_fat_butter",
                                            "fs_fcs_sugar",
                                            "fs_fcs_condiment"),
                                rcsi_set = c("rCSILessQlty", "rCSIBorrow", "rCSIMealSize", "rCSIMealAdult", "rCSIMealNb"),
                                lcsi_set,
                                lcsi_value_set = c("yes", "no_had_no_need", "no_exhausted", "not_applicable"),
                                other_variables = NULL,
                                stat_col = "stat",
                                proportion_name = "prop_select_one",
                                mean_name = "mean") {
  #create a dictionary for each set
  dictionary <- list(fcs = list(var_name = fcs_cat_var, values_set = fcs_cat_values, analysis_type = proportion_name),
                     rcsi = list(var_name = rcsi_cat_var , values_set = rcsi_cat_values , analysis_type = proportion_name),
                     lcsi = list(var_name = lcsi_cat_var, values_set = lcsi_cat_values, analysis_type = proportion_name ),
                     hhs = list(var_name = hhs_cat_var, values_set = hhs_cat_values, analysis_type = proportion_name ),
                     fcs_set_mean = list(var_name = fcs_set, values_set = NA, analysis_type = mean_name),
                     rcsi_set_mean =list(var_name = rcsi_set , values_set = NA, analysis_type = mean_name),
                     rcsi_set_prop = list(var_name = rcsi_set , values_set = 0:7, analysis_type = proportion_name),
                     lcsi_set_prop = list(var_name = lcsi_set, values_set = lcsi_value_set , analysis_type = proportion_name))
  if(with_fclc) {
    fclc_dictionary <- list(fclc_matrix = list(var_name = fclc_matrix_var, values_set = fclc_matrix_values, analysis_type = proportion_name),
                            fc_matrix = list(var_name = fc_matrix_var , values_set = fc_matrix_values, analysis_type = proportion_name))
    dictionary <- append(fclc_dictionary, dictionary)
  }

  # check all the var exists
  var_names_to_check <- dictionary %>%
    purrr::map(purrr::pluck("var_name")) %>%
    purrr::flatten() %>%
    do.call(c,.) %>%
    c(other_variables)

  var_names_check <- verify_grep_AinB(.A = var_names_to_check,
                                      .B = .results[[analysis_key]])

  if(any(!var_names_check)) {
    msg <-  var_names_to_check[!var_names_check] %>%
      glue::glue_collapse(sep = ", ") %>%
      glue::glue("Following variables: ", ., " cannot be found in the results table")
    stop(msg)
  }

  # check all the values in the results are in the choices arguments from the function
  ipctw_key_table <- create_analysis_key_table(.results = .results, analysis_key = analysis_key) %>%
    unite_variables()

  # check all the values in the results are in the choices arguments from the function
  value_checked_ipctw_key_table <- dictionary %>%
    purrr::map(function(xx) {
      filtered_table <- ipctw_key_table %>%
        dplyr::filter(analysis_var %in% xx[["var_name"]],
                      analysis_type == xx[["analysis_type"]])

      if(xx[["analysis_type"]] == mean_name) {
        return(filtered_table)
      }
      var_values_to_check <- filtered_table$analysis_var_value
      var_values_check <- var_values_to_check %in% xx[["values_set"]]

      if(any(!var_values_check)) {
        values_with_error <- var_values_to_check[!var_values_check] %>%
          unique() %>%
          glue::glue_collapse(sep = ", ")
        variables_with_error <- glue::glue_collapse(xx[["var_name"]], sep = ", ")
        msg <- glue::glue(variables_with_error,
                          ":",
                          values_with_error,
                          " are in the results table as options but are not defined in the function arguments")
        stop(msg)
      }
      return(filtered_table)
      }
      )
  # rearrange results in the order I want.

  all_options_in_order <- dictionary %>%
    purrr::map(expand.grid) %>%
    purrr::map(
      ~dplyr::mutate(.,
                     dplyr::across(.cols = dplyr::everything(),
                                   .fns = as.character)
      )
    ) %>%
    purrr::list_rbind() %>%
    dplyr::mutate(
      dplyr::across(dplyr::where(is.character),
                    ~ dplyr::na_if(., "NA")))
  value_checked_ipctw_df <- value_checked_ipctw_key_table %>%
    do.call(rbind,.) %>%
    dplyr::mutate(
      dplyr::across(dplyr::where(is.character),
                    ~ dplyr::na_if(., "NA")))
  orderered_ipctw_table <- dplyr::left_join(all_options_in_order, value_checked_ipctw_df,
                                            by = c("analysis_type",
                                                   "var_name" = "analysis_var",
                                                   "values_set" = "analysis_var_value"))

  # for missing values
  missing_table <- orderered_ipctw_table %>%
    dplyr::filter(is.na(analysis_key)) %>%
    dplyr::select(var_name, values_set, analysis_type)

  if(nrow(missing_table) > 0 ) {
    information_missing_table <- orderered_ipctw_table %>%
      dplyr::filter(!is.na(analysis_key),
                    analysis_type %in% missing_table$analysis_type) %>%
      dplyr::group_by(var_name,values_set,analysis_type) %>%
      dplyr::group_split() %>%
      magrittr::extract2(1) %>%
      dplyr::select(analysis_type, analysis_key,
             var_to_change = var_name,
             values_set_to_change = values_set)

    complement_table <- missing_table %>%
      dplyr::left_join(information_missing_table, by = "analysis_type") %>%
      dplyr::mutate(analysis_key = stringr::str_replace_all(string= analysis_key,
                                            pattern = var_to_change,
                                            replacement = var_name),
             analysis_key = stringr::str_replace_all(string= analysis_key,pattern = values_set_to_change,
                                            replacement = values_set)) %>%
      dplyr::select(var_name, values_set,   analysis_type, analysis_key)

    orderered_ipctw_table <- orderered_ipctw_table %>%
      dplyr::left_join(complement_table, by = c("var_name", "values_set", "analysis_type")) %>%
      dplyr::mutate(analysis_key.x = dplyr::if_else(is.na(analysis_key.x), analysis_key.y, analysis_key.x)) %>%
      dplyr::select(-analysis_key.y) %>%
      dplyr::rename(analysis_key = analysis_key.x)
  }

  # putting back the order and the names
  orderered_ipctw_table <- orderered_ipctw_table %>%
    dplyr::select(analysis_key,
                  analysis_type,
                  analysis_var = var_name,
                  analysis_var_value = values_set,
                  group_var,
                  group_var_value,
                  nb_analysis_var,
                  nb_group_var)

  # adding the other variables
  if(!is.null(other_variables)) {
    other_variables_key_table <- ipctw_key_table %>%
      dplyr::filter(analysis_var %in% other_variables)

    orderered_ipctw_table <- rbind(orderered_ipctw_table, other_variables_key_table)
  }

  # adding the proportion and mean again
  orderered_ipctw_table <- orderered_ipctw_table %>%
    dplyr::left_join(dplyr::select(.results, analysis_key, stat_col))

  # create group x variable
  create_table_group_x_variable(orderered_ipctw_table,
                                analysis_key = analysis_key,
                                value_columns = stat_col)
}


