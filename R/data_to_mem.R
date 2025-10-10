#' Transform aggregated data table into format accepted by `mem::memmodel()`
#'
#' @param data Aggregated weekly counts of class `data.table` or `tbl` of with
#'  rows as weeks columns for rate and flu season
#'  (see `threshtools::find_flu_season()`)
#' @param seasons A vector or single character string in format *"YYYY/YYYY"*
#' @param duplicate Boolean operator which controls whether single seasons
#'  should be duplicated to force acceptance by `mem::model()` (default = `TRUE`)
#' @param season_length Number of weeks in flu season (default = 33)
#'
#' @return Transformed `tbl` with rows as weeks and each season as a column.
#'  Week 53 is preserved if present as it is handled by `mem::model()` and
#'  NAs are supplied to seasons without week 53.
#' @export
#'
#' @examples
#'
#' # Create dummy data
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


#' data_to_mem(
#' x,
#' seasons = c("2023/2024", "2024/2025"),
#' week_col = week,
#' year_col = year,
#' season_col = flu_season,
#' rate_col = rate,
#' season_length = 33
#' )
#'
#'


data_to_mem <- function(data, seasons, duplicate = TRUE, season_length = 33,
                        year_col = year, week_col = iso_week,
                        season_col = flu_season, rate_col = rate){

  if(length(seasons) > 1 | duplicate == FALSE){

    # If at least 2 seasons are provided or duplicate = FALSE, format as normal

    output <- data |>
      dplyr::filter({{season_col}} %in% seasons) |>
      dplyr::arrange({{year_col}}, {{week_col}}) |>
      tidyr::pivot_wider(
        id_cols = {{week_col}},
        names_from = {{season_col}},
        values_from = {{rate_col}},
        values_fill = NA
      ) |>
      dplyr::slice(1:season_length) |>
      dplyr::select(-{{week_col}})

  } else {

    # If only one season is provided, duplicate to force memmodel to accept

    sim_data <- data |>
      dplyr::filter({{season_col}} == seasons) |>
      dplyr::mutate(season_col = dplyr::case_when({{season_col}} == seasons ~ paste0("sim_", {{season_col}}),
                                    TRUE ~ {{season_col}})) |>
      dplyr::bind_rows(
        data |>
          dplyr::filter({{season_col}} == seasons)
      )

    output <- sim_data |>
      dplyr::filter({{season_col}} %in% seasons) |>
      dplyr::arrange({{year_col}}, {{week_col}}) |>
      tidyr::pivot_wider(
        id_cols = {{week_col}},
        names_from = {{season_col}},
        values_from = {{rate_col}},
        values_fill = NA
      ) |>
      dplyr::slice(1:season_length) |>
      dplyr::select(-{{week_col}})

  }
  return(output)
}
