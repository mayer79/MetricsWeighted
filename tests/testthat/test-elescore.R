test_that("measures with weight 1 gives same as unweighted", {
  y <- 1:10
  pred <- c(1:9, 12)
  w <- rep(1, length(y))

    expect_equal(elementary_score_quantile(y, pred, alpha = 0.5, theta = 11),
               elementary_score_quantile(y, pred, alpha = 0.5, theta = 11,
                                         w = w))
  expect_equal(elementary_score_expectile(y, pred, alpha = 0.5, theta = 11),
               elementary_score_expectile(y, pred, alpha = 0.5, theta = 11,
                                          w = w))
})

test_that("measures with weight 1 gives same as weight 2", {
  y <- 1:10
  pred <- c(1:9, 12)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))

  expect_equal(elementary_score_quantile(y, pred, alpha = 0.5, theta = 11,
                                         w = w1),
               elementary_score_quantile(y, pred, alpha = 0.5, theta = 11,
                                         w = w2))
  expect_equal(elementary_score_expectile(y, pred, alpha = 0.5, theta = 11,
                                          w = w1),
               elementary_score_expectile(y, pred, alpha = 0.5, theta = 11,
                                          w = w2))
})

test_that("measures with non-constant weight have an effect", {
  y <- 1:10
  pred <- c(1:9, 12)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))

  expect_equal(elementary_score_quantile(y, pred, alpha = 0.5, theta = 11,
                                         w = w1),
               elementary_score_quantile(y, pred, alpha = 0.5, theta = 11,
                                         w = w2))
  expect_equal(elementary_score_expectile(y, pred, alpha = 0.5, theta = 11,
                                          w = w1),
               elementary_score_expectile(y, pred, alpha = 0.5, theta = 11,
                                          w = w2))
})
