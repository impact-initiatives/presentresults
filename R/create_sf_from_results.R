# .dataset, cluster_var, .results, analysis_key,
create_sf_from_results <- function (df,
                                    cluster_var = NULL,
                                    results,
                                    analysis_key){

  if(!(cluster_var %in% names(df))){stop("cluster variable does not exist in the dataset")}

  analysis_key_table <- create_analysis_key_table(.results = results , analysis_key = "analysis_key")

}
