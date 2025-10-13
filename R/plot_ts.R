
#' Plot time series
#'
#' Take aggregate data and plot basic time-series using \link[ggplot2]{ggplot}
#'
#' @param data `tbl` or `data.frame` of aggregated weekly rates with weeks as rows
#'  and columns with week as class `date` (hint: use as.Date(grates::isoweek())
#'  to get date from week and year columns)
#' @param geom A character string ("line" or "col") describing whether line graph or epi curve should be plotted
#' @param fill Group to be differentiated by fill
#' @param colour Group to be differentiated by colour
#' @param group Grouping to be provided to ggplot2
#' @param x Column to be ploted on x axis (default = week_date)
#' @param y Column to be plotted on y axis (default = rate)
#'
#' @return ggplot object with rates over time
#' @export
#'
#' @examples
#'
#' x <- tibble::tribble(
#' ~week, ~year, ~flu_season,  ~rate,
#' 40,    2023,  "2023/2024",  2.5,
#' 41,    2023,  "2023/2024",  3.1,
#' 42,    2023,  "2023/2024",  4.2,
#' 40,    2024,  "2024/2025",  2.5,
#' 41,    2024,  "2024/2025",  3.1,
#' 42,    2024,  "2024/2025",  4.2,
#' 40,    2025,  "2025/2026",  2.5,
#' 41,    2025,  "2025/2026",  3.1,
#' 42,    2025,  "2025/2026",  4.2,
#' )
#'
#' plot_ts(x)

plot_ts <- function(data, x = week_date, y = rate, geom = "line", fill = NULL, colour = NULL, group = NULL){
  p <- data |>
    ggplot2::ggplot(ggplot2::aes(x = {{x}}, y = {{y}}, fill = {{fill}}, colour = {{colour}}, group = {{group}})) +
    ggplot2::scale_x_date(date_labels = "%Y-W%W") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, vjust = 1, hjust = 1)) +
    ggplot2::labs(x = "Date",
         y = "Incidence Rate (per 100,000 population)")

  if (geom == "line") {
    p + ggplot2::geom_line()
  } else if (geom == "col") {
    p + ggplot2::geom_col()
  }
  else {
    cli::cli_abort(c(
      "!" = "Unknown geom specified",
      "i" = "Try 'line' or 'col'"))
  }
}
