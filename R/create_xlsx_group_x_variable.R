#' Write a table group by variable into Excel
#'
#' @param table_group_x_variable a table create by create_table_group_x_variable
#' @param table_name string with the name of table to write. It will only be used if it is part of a list.
#' Default is "group_x_table".
#' @param dataset_name string with the name of dataset to write. It will only be used if it is part of a list.
#' Default is "dataset".
#' @param file_path File path, it should contains the file name
#' @param table_sheet string with the name of the sheet to write the table,
#' default is "table_group_x_variable"
#' @param dataset_sheet string with the name of the sheet to write the dataset,
#' default is "dataset"
#' @param write_file Default is TRUE, it will write the file. If set to FALSE, it will return
#' a workbook object from openxlsx
#' @param overwrite Default is FALSE, it will overwrite the file if set to TRUE.
#'
#' @return An excel file formatted.
#' @export
#'
#' @examples
#' \dontrun{
#' presentresults_resultstable %>%
#'   create_table_group_x_variable() %>%
#'   create_xlsx_group_x_variable("mytable.xlsx")
#' }
create_xlsx_group_x_variable <- function(table_group_x_variable,
                                         table_name = "group_x_table",
                                         dataset_name = "dataset",
                                         file_path,
                                         table_sheet = "table_group_x_variable",
                                         dataset_sheet = "dataset",
                                         write_file = TRUE,
                                         overwrite = FALSE) {
  if (stringr::str_detect(file_path, "\\.xlsx", negate = TRUE)) {
    warning("file_path does not containts .xlsx")
  }

  # Check if it is a list or dataset.
  if (is.data.frame(table_group_x_variable)) {
    .table_group_x_variable <- table_group_x_variable
    is_list <- FALSE
  } else {
    # check if list contains all the elements.
    if (!all(c(table_name, dataset_name) %in% names(table_group_x_variable))) {
      stop("Cannot identify one element of the list.")
    }
    .table_group_x_variable <- table_group_x_variable[[table_name]]
    is_list <- TRUE
  }



  # check the headers part
  all_rows_headers <- .table_group_x_variable %>%
    rownames() %>%
    stringr::str_detect(pattern = "header") %>%
    which()

  if (length(all_rows_headers) == 0) {
    stop("Cannot identify the headers rows. Make sure to create your table with
         create_table_group_x_variable")
  }
  analysis_type_rows_headers <- .table_group_x_variable %>%
    rownames() %>%
    stringr::str_detect(pattern = "analysis_type") %>%
    which()

  if (length(analysis_type_rows_headers) == 0) {
    stop("Cannot identify the analysis_type header row. Make sure to create your table with
         create_table_group_x_variable")
  }

  # helpers to format the excel sheet.
  first_row_headers <- min(all_rows_headers)
  last_row_headers <- max(all_rows_headers)

  first_row_corpus <- last_row_headers + 1
  last_row_corpus <- nrow(.table_group_x_variable)

  # create the workbook
  wb <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(wb, sheetName = table_sheet)

  # write the headers into workbook
  headers <- .table_group_x_variable[all_rows_headers, ]
  openxlsx::writeData(wb, sheet = table_sheet, x = headers, colNames = FALSE)

  # get the columns number to the analysis var and type to group them
  mergeCellstable <- data.frame(t(headers[c("header_analysis_var", "header_analysis_type"), ])) %>%
    dplyr::mutate(cols_index = dplyr::row_number()) %>%
    dplyr::group_by(header_analysis_var, header_analysis_type) %>%
    dplyr::mutate(
      min_cols_index = min(cols_index),
      max_cols_index = max(cols_index)
    ) %>%
    dplyr::select(-cols_index) %>%
    dplyr::ungroup() %>%
    unique()

  # merge the headers
  ## all analysis variable name and analysis type
  apply(X = mergeCellstable, MARGIN = 1, function(mergetable) {
    openxlsx::mergeCells(wb,
      sheet = table_sheet,
      cols = c(mergetable[["min_cols_index"]], mergetable[["max_cols_index"]]),
      rows = first_row_headers
    )
    openxlsx::mergeCells(wb,
      sheet = table_sheet,
      cols = c(mergetable[["min_cols_index"]], mergetable[["max_cols_index"]]),
      rows = analysis_type_rows_headers
    )
  })

  ## the grouping header.
  openxlsx::removeCellMerge(wb, sheet = table_sheet, cols = 1, rows = first_row_headers:last_row_headers)
  openxlsx::mergeCells(wb, sheet = table_sheet, cols = 1, rows = first_row_headers:last_row_headers)

  # write the corpus
  corpus <- .table_group_x_variable[-all_rows_headers, ]

  corpus <- corpus %>%
    dplyr::mutate(dplyr::across(.cols = -dplyr::all_of("group_var_value"), .fns = as.numeric))

  openxlsx::writeData(wb, sheet = table_sheet, x = corpus, colNames = FALSE, startRow = first_row_corpus)

  openxlsx::addStyle(wb, table_sheet, style = number_2digits_style, rows = first_row_corpus:last_row_corpus, cols = 2:ncol(corpus), gridExpand = TRUE)

  # add the bordering
  openxlsx::addStyle(wb,
    sheet = table_sheet,
    style = thin_allborder_style,
    rows = c(1:max(last_row_corpus)),
    cols = 1:max(ncol(.table_group_x_variable)),
    gridExpand = TRUE,
    stack = TRUE
  )

  apply(X = mergeCellstable, MARGIN = 1, function(mergetable) {
    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_left_borderstyle,
      rows = c(1:last_row_corpus),
      cols = c(mergetable[["min_cols_index"]], mergetable[["min_cols_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_top_borderstyle,
      rows = c(1:1),
      cols = c(mergetable[["min_cols_index"]]:mergetable[["max_cols_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_right_borderstyle,
      rows = c(1:last_row_corpus),
      cols = c(mergetable[["max_cols_index"]], mergetable[["max_cols_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_bottom_borderstyle,
      rows = c(max(last_row_corpus):max(last_row_corpus)),
      cols = c(mergetable[["min_cols_index"]]:mergetable[["max_cols_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
  })

  ## merge number_of_cluster and number_of_hh if the mergeCelltable has both.
  if (mergeCellstable[[2, "header_analysis_var"]] == "number_of_cluster" &
    mergeCellstable[[3, "header_analysis_var"]] == "number_of_hh") {
    hh_clusters_info <- mergeCellstable %>%
      dplyr::filter(header_analysis_var %in% c("number_of_cluster", "number_of_hh"))

    hh_clusters_info <- hh_clusters_info %>%
      dplyr::summarise(
        min_cols_index = min(min_cols_index),
        max_cols_index = max(max_cols_index),
      )

    openxlsx::addStyle(wb, table_sheet,
      style = number_style, rows = first_row_corpus:last_row_corpus,
      cols = hh_clusters_info[["min_cols_index"]]:hh_clusters_info[["max_cols_index"]],
      gridExpand = TRUE
    )

    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thin_allborder_style,
      rows = c(1:max(last_row_corpus)),
      cols = hh_clusters_info[["min_cols_index"]]:hh_clusters_info[["max_cols_index"]],
      gridExpand = TRUE,
    )

    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_top_borderstyle,
      rows = c(1:1),
      cols = hh_clusters_info[["min_cols_index"]]:hh_clusters_info[["max_cols_index"]],
      gridExpand = TRUE,
      stack = TRUE
    )

    openxlsx::addStyle(wb,
      sheet = table_sheet,
      style = thick_bottom_borderstyle,
      rows = c(max(last_row_corpus):max(last_row_corpus)),
      cols = hh_clusters_info[["min_cols_index"]]:hh_clusters_info[["max_cols_index"]],
      gridExpand = TRUE,
      stack = TRUE
    )
  }

  if (is_list) {
    openxlsx::addWorksheet(wb, sheetName = dataset_sheet)
    openxlsx::writeData(wb, sheet = dataset_sheet, x = table_group_x_variable[[dataset_name]])
  }


  if (write_file) {
    openxlsx::saveWorkbook(wb, file_path, overwrite = overwrite)
  } else {
    return(wb)
  }
}
