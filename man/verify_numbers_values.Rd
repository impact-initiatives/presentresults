% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{verify_numbers_values}
\alias{verify_numbers_values}
\title{Verify that a given variable set as the expected number of values.}
\usage{
verify_numbers_values(var_name, values_set, expected_number)
}
\arguments{
\item{var_name}{The name of the variable as string.}

\item{values_set}{Vector with a the set of values.}

\item{expected_number}{Expected numbers of unique value (excluding NA)}
}
\value{
If the number of unique value is different than the expected, it will show a warning.
}
\description{
Verify that a given variable set as the expected number of values.
}
\examples{
verify_numbers_values("my_var", c("low", "borderline", "acceptable"), 3)
verify_numbers_values("my_var", c("low", "borderline", "acceptable", NA), 3)
verify_numbers_values("my_var", c("low", "acceptable", NA), 3)
verify_numbers_values("my_var", c("none", "low", "borderline", "acceptable"), 3)
}
