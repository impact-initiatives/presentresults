## code to prepare `presentresults_MSNA2024_labelled_results_table` dataset goes here

## -----------------------------------------------------------------------------
review_kobo_labels_results <- review_kobo_labels(presentresults_MSNA2024_kobotool_template$kobo_survey ,
                                                 presentresults_MSNA2024_kobotool_template$kobo_choices,
                                                 results_table = presentresults_MSNA2024_results_table
)
review_kobo_labels_results

## -----------------------------------------------------------------------------
kobo_survey_fixed <- presentresults_MSNA2024_kobotool_template$kobo_survey
kobo_survey_fixed[
  which(kobo_survey_fixed[["label::english"]] == "How often did this happen in the past [4 weeks/30 days]?"),
  "label::english"
] <- paste(
  "How often did this happen in the past [4 weeks/30 days]? ---",
  c(
    "In the past 4 weeks (30 days), was there ever no food to eat of any kind in your house because of lack of resources to get food?",
    "In the past 4 weeks (30 days), did you or any household member go to sleep at night hungry because there was not enough food?",
    "In the past 4 weeks (30 days), did you or any household member go a whole day or night without eating anything at all because there was not enough food?"
  )
)

## -----------------------------------------------------------------------------
kobo_choices_fixed <- presentresults_MSNA2024_kobotool_template$kobo_choices |>
  dplyr::filter(!`label::english` %in% c(
    "No shelter (sleeping in the open)",
    "Surface water (river, dam, lake, pond, stream, canal, irrigation channel)"
  ))

duplicated_listname_label <- review_kobo_labels_results |> dplyr::filter(comments == "Kobo choices sheet has duplicated labels in the same list_name.")

## -----------------------------------------------------------------------------
kobo_choices_fixed <- kobo_choices_fixed |>
  dplyr::group_by(list_name)  |>
  dplyr::mutate(`label::english` = dplyr::case_when(
    list_name %in% duplicated_listname_label$list_name ~ paste(`label::english`, dplyr::row_number()),
    TRUE ~ `label::english`
  ))  |>
  dplyr::ungroup()

## -----------------------------------------------------------------------------
review_kobo_labels(kobo_survey_fixed, kobo_choices_fixed, results_table = presentresults_MSNA2024_results_table)

## -----------------------------------------------------------------------------
label_dictionary <- create_label_dictionary(kobo_survey_fixed, kobo_choices_fixed, results_table = presentresults_MSNA2024_results_table)

## -----------------------------------------------------------------------------
presentresults_MSNA2024_labelled_results_table <- add_label_columns_to_results_table(
  presentresults_MSNA2024_results_table,
  label_dictionary
)

if(nrow(presentresults_MSNA2024_labelled_results_table) == nrow(presentresults_MSNA2024_results_table)) {
  usethis::use_data(presentresults_MSNA2024_labelled_results_table, overwrite = TRUE)

}

