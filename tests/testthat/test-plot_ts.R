
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

fun_test <- x |>
  dplyr::mutate(week_date = as.Date(grates::isoweek(year = year, week = week))) |>
  plot_ts()

test_that("multiplication works", {
  expect_true(
    "ggplot" %in% class(fun_test)
  )
})
