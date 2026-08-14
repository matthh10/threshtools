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


fun_test <- epi_stats(
  x,
  season = "2024/2025",
  epidemic_threshold = 2.9,
  week_col = week
)


test_that("epi_stats() works", {
  expect_equal(fun_test[[1]], 41)
})
