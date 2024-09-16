skip_if_not_installed("vdiffr")
data_to_plot <- presentresults::presentresults_MSNA2024_labelled_results_table |>
  dplyr::filter(
    analysis_var == "wash_drinking_water_source_cat",
    group_var == "hoh_gender"
  )


plot_no_theme <- data_to_plot %>%
  ggplot2::ggplot() +
  ggplot2::geom_col(ggplot2::aes(x =label_analysis_var_value,
                                 y = stat,
                                 fill = label_group_var_value),
                    position = "dodge") +
  ggplot2::labs(title = stringr::str_wrap(unique(data_to_plot$indicator),50),
                x = stringr::str_wrap(unique(data_to_plot$label_analysis_var),50),
                fill = stringr::str_wrap(unique(data_to_plot$label_group_var),20))

test_that("theme_impact create correct colors", {
  theme_reach_test <- plot_no_theme +
      theme_impact(initiative = "reach")

  vdiffr::expect_doppelganger("theme_reach_test", theme_reach_test)

  theme_impact_test <- plot_no_theme +
    theme_impact(initiative = "impact")

  vdiffr::expect_doppelganger("theme_impact_test", theme_impact_test)

})

test_that("theme_impact breaks if initiative is not correct", {
  expect_error(plot_no_theme +
    theme_impact(initiative = "ABA"),
    "initiative should be one of \"reach\", \"impact\", \"agora\"")
})

test_that("theme_barplot create correct formatting", {
  theme_barplot_test <- plot_no_theme +
    theme_barplot()

  vdiffr::expect_doppelganger("theme_barplot_test", theme_barplot)

  theme_barplot_tol_palette_test <- plot_no_theme +
    theme_barplot(palette = impact_palettes$tol_palette)

  vdiffr::expect_doppelganger("theme_barplot_tol_palette_test", theme_barplot_tol_palette_test)
})

