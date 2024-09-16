## code to prepare `presentresults_MSNA2024_dictionary` dataset goes here
presentresults_MSNA2024_dictionary <- create_label_dictionary(kobo_survey_sheet = presentresults_MSNA2024_kobotool_fixed[["kobo_survey"]],
                        kobo_choices_sheet = presentresults_MSNA2024_kobotool_fixed[["kobo_choices"]],
                        results_table = presentresults_MSNA2024_results_table)

usethis::use_data(presentresults_MSNA2024_dictionary, overwrite = TRUE)
