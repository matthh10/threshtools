#' Find the flu season a date belongs to (Week 40 to Week 39 of next year)
#'
#' This function determines the flu season for a given date, where a flu season
#' runs from Week 40 of one year until Week 39 of the following year (inclusive).
#' This means there is no "inter-season" period; every date falls into a season.
#'
#' @param date A date object or a vector of date objects (e.g., as.Date("2023-11-15")).
#' @param start_week Iso week that season starts on.
#'
#' @return A character string indicating the flu season in "YYYY/YYYY" format
#'         (e.g., "2023/2024"), or a vector of such strings if a vector of dates is provided.
#'         Returns NA_character_ if the input is not a valid date.
#' @examples
#' find_flu_season(as.Date("2023-11-15")) # Expected: "2023/2024"
#' find_flu_season(as.Date("2024-03-01")) # Expected: "2023/2024"
#' find_flu_season(as.Date("2024-08-20")) # Expected: "2023/2024" (now in season)
#' find_flu_season(as.Date("2023-01-05")) # Expected: "2022/2023"
#' find_flu_season(as.Date("2023-09-30")) # Expected: "2022/2023" (Sunday, Week 39)
#' find_flu_season(as.Date("2023-10-01")) # Expected: "2023/2024" (Monday, Week 40)
#' find_flu_season(as.Date("2024-09-29")) # Expected: "2023/2024" (Sunday, Week 39)
#' find_flu_season(as.Date("2024-09-30")) # Expected: "2024/2025" (Monday, Week 40)
#' find_flu_season(c(as.Date("2023-11-15"), as.Date("2024-01-20"), as.Date("2024-07-10")))

find_flu_season <- function(date, start_week = 40) {
  if (!inherits(date, "Date") && !inherits(date, "POSIXt")) {
    warning("Input 'date' must be a Date or POSIXt object. Returning NA.")
    return(NA_character_)
  }

  # Use isoyear() and isoweek() to get the correct ISO year and week
  iso_year <- lubridate::isoyear(date)
  iso_week <- lubridate::isoweek(date)

  # Initialize the output vector
  flu_season_vec <- rep(NA_character_, length(date))

  for (i in seq_along(date)) {
    if (is.na(date[i])) {
      flu_season_vec[i] <- NA_character_
      next
    }

    # Get the correct ISO year and week for the date
    current_iso_year <- iso_year[i]
    current_iso_week <- iso_week[i]

    # If the ISO week is greater or equal to start week (default 40),
    # it belongs to the season that starts in the current ISO year and
    # ends in the next.
    if (current_iso_week >= start_week) {
      flu_season_vec[i] <- paste0(current_iso_year, "/", current_iso_year + 1)
    }
    # If the ISO week is less than 40, it belongs to the season
    # that started in the previous ISO year.
    else {
      flu_season_vec[i] <- paste0(current_iso_year - 1, "/", current_iso_year)
    }
  }
  return(flu_season_vec)
}
