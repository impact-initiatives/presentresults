#' Add labels to the result table
#'
#' @param results_table Result object with an analysis key.
#' @param dictionary Dictionary created with create_label_dictionary
#'
#' @return results table with label columns
#' @export
#'
#' @examples
#' add_label_columns_to_results_table(
#'   results_table = presentresults_MSNA2024_results_table,
#'   dictionary = presentresults_MSNA2024_dictionary
#' )
add_label_columns_to_results_table <- function(results_table,
                                               dictionary) {
  # Create the tables with the differents columns needed.
  results_with_key_table <- results_table |>
    analysistools::create_analysis_key_table()

  # change label for analysis_var_X
  analysis_x_names <- names(results_with_key_table)[results_with_key_table |>
    names() |>
    stringr::str_detect(pattern = "analysis_var_[:digit:]")]

  new_analysis_labeled_results <- add_label_columns(results_with_key_table,
    analysis_x_names,
    dictionary[["dictionary_survey"]],
    dictionary_survey_name_column = "name",
    dictionary[["dictionary_choices"]],
    dictionary_choices_survey_column = "name_survey",
    dictionary_choices_choices_column = "name_choices"
  )
  # change label for group_var_x
  group_x_names <- names(results_with_key_table)[results_with_key_table |>
    names() |>
    stringr::str_detect(pattern = "group_var_[:digit:]")]

  new_group_labeled_results <- add_label_columns(results_with_key_table,
    group_x_names,
    dictionary[["dictionary_survey"]],
    dictionary_survey_name_column = "name",
    dictionary[["dictionary_choices"]],
    dictionary_choices_survey_column = "name_survey",
    dictionary_choices_choices_column = "name_choices"
  )

  # Bind togethers the labeled_x_var_x columns
  new_label_results_table <- list(
    new_analysis_labeled_results,
    new_group_labeled_results
  ) |>
    purrr::reduce(\(x, y) dplyr::left_join(x, y, by = names(results_with_key_table))) |>
    dplyr::left_join(dictionary[["analysis_type_dictionary"]])


  # If there is no label, it will take the xml value.
  ## Get the column names
  label_cols <- names(new_label_results_table)[!names(new_label_results_table) %in% names(results_with_key_table)]
  label_cols <- label_cols[!grepl("analysis_type", label_cols)]

  ## Create a vector of column names that have "var" instead of "label"
  var_cols <- stringr::str_remove_all(label_cols, "label_")

  ## Replace NA values
  for (i in seq_along(label_cols)) {
    new_label_results_table[[label_cols[i]]] <- ifelse(is.na(new_label_results_table[[label_cols[i]]]),
      new_label_results_table[[var_cols[i]]],
      new_label_results_table[[label_cols[i]]]
    )
  }

  # Unite the different labeled columns together and add the label analysis key
  labeled_keys <- new_label_results_table |>
    unite_labels() |>
    add_label_analysis_key() |>
    dplyr::select(analysis_key, dplyr::contains("label"))

  # Join the labeled columns to the initial results table.
  results_table |>
    dplyr::left_join(labeled_keys)
}

