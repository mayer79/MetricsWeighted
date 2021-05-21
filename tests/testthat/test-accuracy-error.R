context("Accuracy and classification error")

test_that("accuracy works without weights", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  expect_equal(accuracy(y, pred), 2 / 3)
})

test_that("classification error works without weights", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  expect_equal(classification_error(y, pred), 1 / 3)
})

test_that("accuracy with weight 1 gives same as unweighted", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  w <- rep(1, length(y))
  expect_equal(accuracy(y, pred, w), accuracy(y, pred))
})

test_that("accuracy with weight 2 gives same as weight 1", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(accuracy(y, pred, w1), accuracy(y, pred, w2))
})

test_that("accuracy with varying weights is different from unweighted", {
  y <- c(0, 1, 0)
  pred <- c(0, 1, 1)
  w <- 1:3
  expect_false(accuracy(y, pred, w) == accuracy(y, pred))
})
