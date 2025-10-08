#' Check for overlapping thresholds
#'
#' @param data A `data.frame` or `tbl` of thresholds with each pathogen/age
#'  group assigned to a row and columns for low, medium, high, and very high
#'  thresholds.
#'
#' @param low_col Name of column showing low threshold (unquoted)
#' @param medium_col Name of column showing medium threshold (unquoted)
#' @param high_col Name of column showing high threshold (unquoted)
#' @param very_high_col Name of column showing very high threshold (unquoted)
#'
#' @return If overlapping thresholds detected then `tbl` is returned with
#' flagged thresholds
#' @export
#'
#' @examples
#'
#' x <- dplyr::tibble(
#'   indicator = c("a", "b"),
#'   low = c(0.5, 1.2),
#'   medium = c(1.1, 0.8),
#'   high = c(2.5, 3.1),
#'   very_high = c(3.7, 4.2)
#'   )
#'
#' check_thresholds(x)

check_thresholds <- function(data,
                             low_col = low,
                             medium_col = medium,
                             high_col = high,
                             very_high_col = very_high){
  alerts <- data |>
    dplyr::mutate(alert = dplyr::case_when({{medium_col}} <= {{low_col}} | {{high_col}} <= {{medium_col}} | {{very_high_col}} <= {{high_col}} ~ T,
                             TRUE ~ F)) |>
    dplyr::filter(alert == T)

  if (nrow(alerts) == 0) {

    cli::cli_alert_success("No overlapping thresholds detected.")

  } else {

    cli::cli_par()
    cli::cli_alert_danger("Overlapping thresholds detected.")
    cli::cli_alert_info("Check the following thresholds and consider changing method of calculation:")
    cli::cli_end()

    print(alerts)

  }
}
