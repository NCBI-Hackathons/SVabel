library(supersnv)

library(testthat)



test_that("test that addition() works", {

    expect_equal(addition(2,3), 5)
    expect_equal(addition(0.0, 0.0), 0)
    expect_equal(addition(5, -5), 0)
    ## expect errors if input not numeric
    expect_error(addition('a', 2))
    expect_error(addition(10, 'b'))
    expect_error(addition('a', 'b'))

})

