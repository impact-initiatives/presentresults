#' Write a table variable by group into Excel
#'
#' @param table_group_x_variable a table create by create_table_variable_x_group
#' @param file_path File names and path. Default is NULL which will return a workbook instead of an
#' excel file.
#' @param table_name string with the name of table to write. It will only be used if it is part of a list.
#' Default is "variable_x_group_table".
#' @param value_columns string containing the names of the columns with the stats to export
#' @param total_columns string containing the names of the columns with the totals
#' (n, n_total, n_weighted, n_total_weighted, etc.) to export
#' @param readme_sheet_name string with the name of the sheet to write the read me page,
#' default is "readme"
#' @param table_sheet_name string with the name of the sheet to write the table,
#' default is "variable_x_group_table"
#' @param overwrite Default is FALSE, it will overwrite the file if set to TRUE.
#'
#' @return An excel file formatted.
#' @export
#'
#' @examples
#' \dontrun{
#' presentresults_resultstable %>%
#'   create_table_variable_x_group() %>%
#'   create_xlsx_variable_x_group(file_path = "mytable.xlsx")
#' }
create_xlsx_variable_x_group <- function(table_group_x_variable,
                                         file_path = NULL,
                                         table_name = "variable_x_group_table",
                                         value_columns = c("stat", "stat_low", "stat_upp"),
                                         total_columns = NULL,
                                         readme_sheet_name = "readme",
                                         table_sheet_name = "variable_x_group_table",
                                         overwrite = FALSE) {
  # Check if it is a list or dataset.
  if (is.data.frame(table_group_x_variable)) {
    results_table_group_x_variable <- table_group_x_variable
    is_list <- FALSE
  } else {
    # check if list contains all the elements.
    if (!all(c(table_name, dataset_name) %in% names(table_group_x_variable))) {
      stop("Cannot identify one element of the list.")
    }
    results_table_group_x_variable <- table_group_x_variable[[table_name]]
    is_list <- TRUE
  }

  wb <- openxlsx::createWorkbook()

  openxlsx::addWorksheet(wb, sheetName = readme_sheet_name)

  openxlsx::addWorksheet(wb, sheetName = table_sheet_name)

  # write the data
  openxlsx::writeData(wb, sheet = table_sheet_name, x = results_table_group_x_variable)

  # style the header
  openxlsx::addStyle(wb, sheet = table_sheet_name, header_style, rows = 1, cols = 1:ncol(results_table_group_x_variable), gridExpand = TRUE)

  # Formatting columns
  ## variable information
  ### helpers to format the columns for the variables.
  variable_min_cols_index <- 1
  variable_max_cols_index <- 3

  ### Formatting the variables columns
  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = secondary_beige_cell_style,
    rows = c(1:nrow(results_table_group_x_variable) + 1),
    cols = c(variable_min_cols_index:variable_max_cols_index),
    gridExpand = TRUE,
    stack = TRUE
  )
  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = thick_left_borderstyle,
    rows = c(1:nrow(results_table_group_x_variable) + 1),
    cols = c(variable_min_cols_index, variable_min_cols_index),
    gridExpand = TRUE,
    stack = TRUE
  )
  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = thick_top_borderstyle,
    rows = c(2:2),
    cols = c(variable_min_cols_index:variable_max_cols_index),
    gridExpand = TRUE,
    stack = TRUE
  )
  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = thick_right_borderstyle,
    rows = c(1:nrow(results_table_group_x_variable) + 1),
    cols = c(variable_max_cols_index:variable_max_cols_index),
    gridExpand = TRUE,
    stack = TRUE
  )
  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = thick_bottom_borderstyle,
    rows = c((nrow(results_table_group_x_variable) + 1):(nrow(results_table_group_x_variable) + 1)),
    cols = c(variable_min_cols_index:variable_max_cols_index),
    gridExpand = TRUE,
    stack = TRUE
  )

  ## formatting stats columns

  ### helpers to format the columns for the stats
  stat_min_cols_index <- variable_max_cols_index + 1
  stat_max_cols_index <- ncol(results_table_group_x_variable)

  stat_length <- length(c(value_columns, total_columns))
  stat_total_cols <- stat_max_cols_index - variable_max_cols_index
  stat_sets_number <- stat_total_cols / stat_length

  helper_table <- data.frame(
    sets = paste0("set", 1:stat_sets_number),
    min_cols_index = cumsum(c(stat_min_cols_index, rep(stat_length, stat_sets_number - 1))),
    max_cols_index = cumsum(c(variable_max_cols_index + stat_length, rep(stat_length, stat_sets_number - 1)))
  )

  if ((stat_total_cols %% stat_sets_number) != 0) {
    stop("Length of value_columns does not match with the table.")
  }

  if (stat_length == 1) {
    warning("Length of value_columns is one, function cannot checks the number of columns.")
  }

  ### formatting the numbers
  value_columns_index <- stringr::str_starts(names(results_table_group_x_variable), stringr::str_c(value_columns, collapse = "|"))

  proportion_lines <- grepl("prop_select", c("title", results_table_group_x_variable$analysis_type))
  # openxlsx::saveWorkbook(wb, gsub(x=file_path,replacement = "before.xlsx",".xlsx" ), overwrite = overwrite)

  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = proportion_number_style,
    rows = c(1:(nrow(results_table_group_x_variable) + 1))[proportion_lines],
    cols = c(1:stat_max_cols_index)[value_columns_index],
    gridExpand = TRUE,
    stack = TRUE
  )
  # openxlsx::saveWorkbook(wb, gsub(x=file_path,replacement = "1.xlsx",".xlsx" ), overwrite = overwrite)

  openxlsx::addStyle(wb,
    sheet = table_sheet_name,
    style = number_2digits_style,
    rows = c(1:(nrow(results_table_group_x_variable) + 1))[!proportion_lines],
    cols = c(1:stat_max_cols_index)[value_columns_index],
    gridExpand = TRUE,
    stack = TRUE
  )

  if (!is.null(total_columns)) {
    total_columns_index <- stringr::str_starts(names(results_table_group_x_variable), stringr::str_c(total_columns, collapse = "|"))
    openxlsx::addStyle(wb,
      sheet = table_sheet_name,
      style = number_style,
      rows = c(1:(nrow(results_table_group_x_variable) + 1)),
      cols = c(1:stat_max_cols_index)[total_columns_index],
      gridExpand = TRUE,
      stack = TRUE
    )
  }
  # openxlsx::saveWorkbook(wb, gsub(x=file_path,replacement = "2.xlsx",".xlsx" ), overwrite = overwrite)


  # openxlsx::saveWorkbook(wb, gsub(x=file_path,replacement = "3.xlsx",".xlsx" ), overwrite = overwrite)

  # openxlsx::addStyle(wb,
  #   sheet = table_sheet_name,
  #   style = proportion_number_style,
  #   rows = c(1:(nrow(results_table_group_x_variable) + 1))[proportion_lines],
  #   cols = c(stat_min_cols_index:stat_max_cols_index),
  #   gridExpand = TRUE,
  #   stack = TRUE
  # )
  # openxlsx::addStyle(wb,
  #   sheet = table_sheet_name,
  #   style = number_2digits_style,
  #   rows = c(1:(ncol(results_table_group_x_variable) + 1))[!proportion_lines],
  #   cols = c(stat_min_cols_index:stat_max_cols_index),
  #   gridExpand = TRUE,
  #   stack = TRUE
  # )

  ### formatting the background
  for (i in 1:nrow(helper_table)) {
    if ((i %% 2) != 0) {
      openxlsx::addStyle(wb,
        sheet = table_sheet_name,
        style = secondary_white_cell_style,
        rows = c(1:nrow(results_table_group_x_variable) + 1),
        cols = c(helper_table[i, "min_cols_index"]:helper_table[i, "max_cols_index"]),
        gridExpand = TRUE,
        stack = TRUE
      )
    } else {
      openxlsx::addStyle(wb,
        sheet = table_sheet_name,
        style = secondary_grey_cell_style,
        rows = c(1:nrow(results_table_group_x_variable) + 1),
        cols = c(helper_table[i, "min_cols_index"]:helper_table[i, "max_cols_index"]),
        gridExpand = TRUE,
        stack = TRUE
      )
    }

    openxlsx::addStyle(wb,
      sheet = table_sheet_name,
      style = thick_left_borderstyle,
      rows = c(1:nrow(results_table_group_x_variable) + 1),
      cols = c(helper_table[i, "min_cols_index"]:helper_table[i, "min_cols_index"]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet_name,
      style = thick_top_borderstyle,
      rows = c(2:2),
      cols = c(helper_table[i, "min_cols_index"]:helper_table[i, "max_cols_index"]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet_name,
      style = thick_right_borderstyle,
      rows = c(1:nrow(results_table_group_x_variable) + 1),
      cols = c(helper_table[i, "max_cols_index"]:helper_table[i, "max_cols_index"]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet_name,
      style = thick_bottom_borderstyle,
      rows = c((nrow(results_table_group_x_variable) + 1):(nrow(results_table_group_x_variable) + 1)),
      cols = c(helper_table[i, "min_cols_index"]:helper_table[i, "max_cols_index"]),
      gridExpand = TRUE,
      stack = TRUE
    )
  }

  if (is.null(file_path)) {
    return(wb)
  } else {
    if (stringr::str_detect(file_path, "\\.xlsx", negate = TRUE)) {
      stop("file_path does not containts .xlsx")
    }
    openxlsx::saveWorkbook(wb, file_path, overwrite = overwrite)
  }
}