#' Helper to add label columns
#'
#' @param results_table Result object with an analysis key.
#' @param columns_var_to_convert set of columns to add labels.
#' @param dictionary_survey Dictionary with name and label to use. Should be created with
#' create_label_dictionary.
#' @param dictionary_survey_name_column name column in the dictionary.
#' @param dictionary_choices Dictionary with list_name, name and label to use.
#' Should be created with create_label_dictionary.
#' @param dictionary_choices_survey_column name column for the survey variable column in the dictionary.
#' @param dictionary_choices_choices_column name column for the choices value column in the dictionary.
#'
#' @return Results table with label_* columns
#' @export
#'
add_label_columns <- function(results_table,
                              columns_var_to_convert,
                              dictionary_survey,
                              dictionary_survey_name_column = "name",
                              dictionary_choices,
                              dictionary_choices_survey_column = "name_survey",
                              dictionary_choices_choices_column = "name_choices") {
  if (!all(columns_var_to_convert %in% names(results_table))) {
    msg <- glue::glue("Cannot find one or more columns from:", columns_var_to_convert)
    stop(msg)
  }

  var_value_names <- stringr::str_replace(columns_var_to_convert, "var", "var_value")

  if (!all(var_value_names %in% names(results_table))) {
    msg <- glue::glue("Cannot find one or more columns from:", var_value_names)
    stop(msg)
  }

  if (!(dictionary_survey_name_column %in% names(dictionary_survey))) {
    msg <- glue::glue("Cannot find in the dictionary_survey", dictionary_survey_name_column)
    stop(msg)
  }

  if (!all(c(dictionary_choices_survey_column, dictionary_choices_choices_column) %in% names(dictionary_choices))) {
    msg <- glue::glue("Cannot find in the dictionary_choices", c(dictionary_choices_survey_column, dictionary_choices_choices_column))
    stop(msg)
  }

  var_new_names <- paste0("label_", columns_var_to_convert)

  # if adding label to the variable, it will join on the variable name
  # if adding label to the choice, it will join on the variable name and the list
  results_with_var_label <- columns_var_to_convert |>
    purrr::map(~ dplyr::left_join(
      x = results_table,
      y = dictionary_survey,
      by = setNames(dictionary_survey_name_column, .x)
    )) |>
    purrr::reduce(\(x, y) dplyr::left_join(x,
      y,
      by = names(results_table)
    )) |>
    purrr::set_names(c(names(results_table), var_new_names))


  var_value_new_names <- var_new_names %>% stringr::str_replace("var", "var_value")
  results_with_var_value_label <- columns_var_to_convert |>
    purrr::map(~ dplyr::left_join(
      x = results_table,
      y = dictionary_choices,
      by = c(
        setNames(dictionary_choices_survey_column, .x),
        setNames(dictionary_choices_choices_column, stringr::str_replace(.x, "var", "var_value"))
      )
    )) |>
    purrr::reduce(\(x, y) dplyr::left_join(x,
      y,
      by = names(results_table)
    )) |>
    purrr::set_names(c(names(results_table), var_value_new_names))

  list(
    results_with_var_label,
    results_with_var_value_label
  ) |>
    purrr::reduce(\(x, y) dplyr::left_join(x, y, by = names(results_table)))
}

#' Unite labels columns
#'
#' @param key_table a key table built with create_analysis_key_table
#'
#' @return a table with label_analysis_var, label_analysis_var_value, label_group_var, and
#' label_group_var_value united and with a %/% as separator
#' @export
unite_labels <- function(key_table) {
  key_table %>%
    tidyr::unite(label_analysis_var, c(dplyr::starts_with("label_analysis") &
      !dplyr::contains("value") &
      !dplyr::contains("type")), sep = " %/% ") |>
    tidyr::unite(label_analysis_var_value, c(dplyr::starts_with("label_analysis_var_value_")), sep = " %/% ") |>
    tidyr::unite(label_group_var, c(dplyr::starts_with("label_group_var_") &
      !dplyr::contains("value")), sep = " %/% ") |>
    tidyr::unite(label_group_var_value, c(dplyr::starts_with("label_group_var_value_")), sep = " %/% ") |>
    dplyr::mutate(dplyr::across(
      c(label_analysis_var, label_analysis_var_value, label_group_var, label_group_var_value),
      ~ stringr::str_remove_all(.x, "( %/% NA)*$")
    ))
}

#' Helper to add the label analysis key
#'
#' @param results results table with the label_* columns
#'
#' @return results with label analysis key
#' @export
#'
add_label_analysis_key <- function(results) {
  x <- results$label_group_var %>% stringr::str_split(" %/% ")
  y <- results$label_group_var_value %>% stringr::str_split(" %/% ")
  to_add_group <- purrr::map2(x, y, function(x, y) {
    paste(x, y, sep = " %/% ")
  }) |>
    purrr::map(stringr::str_c, collapse = " -/- ") |>
    do.call(c, args = _)
  x <- results$label_analysis_var %>% stringr::str_split(" %/% ")
  y <- results$label_analysis_var_value %>% stringr::str_split(" %/% ")
  to_add_analysis <- purrr::map2(x, y, function(x, y) {
    paste(x, y, sep = " %/% ")
  }) |>
    purrr::map(stringr::str_c, collapse = " -/- ") |>
    do.call(c, args = _)
  results |> dplyr::mutate(label_analysis_key = paste(
    label_analysis_type,
    "@/@", to_add_analysis, "@/@", to_add_group
  ))
}

