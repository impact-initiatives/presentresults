#' Create number of cluster and number of hh surveyed per group/strata
#'
#' @param results_table results table with analysis key
#' @param analysis_key String with the name of the analysis key. Default is "analysis_key"
#' @param dataset dataset
#' @param cluster_name String with the name of the cluster id in the dataset.
#' @return A dataframe with number of HH and cluster in each group
#' @export
#'
#' @examples
#' create_group_clusters(
#'   results_table = presentresults_resultstable,
#'   dataset = presentresults_MSNA_template_data,
#'   cluster_name = "cluster_id"
#' )
#'
create_group_clusters <- function(results_table,
                                  analysis_key = "analysis_key",
                                  dataset,
                                  cluster_name = NULL) {
  if (is.null(cluster_name)) {
    warning("cluster_name not provided. Assuming cluster sampling was not applied.")
  }
  if (!analysis_key %in% names(results_table)) {
    stop(glue::glue("Analysis key: ", {{ analysis_key }}, " is not found in the results_table table."))
  }
  if (!is.null(cluster_name)) {
    if (!cluster_name %in% names(dataset)) {
      stop(glue::glue("Cluster ID: ", {{ cluster_name }}, " is not found in the dataset."))
    }
  }
  if (!is.null(cluster_name)) {
    if (any(is.na(dataset[[cluster_name]]))) {
      stop(glue::glue("There are NAs in", {{ cluster_name }}, "."))
    }
  }


  df <- analysistools::create_analysis_key_table(results_table = results_table, analysis_key = analysis_key) |>
    dplyr::select(dplyr::starts_with("group_var_")) |>
    dplyr::select(-dplyr::starts_with("group_var_value_"))

  all_group <- df |>
    tidyr::unite(col = grouping_variable, tidyselect::everything(), na.rm = T, sep = " %/% ") |>
    dplyr::pull(grouping_variable) |>
    unique()

  grouping_variables <- stringr::str_split(all_group, " %/% ") |>
    unlist() |>
    unique()
  grouping_variables <- grouping_variables[!grouping_variables %in% "NA"]

  if (any(!grouping_variables %in% names(dataset))) {
    mgs <- grouping_variables[!grouping_variables %in% names(dataset)] |>
      glue::glue_collapse(sep = ", ") %>%
      glue::glue("Following grouping variables: ", ., " cannot be found in the dataset.")
    stop(mgs)
  }

  final_df <- list()
  if (!is.null(cluster_name)) {
    for (i in all_group) {
      if (i != "NA") {
        grouping_variable <- stringr::str_split(i, " %/% ") |> unlist()

        final_df[[i]] <- dataset |>
          dplyr::group_by(!!!rlang::syms(grouping_variable)) |>
          dplyr::summarise(
            number_of_cluster = dplyr::n_distinct(!!rlang::sym(cluster_name)),
            number_of_hh = dplyr::n()
          ) |>
          tidyr::unite(col = "group_var_value", dplyr::all_of(grouping_variable), sep = " %/% ")
      }

      if (i == "NA") {
        final_df[["Overall"]] <- dataset |>
          dplyr::summarise(
            number_of_cluster = dplyr::n_distinct(!!rlang::sym(cluster_name)),
            number_of_hh = dplyr::n()
          ) |>
          dplyr::mutate(group_var_value = "Overall")
      }
    }
  }

  if (is.null(cluster_name)) {
    for (i in all_group) {
      if (i != "NA") {
        grouping_variable <- stringr::str_split(i, " %/% ") |> unlist()

        final_df[[i]] <- dataset |>
          dplyr::group_by(!!!rlang::syms(grouping_variable)) |>
          dplyr::summarise(
            number_of_cluster = NA,
            number_of_hh = dplyr::n()
          ) |>
          tidyr::unite(col = "group_var_value", dplyr::all_of(grouping_variable), sep = " %/% ")
      }

      if (i == "NA") {
        final_df[["Overall"]] <- dataset |>
          dplyr::summarise(
            number_of_cluster = NA,
            number_of_hh = dplyr::n()
          ) |>
          dplyr::mutate(group_var_value = "Overall")
      }
    }
  }




  my_bind_row <- get("bind_rows", asNamespace("dplyr"))

  do.call("my_bind_row", final_df) |> dplyr::ungroup()
}
