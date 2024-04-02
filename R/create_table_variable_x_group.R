#' Turns a long format table into a wide format
#'
#' @param results_table results table with analysis key
#' @param analysis_key analysis key following this description
#' "analysis_type @/@ dependent_variable  %/% dependent_variable_value @/@
#' independent_variable %/% independent_variable_value "
#' @param value_columns string containing the names of the columns with the
#' stats to export
#' @param list_for_excel Default is FALSE, the function will return a dataframe.
#' If set to TRUE, it will return a list of dataframe with the grouping
#' variable as name. This format makes it easier to write excel files with
#' different tab.
#'
#' @return a data frame in a wide format with the analysis type, analysis
#' variable, analysis variable value and the group variable value as columns.
#' If list_for_excel is set to TRUE, it will return a list per grouping
#' variable.
#' @export
#'
#' @examples
#' presentresults_resultstable %>% create_table_variable_x_group("analysis_key", "stat")
create_table_variable_x_group <-
  function(results_table,
           analysis_key = "analysis_key",
           value_columns = c("stat", "stat_low", "stat_upp"),
           list_for_excel = FALSE) {
    analysistools::verify_analysis_key(results_table[[analysis_key]])

    analysis_key_table <- results_table |>
      analysistools::create_analysis_key_table(analysis_key_column = analysis_key) |>
      analysistools::unite_variables()

    results_table <- results_table[, c(analysis_key, value_columns)] |>
      dplyr::left_join(analysis_key_table, by = analysis_key)


    if (list_for_excel == TRUE) {
      table_to_return <- results_table %>%
        dplyr::group_by(group_var) %>%
        dplyr::group_split() %>%
        purrr::map(
          ~ tidyr::pivot_wider(
            .,
            id_cols = c(analysis_type, analysis_var, analysis_var_value),
            names_from = group_var_value,
            values_from = dplyr::all_of(value_columns),
            names_vary = "slowest"
          )
        )
      group_names <- results_table %>%
        dplyr::group_by(group_var) %>%
        dplyr::group_keys() %>%
        dplyr::mutate(
          group_var = stringr::str_replace_na(group_var),
          group_var = stringr::str_replace_all(group_var, "/%", "")
        ) %>%
        dplyr::pull(group_var)
      table_to_return <-
        table_to_return %>% purrr::set_names(group_names)
      return(table_to_return)
    } else {
      table_to_return <- results_table %>%
        tidyr::pivot_wider(
          id_cols = c(analysis_type, analysis_var, analysis_var_value),
          names_from = group_var_value,
          values_from = dplyr::all_of(value_columns),
          names_vary = "slowest"
        )

      return(table_to_return)
    }
  }
