# openxlsx style function

## numbers
number_style <- openxlsx::createStyle(numFmt = "0.00")

## borders
thin_allborder_style <- openxlsx::createStyle(
  borderStyle = "thin",
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
