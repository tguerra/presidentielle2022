

colorblind <- function(x) {
  
  colorblind_palette <- c(
    "black" = "#000000",
    "lightorange" = "#E69F00",
    "lightblue" = "#56B4E9",
    "green" = "#009E73",
    "yellow" = "#F0E442",
    "blue" = "#0072B2",
    "orange" = "#D55E00",
    "pink" = "#CC79A7"
  )
  
  stopifnot(x %in% names(colorblind_palette))
  as.character(colorblind_palette[ x ])
  
}
