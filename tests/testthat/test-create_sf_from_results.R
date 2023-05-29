# test_that("Calculates correctly the number of cluster", {
#   test_dataset <- presentresults_MSNA_template_data
#   test_results <- presentresults_resultstable
#
#   set.seed(1223)
#   test_dataset <- test_dataset %>%
#     dplyr::mutate(cluster_test = sample(letters[1:6], size = 100, replace = T)) %>%
#     dplyr::mutate(cluster_test = paste(location, population, cluster_test))
#
#   expected_outputs <- data.frame(
#     group_var_value = c("locationA ~/~ displaced", "locationA ~/~ non-displaced", "locationA"),
#     n_cluster = c(6,6,12),
#     n_observation = c(888,888,888)
#   )
#
#   expect_equal(create_n_cluster_per_strata_table(test_dataset,
#                                               cluster_var = "cluster_test",
#                                               .results = test_results,
#                                               analysis_key = "analysis_key"),
#             expected_outputs)
# })
#
# test_that("If the cluster variable name cannot be found, the function stops") {
#   test_dataset <- presentresults_MSNA_template_data
#   test_results <- presentresults_resultstable
#
#   expect_error(create_n_cluster_per_strata_table(test_dataset,
#                                               cluster_var = "cluster_test",
#                                               .results = test_results,
#                                               analysis_key = "analysis_key"),
#             expected_outputs)
#
# }

test_that("If the cluster variable name cannot be found, the function stops", {
  test_dataset <- presentresults_MSNA_template_data
  test_results <- presentresults_resultstable

  expect_error(create_sf_from_results(df = test_dataset,
                                      cluster_var = "cluster_test_t",
                                      results = test_results,
                                      analysis_key = "analysis_key"))

})

test_that("Calculates correctly the number of clusters", {

  test_dataset <- presentresults_MSNA_template_data
  test_results <- presentresults_resultstable

  result <- create_sf_from_results(test_dataset,
                                   cluster_var = "cluster_test",
                                   results = test_results,
                                   analysis_key = "analysis_key")

  set.seed(1223)
  test_dataset <- test_dataset %>%
    dplyr::mutate(cluster_test = sample(letters[1:6], size = 100, replace = T)) %>%
    dplyr::mutate(cluster_test = paste(location, population, cluster_test))

  n_clusters <- test_dataset %>%
    group_by(location) %>%
    summarise(n_cluster = length(unique(cluster_test))) %>%
    mutate(population = NA)

  expected_outputs <- test_dataset %>%
    group_by(location, population) %>%
    summarise(n_cluster = length(unique(cluster_test))) %>%
    rbind(n_clusters)

  testthat::expect_equal(result, expected_outputs)
})

test_that("Calculates correctly the number of observations", {
  test_dataset <- presentresults_MSNA_template_data
  test_results <- presentresults_resultstable

  result <- create_sf_from_results(test_dataset,
                                   cluster_var = "cluster_test",
                                   results = test_results,
                                   analysis_key = "analysis_key")
  set.seed(1223)
  test_dataset <- test_dataset %>%
    dplyr::mutate(cluster_test = sample(letters[1:6], size = 100, replace = T)) %>%
    dplyr::mutate(cluster_test = paste(location, population, cluster_test))

  n_observations <- test_dataset %>%
    group_by(location) %>%
    summarise(n_households = n()) %>%
    mutate(population = NA)

  expected_outputs <- test_dataset %>%
    group_by(location, population) %>%
    summarise(n_households = n()) %>%
    rbind(n_observations)

  testthat::expect_equal(result, expected_outputs)
})


