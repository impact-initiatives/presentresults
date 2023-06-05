#' Write a table group by variable into Excel
#'
#' @param .table_group_x_variable a table create by create_table_group_x_variable
#' @param file_path File path, it should contains the file name
#' @param sheet_name string with the name of the sheet, default is "table_group_x_variable"
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
create_xlsx_group_x_variable <- function(.table_group_x_variable,
                                         file_path,
                                         sheet_name = "table_group_x_variable",
                                         write_file = TRUE,
                                         overwrite = FALSE) {
  if (stringr::str_detect(file_path, "\\.xlsx", negate = TRUE)) {
    warning("file_path does not containts .xlsx")
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
  openxlsx::addWorksheet(wb, sheetName = sheet_name)

  # write the headers into workbook
  headers <- .table_group_x_variable[all_rows_headers, ]
  openxlsx::writeData(wb, sheet = sheet_name, x = headers, colNames = FALSE)

  # get the index to the analysis var and type to group them
  mergeCellstable <- data.frame(t(headers[c("header_analysis_var", "header_analysis_type"), ])) %>%
    dplyr::mutate(index = dplyr::row_number()) %>%
    dplyr::group_by(header_analysis_var, header_analysis_type) %>%
    dplyr::mutate(
      min_index = min(index),
      max_index = max(index)
    ) %>%
    dplyr::select(-index) %>%
    unique()

  # merge the headers
  ## all analysis variable name and analysis type
  apply(X = mergeCellstable, MARGIN = 1, function(mergetable) {
    openxlsx::mergeCells(wb,
      sheet = sheet_name,
      cols = c(mergetable[["min_index"]], mergetable[["max_index"]]),
      rows = first_row_headers
    )
    openxlsx::mergeCells(wb,
      sheet = sheet_name,
      cols = c(mergetable[["min_index"]], mergetable[["max_index"]]),
      rows = analysis_type_rows_headers
    )
  })

  ## the grouping header.
  openxlsx::removeCellMerge(wb, sheet = sheet_name, cols = 1, rows = first_row_headers:last_row_headers)
  openxlsx::mergeCells(wb, sheet = sheet_name, cols = 1, rows = first_row_headers:last_row_headers)

  # write the corpus
  corpus <- .table_group_x_variable[-all_rows_headers, ]

  corpus <- corpus %>%
    dplyr::mutate(dplyr::across(.cols = -dplyr::all_of("group_var_value"), .fns = as.numeric))

  openxlsx::writeData(wb, sheet = sheet_name, x = corpus, colNames = FALSE, startRow = first_row_corpus)

  openxlsx::addStyle(wb, sheet_name, style = number_style, rows = first_row_corpus:last_row_corpus, cols = 2:ncol(corpus), gridExpand = TRUE)

  # add the bordering
  openxlsx::addStyle(wb,
    sheet = sheet_name,
    style = thin_allborder_style,
    rows = c(1:max(last_row_corpus)),
    cols = 1:max(ncol(.table_group_x_variable)),
    gridExpand = TRUE,
    stack = TRUE
  )

  apply(X = mergeCellstable, MARGIN = 1, function(mergetable) {
    openxlsx::addStyle(wb,
      sheet = sheet_name,
      style = thick_left_borderstyle,
      rows = c(1:last_row_corpus),
      cols = c(mergetable[["min_index"]], mergetable[["min_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = sheet_name,
      style = thick_top_borderstyle,
      rows = c(1:1),
      cols = c(mergetable[["min_index"]]:mergetable[["max_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = sheet_name,
      style = thick_right_borderstyle,
      rows = c(1:last_row_corpus),
      cols = c(mergetable[["max_index"]], mergetable[["max_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
    openxlsx::addStyle(wb,
      sheet = sheet_name,
      style = thick_bottom_borderstyle,
      rows = c(max(last_row_corpus):max(last_row_corpus)),
      cols = c(mergetable[["min_index"]]:mergetable[["max_index"]]),
      gridExpand = TRUE,
      stack = TRUE
    )
  })

  if (write_file) {
    openxlsx::saveWorkbook(wb, file_path, overwrite = overwrite)
  } else {
    return(wb)
  }
}
