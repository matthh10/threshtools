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
    cli::cli_alert_info("Check the following thresholds and consider changing method of caclulation:")
    cli::cli_end()

    print(alerts)

  }
}
