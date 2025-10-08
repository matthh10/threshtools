
test_that("check_threshold() detects overlapping thresholds",{

  x <- dplyr::tibble(
    indicator = c("a", "b"),
    low = c(0.5, 1.2),
    medium = c(1.1, 0.8),
    high = c(2.5, 3.1),
    very_high = c(3.7, 4.2)
  )

  y <- dplyr::tibble(
    indicator = "b",
    low = 1.2,
    medium = 0.8,
    high = 3.1,
    very_high = 4.2,
    alert = TRUE
  )

  expect_equal(check_thresholds(x), y)

})
