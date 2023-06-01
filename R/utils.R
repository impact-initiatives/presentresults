#' Helper to check the format of the analysis key
#'
#' @param analysis_key vector of analysis key (not the name of the column)
#'
#' @return It will stop the function if the analysis is not in the correct format
#' @export
#'
#' @examples
#' verify_analysis_key(presentresults_resultstable$analysis_key)
#'
verify_analysis_key <- function(analysis_key) {
  if (analysis_key %>%
    stringr::str_split(" @/@ ", simplify = TRUE) %>%
    dim() %>%
    `[[`(2) != 3) {
    stop("Analysis keys does not seem to follow the correct format")
  }
}

#' Verify that which value of a vector is present in another vector
#'
#' @param .A String of values to check
#' @param .B Vector of string to check
#'
#' @return a vector of the length of values_to_check with TRUE or FALSE if the value appears
#' at least once in vector_to_check
#' @export
#'
#' @examples
#'
#' verify_grep_AinB(c("hhs_cat", "fsc_cat"), presentresults_resultstable$analysis_key)
#'
verify_grep_AinB <- function(.A, .B) {
  .A %>%
    sapply(FUN = function(xx) sum(stringr::str_detect(.B, pattern = xx)) > 0)
}
