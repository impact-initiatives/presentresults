#' Turns a long format table into a wide format
#'
#' @param results_table results table with analysis key
#' @param analysis_key analysis key following this description
#' "analysis_type @/@ dependent_variable  ~/~ dependent_variable_value @/@
#' independent_variable ~/~ independent_variable_value "
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
    if (results_table %>%
      dplyr::pull(!!rlang::sym(analysis_key)) %>%
      stringr::str_split(" @/@ ", simplify = TRUE) %>%
      dim() %>%
      `[[`(2) != 3) {
      stop("Analysis keys does not seem to follow the correct format")
    }

    results_table <- results_table %>%
      dplyr::select(dplyr::all_of(c(analysis_key, value_columns))) %>%
      tidyr::separate(
        analysis_key,
        c("analysis_type", "analysis_var", "group_var"),
        sep = " @/@ ",
        remove = FALSE
      ) %>%
      dplyr::mutate(
        nb_analysis_var = ceiling(stringr::str_count(analysis_var, "~/~") / 2),
        nb_group_var = ceiling(stringr::str_count(group_var, "~/~") / 2)
      )

    analysis_var_split <-
      paste0(rep(
        c("analysis_var_", "analysis_var_value_"),
        max(results_table$nb_analysis_var)
      ), rep(c(1:max(
        results_table$nb_analysis_var
      )), each = 2))
    group_var_split <-
      paste0(rep(
        c("group_var_", "group_var_value_"),
        max(results_table$nb_group_var)
      ), rep(c(1:max(
        results_table$nb_group_var
      )), each = 2))

    results_table <- results_table %>%
      tidyr::separate(analysis_var,
        analysis_var_split,
        sep = " ~/~ "
      ) %>%
      tidyr::separate(group_var,
        group_var_split,
        sep = " ~/~ "
      )

    results_table <- results_table %>%
      tidyr::unite(analysis_var,
        c(
          dplyr::starts_with("analysis_var") &
            !dplyr::contains("value")
        ),
        sep = " ~/~ "
      ) %>%
      tidyr::unite(analysis_var_value,
        c(dplyr::starts_with("analysis_var_value_")),
        sep = " ~/~ "
      ) %>%
      tidyr::unite(group_var, c(
        dplyr::starts_with("group_var_") &
          !dplyr::contains("value")
      ), sep = " ~/~ ") %>%
      tidyr::unite(group_var_value,
        c(dplyr::starts_with("group_var_value_")),
        sep = " ~/~ "
      ) %>%
      dplyr::mutate(dplyr::across(
        c(
          analysis_var,
          analysis_var_value,
          group_var,
          group_var_value
        ),
        ~ stringr::str_remove_all(.x, "( ~/~ NA)*$")
      ))


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
          group_var = stringr::str_replace_all(group_var, "/~", "")
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
