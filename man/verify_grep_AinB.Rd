% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{verify_grep_AinB}
\alias{verify_grep_AinB}
\title{Verify that which value of a vector is present in another vector}
\usage{
verify_grep_AinB(.A, .B)
}
\arguments{
\item{.A}{String of values to check}

\item{.B}{Vector of string to check}
}
\value{
a vector of the length of values_to_check with TRUE or FALSE if the value appears
at least once in .B
}
\description{
Verify that which value of a vector is present in another vector
}
\examples{

verify_grep_AinB(c("hhs_cat", "fsc_cat"), presentresults_resultstable$analysis_key)

}
