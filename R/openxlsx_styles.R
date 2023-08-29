# openxlsx style function

## numbers
number_2digits_style <- openxlsx::createStyle(numFmt = "0.00")
number_style <- openxlsx::createStyle(numFmt = "0")
proportion_number_style <- openxlsx::createStyle(numFmt = "PERCENTAGE")


## borders
thin_allborder_style <- openxlsx::createStyle(
  borderStyle = "thin",
  border = "TopBottomLeftRight"
)

thick_allborder_style <- openxlsx::createStyle(
  borderStyle = "thick",
  border = "TopBottomLeftRight"
)

thick_left_borderstyle <- openxlsx::createStyle(
  borderStyle = "thick",
  border = "left"
)
thick_top_borderstyle <- openxlsx::createStyle(
  borderStyle = "thick",
  border = "top"
)
thick_right_borderstyle <- openxlsx::createStyle(
  borderStyle = "thick",
  border = "right"
)
thick_bottom_borderstyle <- openxlsx::createStyle(
  borderStyle = "thick",
  border = "bottom"
)

thin_allborder_style <- openxlsx::createStyle(
  borderStyle = "thin",
  border = "TopBottomLeftRight"
)

# font and colors

header_style <- openxlsx::createStyle(
  fontSize = 12,
  fontColour = "#FFFFFF",
  halign = "center",
  valign = "center",
  fontName = "Arial Narrow",
  textDecoration = "bold",
  fgFill = "#ee5859",
  border = "TopBottomLeftRight ",
  borderColour = "#fafafa",
  wrapText = T
)

secondary_grey_cell_style <- openxlsx::createStyle(
  fontSize = 12,
  fontColour = "#58585A",
  fontName = "Arial Narrow",
  fgFill = "#c7c8ca",
  border = "TopBottomLeftRight ",
  wrapText = FALSE
)

secondary_beige_cell_style <- openxlsx::createStyle(
  fontSize = 12,
  fontColour = "#58585A",
  fontName = "Arial Narrow",
  fgFill = "#D2CBB8",
  border = "TopBottomLeftRight",
  wrapText = FALSE
)


secondary_white_cell_style <- openxlsx::createStyle(
  fontSize = 12,
  fontColour = "#58585A",
  fontName = "Arial Narrow",
  fgFill = NULL,
  border = "TopBottomLeftRight",
  wrapText = FALSE
)
