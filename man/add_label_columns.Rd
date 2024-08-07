% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_labels_to_results_table.R
\name{add_label_columns}
\alias{add_label_columns}
\title{Helper to add label columns}
\usage{
add_label_columns(
  results_table,
  columns_var_to_convert,
  dictionary_survey,
  dictionary_survey_name_column = "name",
  dictionary_choices,
  dictionary_choices_survey_column = "name_survey",
  dictionary_choices_choices_column = "name_choices"
)
}
\arguments{
\item{results_table}{Result object with an analysis key.}

\item{columns_var_to_convert}{set of columns to add labels.}

\item{dictionary_survey}{Dictionary with name and label to use. Should be created with
create_label_dictionary.}

\item{dictionary_survey_name_column}{name column in the dictionary.}

\item{dictionary_choices}{Dictionary with list_name, name and label to use.
Should be created with create_label_dictionary.}

\item{dictionary_choices_survey_column}{name column for the survey variable column in the dictionary.}

\item{dictionary_choices_choices_column}{name column for the choices value column in the dictionary.}
}
\value{
Results table with label_* columns
}
\description{
Helper to add label columns
}
