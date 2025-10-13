#' Calculate MSD thresholds
#'
#' Functions calculate activity level thresholds from aggregated weekly rates
#' using the mean standard deviation (MSD) method (Sinnathamby et al. 2024)
#' \url{https://doi.org/10.2807/1560-7917.ES.2024.29.45.2400696}
#'
#' @param data Aggregated weekly rates of class `tbl` or `data.frame` with weeks as rows
#' and a column for rates
#' @param decimal_places Number of decimal places to round thresholds
#' @param rate_col Column containing rates (default = rate)
#' @param season_col Column containing flu season (see \link[threshtools]{find_flu_season})
#'
#' @return `tbl` with columns for mean rate, standard deviation of rate,
#'  number of seasons included, low, medium, high and very high threshold
#' @export
#'
#' @examples
#'
#' #' # Create dummy data
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
#' calculate_msd(x)

calculate_msd <- function(data, rate_col = rate, season_col = flu_season, decimal_places = 2) {

  mean_rate <- data |>
    dplyr::pull({{rate_col}}) |>
    base::mean() |>
    janitor::round_half_up(decimal_places)

  sd_rate <- data |>
    dplyr::pull({{rate_col}}) |>
    base::sd() |>
    janitor::round_half_up(decimal_places)

  no_seasons <- data |>
    dplyr::pull({{season_col}}) |>
    unique() |>
    length()

  tibble::tibble("mean_rate" = mean_rate, "sd_rate" = sd_rate, "no_seasons" = no_seasons) |>
    dplyr::mutate(
      low_threshold = janitor::round_half_up(mean_rate, decimal_places),
      medium_threshold = janitor::round_half_up(mean_rate +
                                         sd_rate, decimal_places),
      high_threshold = janitor::round_half_up(mean_rate + (sd_rate *
                                                    3), decimal_places),
      very_high_threshold = janitor::round_half_up(mean_rate +
                                            (sd_rate * 5), decimal_places)
    )
}