#' Create a dictionary for the labeling results
#'
#' @section analysis_type_dictionary:
#' The default analysis dictionary is created like that.
#'
#' ```
#' data.frame(analysis_type = c("prop_select_one",
#'                              "prop_select_multiple",
#'                              "mean",
#'                              "ratio",
#'                              "median"),
#'            label_analysis_type = c("Proportion (single choice)",
#'                                    "Proportion (multiple choice)",
#'                                    "Mean",
#'                                    "Ratio",
#'                                    "Median")
#'
#' ```
#'
#' @param kobo_survey_sheet KOBO survey sheet to be used.
#' @param kobo_choices_sheet KOBO choices sheet to be used.
#' @param label_column label column from the KOBO tools to be used.
#' @param analysis_type_dictionary Analysis type dictionary, a data frame with analysis type and
#' label_analysis_type to be used. By default parameters is set to NULL. It will use a default
#' dataframe. See section analysis_type_dictionary for more details.
#' @param results_table result object with an analysis key. Default is NULL, it will be used with
#' review_kobo_labels.
#'
#' @return A list with 3 dataframes: dictionary_survey, dictionary_choices, analysis_type_dictionary
#' @export
#'
#' @examples
#'
#' create_label_dictionary(
#'   kobo_survey_sheet = presentresults_MSNA2024_kobotool_fixed$kobo_survey,
#'   kobo_choices_sheet = presentresults_MSNA2024_kobotool_fixed$kobo_choices
#' )
#'
#'
#' french_dictionary <- data.frame(
#'   analysis_type = c(
#'     "prop_select_one",
#'     "prop_select_multiple",
#'     "mean",
#'     "ratio",
#'     "median"
#'   ),
#'   label_analysis_type = c(
#'     "Proportion (Choix unique)",
#'     "Proportion (Choix multiple)",
#'     "Moyenne",
#'     "Ratio",
#'     "Médiane"
#'   )
#' )
#'
#' create_label_dictionary(
#'   kobo_survey_sheet = presentresults_MSNA2024_kobotool_fixed$kobo_survey,
#'   kobo_choices_sheet = presentresults_MSNA2024_kobotool_fixed$kobo_choices,
#'   label_column = "label::french",
#'   analysis_type_dictionary = french_dictionary
#' )
#'
create_label_dictionary <- function(kobo_survey_sheet,
                                    kobo_choices_sheet,
                                    label_column = "label::english",
                                    analysis_type_dictionary = NULL,
                                    results_table = NULL) {
  if (nrow(review_kobo_labels(
    kobo_survey_sheet = kobo_survey_sheet,
    kobo_choices_sheet = kobo_choices_sheet,
    label_column = label_column,
    results_table = results_table
  )) > 0) {
    warning("Duplicated labels, try to the function review_kobo_labels to help")
  }

  dictionary_survey <- kobo_survey_sheet |>
    dplyr::select(name, !!dplyr::sym(label_column))

  dictionary_choices <- kobo_survey_sheet |>
    tidyr::separate_wider_delim(type,
      delim = " ",
      cols_remove = F,
      names = c("kobo_type", "list_name"),
      too_few = "align_start"
    ) |>
    dplyr::left_join(kobo_choices_sheet,
      by = "list_name",
      suffix = c("_survey", "_choices"),
      relationship = "many-to-many"
    ) |>
    dplyr::select(name_survey, name_choices, !!dplyr::sym(paste0(label_column, "_choices"))) |>
    dplyr::filter(
      !is.na(name_choices),
      !is.na(!!dplyr::sym(paste0(label_column, "_choices")))
    )

  if (is.null(analysis_type_dictionary)) {
    analysis_type_dictionary <- data.frame(
      analysis_type = c(
        "prop_select_one",
        "prop_select_multiple",
        "mean",
        "ratio",
        "median"
      ),
      label_analysis_type = c(
        "Proportion (single choice)",
        "Proportion (multiple choice)",
        "Mean",
        "Ratio",
        "Median"
      )
    )
  } else if (!all(c("analysis_type", "label_analysis_type") %in% names(analysis_type_dictionary))) {
    msg <- glue::glue("Cannot find analysis_type and/or label_analysis_type in analysis_type_dictionary")
    stop(msg)
  }

  list(
    dictionary_survey = dictionary_survey,
    dictionary_choices = dictionary_choices,
    analysis_type_dictionary = analysis_type_dictionary
  )
}


