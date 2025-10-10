
x <- tibble::tribble(
  ~week, ~year, ~flu_season,  ~rate,
  40,    2023,  "2023/2024",  2.5,
  41,    2023,  "2023/2024",  3.1,
  42,    2023,  "2023/2024",  4.2,
  40,    2024,  "2024/2025",  2.5,
  41,    2024,  "2024/2025",  3.1,
  42,    2024,  "2024/2025",  4.2,
  40,    2025,  "2025/2026",  2.5,
  41,    2025,  "2025/2026",  3.1,
  42,    2025,  "2025/2026",  4.2,
)

fun_test <- data_to_mem(
  x,
  seasons = c("2023/2024", "2024/2025"),
  week_col = week,
  year_col = year,
  season_col = flu_season,
  rate_col = rate,
  season_length = 33
)

test_that("data_to_mem() converts agg table to me format", {
  expect_true(
    ncol(fun_test) == 2,
    nrow(fun_test) == 3,
    class(fun_test) %in% c("tbl_df", "tbl", "data.frame")
  )
})
