## code to prepare `IMPACT_palettes` dataset goes here
impact_colors <- list(
  blue = "#315975",
  gray = "#58585A",
  red = "#EE5859",
  beige = "#D2CBB8",
  light_gray = "#c7c8ca",
  bordeaux = "#581522",
  dark_green = "#023C40",
  light_green = "#4F9C35",
  orange = "#F56741",
  light_yellow = "#F6ECD0"
)
usethis::use_data(impact_colors, overwrite = TRUE)



impact_palettes <- list(
  reach_palette = c(
    "#58585A",
    "#EE5859",
    "#D2CBB8",
    "#c7c8ca"
  ),
  impact_palette = c(
    "#000000",
    "#315975",
    "#58585A"
  ),
  agora_palette = c(
    "#581522",
    "#023C40",
    "#4F9C35",
    "#F56741",
    "#F6ECD0"
  ),
  tol_palette = c(
    "#322288",
    "#505050",
    "#44AA99",
    "#88CCEE",
    "#DDCC77",
    "#EE5859",
    "#AA4499",
    "#721621"
  ),
  high_contrast_tol_palette = c(
    "#275587",
    "#CEA936",
    "#A35464"),
  wong_palette = c(
    "#EE5859",
    "#E69F00",
    "#56B4E9",
    "#322288",
    "#F0E442",
    "#0072B2",
    "#505050",
    "#CC79A7"),
  divergent = c(
    "#F15B22",
    "#F58120",
    "#FBAB35",
    "#209EA0",
    "#008083",
    "#0072B2",
    "#016060"),
  divergent_with_neutral = c(
    "#721621",
    "#D7191C",
    "#FDAE61",
    "#FFFFBF",
    "#97D3C3",
    "#209EA0",
    "#016060")


)

usethis::use_data(impact_palettes, overwrite = TRUE)
