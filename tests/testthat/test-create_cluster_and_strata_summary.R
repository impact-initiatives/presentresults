testthat::test_that("check messeges", {

  testthat::expect_error(create_group_clusters(result = presentresults::presentresults_resultstable,
                                               analysis_key = "Analsysi_key",
                                               dataset = presentresults::presentresults_MSNA_template_data,
                                               cluster_name = "cluster_id"),"Analysis key: Analsysi_key is not found in the result table.")

  testthat::expect_error(create_group_clusters(result = presentresults::presentresults_resultstable,
                                               analysis_key = "analysis_key",
                                               dataset = presentresults::presentresults_MSNA_template_data,
                                               cluster_name = "clusterid"),"Cluster ID: clusterid is not found in the dataset.")


  df_with_NA <- presentresults::presentresults_MSNA_template_data
  df_with_NA$cluster_id[1] <- NA
  testthat::expect_error(create_group_clusters(result = presentresults::presentresults_resultstable,
                                               analysis_key = "analysis_key",
                                               dataset = df_with_NA,
                                               cluster_name = "cluster_id"),"There are NAs incluster_id.")

  ## Grouping variable
  result_table <- presentresults::presentresults_resultstable
  result_table$analysis_key <-   result_table$analysis_key |> stringr::str_replace_all("population","pop")

  testthat::expect_error(create_group_clusters(result = result_table,
                                               analysis_key = "analysis_key",
                                               dataset =  presentresults::presentresults_MSNA_template_data,
                                               cluster_name = "cluster_id"),"Following grouping variables: pop cannot be found in the dataset.")

})

testthat::test_that("expect equal", {

  actual <- create_group_clusters(result =  presentresults::presentresults_resultstable,
                                  dataset =  presentresults::presentresults_MSNA_template_data,
                                  cluster_name = "cluster_id")

  expected <- structure(list(group_var_value = c("locationA ~ displaced", "locationA ~ non-displaced",
                                                 "locationB ~ displaced", "locationB ~ non-displaced", "locationA",
                                                 "locationB"), number_of_cluster = c(2L, 2L, 2L, 2L, 2L, 2L),
                             number_of_hh = c(31L, 24L, 27L, 18L, 55L, 45L)), class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -6L))

  testthat::expect_equal(actual,expected)

  df <-  presentresults::presentresults_MSNA_template_data

  df$cluster_id <-sample(c("a","b","c"),size = 100,replace = T)

  df$cluster_id <- dplyr::case_when( df$location == "locationA" ~ "x",T~ df$cluster_id)

  actual <- create_group_clusters(result =  presentresults::presentresults_resultstable,
                                  dataset = df,
                                  cluster_name = "cluster_id")
  expected <- structure(list(group_var_value = c("locationA ~ displaced", "locationA ~ non-displaced",
                                                 "locationB ~ displaced", "locationB ~ non-displaced", "locationA",  "locationB"),
                             number_of_cluster = c(1L, 1L, 3L, 3L, 1L, 3L),
                             number_of_hh = c(31L, 24L, 27L, 18L, 55L, 45L)), class = c("tbl_df",  "tbl", "data.frame"),
                        row.names = c(NA, -6L))

  testthat::expect_equal(actual,expected)



})


testthat::test_that("With no grouping", {
results <- data.frame(stat = c(.66,.33,0,12),
                      analysis_key = c("prop_select_one @/@ fcs_cat ~/~ low @/@ NA ~/~ NA",
                                       "prop_select_one @/@ fcs_cat ~/~ medium @/@ NA ~/~ NA",
                                       "prop_select_one @/@ fcs_cat ~/~ high @/@ NA ~/~ NA",
                                       "prop_select_one @/@ fcs_cat ~/~ low @/@ location ~/~ locationA ~/~ population ~/~ displaced"))

testthat::expect_no_error(create_group_clusters(result =  results,
                      dataset =  presentresults::presentresults_MSNA_template_data,
                      cluster_name = "cluster_id"))

actual <- create_group_clusters(result =  results,
                                dataset =  presentresults::presentresults_MSNA_template_data,
                                cluster_name = "cluster_id")
expected <- data.frame(number_of_cluster = c(2L, 2L, 2L, 2L, 2L),
                           number_of_hh = c(100L,  31L, 24L, 27L, 18L),
                           group_var_value = c("Overall", "locationA ~ displaced",
                                               "locationA ~ non-displaced", "locationB ~ displaced",
                                               "locationB ~ non-displaced"  ))

testthat::expect_equal(actual,expected)



})

testthat::test_that("With NULL in cluster_id", {

  testthat::expect_error(create_group_clusters(result =  presentresults_resultstable,
                      dataset =  presentresults::presentresults_MSNA_template_data))

  testthat::expect_error(create_group_clusters(result =  presentresults_resultstable,
                      dataset =  presentresults::presentresults_MSNA_template_data, cluster_name = NULL),
                      "You must provide the column name for cluster.")

})
