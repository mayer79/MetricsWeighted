test_that("Murphy diagram can be plotted without error message", {
  y <- 1:10
  predicted <- 1.1 * y
  murphy_diagram(y, predicted, theta = seq(0.9, 1.2, by = 0.01))
  two_models <- cbind(m1 = predicted, m2 = 1.2 * y)

  expect_no_error(murphy_diagram(y, two_models, theta = seq(0.9, 1.3, by = 0.01)))
})

