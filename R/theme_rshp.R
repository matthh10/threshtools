

#' Function to apply the PHS RSHP team's theme to a ggplot2 object
#'
#' @param ...
#' @param base_size Base font size as numeric
#'
#' @return
#' @export
#'
#' @examples
#'
#'
theme_rshp <- function(..., base_size = 11){
  theme_grey() %+replace%
    theme(
      text = element_text(size = base_size,  family = "sans"),
      axis.title = element_text(colour="#3F3685"),
      axis.title.x = element_text(margin = margin(0.1, 0, 0, 0, unit = "cm"), size = rel(1.1)),
      axis.title.y = element_text(margin = margin(0, 0.1, 0, 0, unit = "cm"), angle =90,  size = rel(1.1)),
      legend.title = element_text(colour = "#3F3685"),
      legend.position = "right",
      legend.direction = "vertical",
      plot.caption = element_text(size = rel(0.75), hjust = 1),
      panel.background = element_blank(),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}
