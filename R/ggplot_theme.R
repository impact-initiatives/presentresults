#' Barplot theme
#'
#' theme_barplot will fill the colors with the palette, put the y-axis to 0 to 100 %
#'
#' @param palette color palette to be used in `scale_fill_manual`
#'
#' @return ggplot2 plot with filled colors with the palette, put the y-axis to 0 to 100 %
#' @export
#'
#' @examples
#' data_to_plot <- presentresults::presentresults_MSNA2024_labelled_results_table |>
#'   dplyr::filter(
#'     analysis_var == "wash_drinking_water_source_cat",
#'     group_var == "hoh_gender"
#'   )
#'
#' data_to_plot %>%
#'   ggplot2::ggplot() +
#'   ggplot2::geom_col(
#'     ggplot2::aes(
#'       x = label_analysis_var_value,
#'       y = stat,
#'       fill = label_group_var_value
#'     ),
#'     position = "dodge"
#'   ) +
#'   ggplot2::labs(
#'     title = stringr::str_wrap(unique(data_to_plot$indicator), 50),
#'     x = stringr::str_wrap(unique(data_to_plot$label_analysis_var), 50),
#'     fill = stringr::str_wrap(unique(data_to_plot$label_group_var), 20)
#'   ) +
#'   theme_barplot()
#'
theme_barplot <- function(palette = impact_palettes$reach_palette) {
  list(
    ggplot2::scale_fill_manual(values = palette),
    ggplot2::scale_y_continuous(labels = scales::percent, limits = c(0, 1)),
    ggplot2::labs(y = "Percentage")
  )
}

#' Theme for IMPACT Initiative
#'
#' It will set:
#' - theme_minimal,
#' - color of the text in REACH gray (see `impact_colors$reach_gray`),
#' - Title in bold and with the color of the initiative (reach: `impact_colors$red`,
#' impact: `impact_colors$blue`, and agora: `impact_colors$bordeaux`)
#'
#' @param initiative Name of the initiative, should be "reach", "impact" or "agora".
#'
#' @return ggplot2 plot with theme_minimal, bold title and color of the initiative.
#' @export
#'
#' @examples
#'
#' data_to_plot <- presentresults::presentresults_MSNA2024_labelled_results_table |>
#'   dplyr::filter(
#'     analysis_var == "wash_drinking_water_source_cat",
#'     group_var == "hoh_gender"
#'   )
#'
#' data_to_plot %>%
#'   ggplot2::ggplot() +
#'   ggplot2::geom_col(
#'     ggplot2::aes(
#'       x = label_analysis_var_value,
#'       y = stat,
#'       fill = label_group_var_value
#'     ),
#'     position = "dodge"
#'   ) +
#'   ggplot2::labs(
#'     title = stringr::str_wrap(unique(data_to_plot$indicator), 50),
#'     x = stringr::str_wrap(unique(data_to_plot$label_analysis_var), 50),
#'     fill = stringr::str_wrap(unique(data_to_plot$label_group_var), 20)
#'   ) +
#'   theme_impact("reach")
theme_impact <- function(initiative = "reach") {
  if (!initiative %in% c("reach", "impact", "agora")) {
    stop("initiative should be one of \"reach\", \"impact\", \"agora\"")
  }

  if (initiative == "reach") {
    title_colour <- impact_colors$red
  } else if (initiative == "impact") {
    title_colour <- impact_colors$blue
  } else if (initiative == "agora") {
    title_colour <- impact_colors$bordeaux
  }

  ggplot2::theme_minimal() +
    ggplot2::theme(
      text = ggplot2::element_text(colour = impact_colors$reach_gray),
      title = ggplot2::element_text(face = "bold"),
      plot.title = ggplot2::element_text(colour = title_colour)
    )
}
