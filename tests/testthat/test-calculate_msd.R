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

fun_test <- calculate_msd(x)

test_that("calculate_msd() works", {
  expect_true(
    fun_test$mean_rate == round(mean(x$rate), 2)
    )
})
