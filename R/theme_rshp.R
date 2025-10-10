

#' Function to apply the PHS RSHP team's theme to a ggplot2 object
#'
#' @param ... Extra ggplot2::theme() options
#' @param base_size Base font size as numeric
#' @importFrom ggplot2 %+replace%
#' @return ggplot object with RSHP theming
#' @export
#'
#' @examples
#'
#' iris |>
#'   ggplot2::ggplot(ggplot2::aes(Sepal.Length, Sepal.Width)) +
#'   ggplot2::geom_point() +
#'   theme_rshp()
#'

theme_rshp <- function(..., base_size = 11){
  ggplot2::theme_grey() %+replace%
    ggplot2::theme(
      text = ggplot2::element_text(size = base_size,  family = "sans"),
      axis.title = ggplot2::element_text(colour="#3F3685"),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(0.1, 0, 0, 0, unit = "cm"), size = ggplot2::rel(1.1)),
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(0, 0.1, 0, 0, unit = "cm"), angle =90,  size = ggplot2::rel(1.1)),
      legend.title = ggplot2::element_text(colour = "#3F3685"),
      legend.position = "right",
      legend.direction = "vertical",
      plot.caption = ggplot2::element_text(size = ggplot2::rel(0.75), hjust = 1),
      panel.background = ggplot2::element_blank(),
      axis.line.x = ggplot2::element_line(colour = "black"),
      axis.line.y = ggplot2::element_line(colour = "black")
    )
}
