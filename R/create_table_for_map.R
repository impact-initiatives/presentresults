#' Create a table for MSNA Indicator Maps 1.2 tool
#'
#' @param results_table Results table from analysistools filtered for only value per admin.
#' @param group_var_value_column Name of the column with the group/dependent variable values.
#' Default is "group_var_value".
#' @param analysis_var_column Name of the column with the analysis/independent variable names.
#' Default is "analysis_var".
#' @param stat_column Name of the column with the stat. Default is "stat".
#' @param number_classes Number of classes for the map. It will convert percentages to classes.
#' Default value is 5.
#'
#' @return A wide table with group variables in rows and the indicators coded in their classes in
#' the columns.
#'
#' @details
#' There can be 5 or 6 classes as follow:
#'
#' 5 classes:
#' * 1 : 0
#' * 2 : <= 25 %
#' * 3 : <= 50 %
#' * 4 : <= 75 %
#' * 5 : <= 100 %
#' * NA: Anything else
#'
#' 6 classes:
#' * 1 : 0
#' * 2 : <= 20 %
#' * 3 : <= 40 %
#' * 4 : <= 60 %
#' * 5 : <= 80 %
#' * 6 : <= 100 %
#' * NA: Anything else
#'
#' @export
#'
#' @examples
#' presentresults::presentresults_MSNA2024_results_table |>
#'   dplyr::filter(
#'     analysis_var == "wash_drinking_water_source_cat",
#'     analysis_var_value == "surface_water",
#'     group_var == "admin1"
#'   ) |>
#'   create_table_for_map()
#'
create_table_for_map <- function(results_table,
                                 group_var_value_column = "group_var_value",
                                 analysis_var_column = "analysis_var",
                                 stat_column = "stat",
                                 number_classes = 5) {
  if (!(number_classes %in% c(5, 6))) {
    stop("There can only be 5 or 6 classes")
  }

  if (!group_var_value_column %in% names(results_table)) {
    msg <- glue::glue("Cannot find ", group_var_value_column, " in the results table")
    stop(msg)
  }

  if (!analysis_var_column %in% names(results_table)) {
    msg <- glue::glue("Cannot find ", analysis_var_column, " in the results table")
    stop(msg)
  }

  if (!stat_column %in% names(results_table)) {
    msg <- glue::glue("Cannot find ", stat_column, " in the results table")
    stop(msg)
  }

  if (number_classes == 5) {
    table_to_return <- results_table |>
      dplyr::mutate(stat_recoded = dplyr::case_when(
        !!rlang::sym(stat_column) == 0 ~ "1",
        !!rlang::sym(stat_column) <= .25 ~ "2",
        !!rlang::sym(stat_column) <= .50 ~ "3",
        !!rlang::sym(stat_column) <= .75 ~ "4",
        !!rlang::sym(stat_column) <= 1 ~ "5",
        TRUE ~ ""
      )) |>
      tidyr::pivot_wider(
        id_cols = !!rlang::sym(group_var_value_column),
        names_from = !!rlang::sym(analysis_var_column),
        values_from = stat_recoded
      )

    return(table_to_return)
  } else if (number_classes == 6) {
    table_to_return <- results_table |>
      dplyr::mutate(stat_recoded = dplyr::case_when(
        !!rlang::sym(stat_column) == 0 ~ "1",
        !!rlang::sym(stat_column) <= .20 ~ "2",
        !!rlang::sym(stat_column) <= .40 ~ "3",
        !!rlang::sym(stat_column) <= .60 ~ "4",
        !!rlang::sym(stat_column) <= .80 ~ "5",
        !!rlang::sym(stat_column) <= 1 ~ "6",
        TRUE ~ ""
      )) |>
      tidyr::pivot_wider(
        id_cols = !!rlang::sym(group_var_value_column),
        names_from = !!rlang::sym(analysis_var_column),
        values_from = stat_recoded
      )

    return(table_to_return)
  }
}
