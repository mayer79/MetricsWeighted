y <- 1:10
predicted <- 1.1 * y
theta <- seq(0.9, 1.3, by = 0.01)
two_models <- cbind(m1 = predicted, m2 = 1.2 * y)

test_that("Murphy diagram can be plotted without error message", {
  expect_no_error(murphy_diagram(y, two_models, theta = theta))
})

test_that("Murphy diagram with plot = FALSE gives data.frame", {
  expect_true(is.data.frame(murphy_diagram(y, two_models, theta = theta, plot = FALSE)))
})

