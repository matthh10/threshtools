

#' Calculate epidemiological stats
#'
#' Function that calculates the first week of a chosen season
#' above a defined epidemic threshold and the total number of weeks that season
#' remains above threshold
#'
#' @param data Aggregated weekly counts as `tbl` or `data.frame` with each week
#'  as a row and a column for rate
#' @param season Character string ("YYYY/YYYY") of season to be checked against (see \link[threshtools]{find_flu_season})
#' @param epidemic_threshold Numeric value representing low (epidemic) threshold
#' @param week_col Name of column with week number (default = iso_week)
#'
#' @return Named vector with first week above threshold (`epi_start`) and number of weeks above threshold (`epi_length`)
#' @export
#'
#' @examples
#'
#' x <- tibble::tribble(
#'  ~week, ~year, ~flu_season,  ~rate,
#'  40,    2023,  "2023/2024",  2.5,
#'  41,    2023,  "2023/2024",  3.1,
#'  42,    2023,  "2023/2024",  4.2,
#'  40,    2024,  "2024/2025",  2.5,
#'  41,    2024,  "2024/2025",  3.1,
#'  42,    2024,  "2024/2025",  4.2,
#'  40,    2025,  "2025/2026",  2.5,
#'  41,    2025,  "2025/2026",  3.1,
#'  42,    2025,  "2025/2026",  4.2,
#'  )
#'
#'  epi_stats(
#'   x,
#'   season = "2024/2025",
#'   epidemic_threshold = 2.9,
#'   week_col = week
#'  )


epi_stats <- function(data, season, epidemic_threshold, week_col = iso_week){
  x <- data |>
    dplyr::filter(flu_season == season) |>
    dplyr::mutate(above_threshold = dplyr::case_when(rate >= epidemic_threshold ~ TRUE,
                                       TRUE ~ FALSE))

  epi_start <- x |>
    dplyr::filter(above_threshold == TRUE) |>
    dplyr::slice_head() |>
    dplyr::pull({{week_col}})

  epi_length <- base::sum(x$above_threshold)

  output <- c(epi_start = epi_start, epi_length = epi_length)

  return(output)
}
