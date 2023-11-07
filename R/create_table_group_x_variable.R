#' Create a wide table with indicators in the columns
#'
#' @param .results long table with the stats and analysis key
#' @param analysis_key name of the columns of the analysis key, as character vector. Default is
#' "analysis_key"
#' @param value_columns names of the columns with the stats of interest, as character vector.
#' Default is c("stat", "stat_low", "stat_upp")
#'
#' @return a wide table with grouping variables as rows and analysed variables as columns
#' @export
#'
#' @examples
#' create_table_group_x_variable(presentresults_resultstable, value_columns = "stat")
#'
create_table_group_x_variable <- function(.results,
                                          analysis_key = "analysis_key",
                                          value_columns = c("stat", "stat_low", "stat_upp")) {
  if (!all(value_columns %in% names(.results))) {
    stop("Cannot find at least one of the value_columns element")
  }

  # create the information from the key index
  index_table <-
    analysistools::create_analysis_key_table(results_table = .results, analysis_key = analysis_key)

  # add the stats needed
  indexed_results <- index_table %>%
    dplyr::left_join(by = analysis_key, .results %>% dplyr::select(dplyr::all_of(c(
      analysis_key, value_columns
    ))))

  # unite the analysis and grouping variables.
  indexed_results <- analysistools::unite_variables(indexed_results)

  # get the main information into a wide format
  step1 <- indexed_results %>%
    tidyr::pivot_wider(
      id_cols = c(group_var_value),
      names_from = c(analysis_var, analysis_var_value, analysis_type),
      values_from = value_columns,
      names_sep = c(" ~/~ "),
      names_vary = "slowest"
    )

  # get the headers from the names: name of the variable, value of the variable, type of analysis
  new_headers <- names(step1) %>%
    stringr::str_split(pattern = " ~/~ ") %>%
    do.call(cbind, .) %>%
    data.frame() %>%
    `names<-`(names(step1)) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(., "NA")))

  # Reodering the row of headers
  if (length(value_columns) > 1) {
    new_headers <- new_headers[c(2:4, 1), ]
    rownames(new_headers) <- c(
      "header_analysis_var",
      "header_analysis_var_value",
      "header_analysis_type",
      "header_stat_type"
    )
  } else {
    rownames(new_headers) <- c(
      "header_analysis_var",
      "header_analysis_var_value",
      "header_analysis_type"
    )
  }

  # return the result
  new_headers %>%
    rbind(step1)
}
