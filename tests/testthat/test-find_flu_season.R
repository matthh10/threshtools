
test_that("find_flu_season() finds flu season from date", {
  expect_true(
    find_flu_season(as.Date("2023-11-15")) == "2023/2024"
  )
})
