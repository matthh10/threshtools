
#' Extracts memmodel outputs and transforms into tidy format
#'
#' @param mem_model Output from `mem::memmodel`
#' @param decimal_places Number of decimal places thresholds should be rounded to
#'
#' @return `tbl` of low, medium, high and very high thresholds, with key stats on
#'  mean start week, mean length of epidemic, effective number of pre-epidemic
#'  values (`n_max`) and number of seasons included in the model (`n_seasons`)
#' @export
#'

tidy_mem <- function(mem_model, decimal_places = 2){
  mem_thresholds <-
    tibble::tibble(
      threshold = c("low_threshold", "medium_threshold", "high_threshold", "very_high_threshold"),
      value =
        janitor::round_half_up(
          c(mem_model$epidemic.thresholds[1], # the value for Epidemic Start (i.e. Low)
            mem_model$intensity.thresholds), # Thresholds for further activity levels
          decimal_places # Round to x decimal places
        )
    ) |>
    tidyr::pivot_wider(names_from = threshold, values_from = value) |>
    dplyr::mutate(mean_start = c(seq(40,52,1), seq(1,39,1))[mem_model$mean.start], #'mean.start' is the mean start week where wk40 = 1, so is equivalent to the index of a vector of weeks
           mean_length = mem_model$mean.length, # Mean length
           n_max = mem_model$n.max, # Effective number of pre epidemic values.
           n_seasons = mem_model$n.seasons)

  return(mem_thresholds)
}