#' Review if there are duplication of kobo name and labels in the kobo tools
#'
#' @param kobo_survey_sheet kobo survey sheet. It must contain type and name.
#' @param kobo_choices_sheet kobo choices sheet. It must contain list_name and name.
#' @param label_column Column name with the label to be used, default is "label::english"
#' @param exclude_type Types to exclude in the review, default is c("begin_group", "end_group", "beging_repeat", "end_repeat", "note")
#' @param results_table Results table with group_var and analysis_var columns (names of the different
#' variables). The table will be used to review only the names and label that will appear.
#'
#' @return A data frame with the duplicated cases and the reasons. Empty if there is no duplication.
#' @export
#'
#' @examples
#' review_kobo_labels(
#'   kobo_survey_sheet = presentresults_MSNA2024_kobotool_template$kobo_survey,
#'   kobo_choices_sheet = presentresults_MSNA2024_kobotool_template$kobo_choices,
#' )
#' review_kobo_labels(
#'   kobo_survey_sheet = presentresults_MSNA2024_kobotool_template$kobo_survey,
#'   kobo_choices_sheet = presentresults_MSNA2024_kobotool_template$kobo_choices,
#'   results_table = presentresults_MSNA2024_results_table
#' )
review_kobo_labels <- function(kobo_survey_sheet,
                               kobo_choices_sheet,
                               label_column = "label::english",
                               exclude_type = c("begin_group", "end_group", "beging_repeat", "end_repeat", "note"),
                               results_table = NULL) {
  if (!is.null(results_table)) {
    kobo_survey_sheet <- kobo_survey_sheet |>
      dplyr::filter(name %in% unique(c(results_table[["group_var"]], results_table[["analysis_var"]])))
  }

  kobo_survey_sheet <- kobo_survey_sheet |>
    dplyr::filter(
      !dplyr::if_all(dplyr::everything(), is.na),
      !is.na(name),
      !(type %in% exclude_type)
    )

  # Verifying kobo survey duplicated name
  review_survey_dup_name <- kobo_survey_sheet |>
    dplyr::group_by(name, !!dplyr::sym(label_column)) |>
    dplyr::tally() |>
    dplyr::filter(n > 1) |>
    dplyr::mutate(comments = "Kobo survey sheet has duplicated names.") |>
    dplyr::ungroup()

  # Verifying kobo survey duplicated label
  review_survey_dup_label <- kobo_survey_sheet |>
    dplyr::filter(!is.na(!!dplyr::sym(label_column))) |>
    dplyr::group_by(!!dplyr::sym(label_column)) |>
    dplyr::tally() |>
    dplyr::filter(n > 1) |>
    dplyr::mutate(comments = "Kobo survey sheet has duplicated labels.") |>
    dplyr::ungroup()

  # Verifying kobo choices duplicated name
  review_choices_dup_name <- kobo_choices_sheet |>
    dplyr::filter(
      !dplyr::if_all(dplyr::everything(), is.na),
      !is.na(name),
      !is.na(!!dplyr::sym(label_column))
    ) |>
    dplyr::group_by(list_name, name) |>
    dplyr::tally() |>
    dplyr::filter(n > 1) |>
    dplyr::mutate(comments = "Kobo choices sheet has duplicated names in the same list_name.") |>
    dplyr::ungroup()

  # Verifying kobo choices duplicated label
  review_choices_dup_label <- kobo_choices_sheet |>
    dplyr::filter(
      !dplyr::if_all(dplyr::everything(), is.na),
      !is.na(name),
      !is.na(!!dplyr::sym(label_column))
    ) |>
    dplyr::group_by(list_name, !!dplyr::sym(label_column)) |>
    dplyr::tally() |>
    dplyr::filter(n > 1) |>
    dplyr::mutate(comments = "Kobo choices sheet has duplicated labels in the same list_name.") |>
    dplyr::ungroup()

  dplyr::bind_rows(
    review_survey_dup_name,
    review_survey_dup_label,
    review_choices_dup_name,
    review_choices_dup_label
  ) |>
    dplyr::select(comments, name, list_name, !!dplyr::sym(label_column), n)
}
