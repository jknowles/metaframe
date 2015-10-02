# Overall unit tests

context("Test that metaframes are data.frame compatible")

test_that("Basic functions do not throw errors", {
  data(airquality)
  outMD <- document(airquality)
  expect_is(outMD, c("meta.frame", "data.frame"))
  expect_identical(slotNames(attr(outMD, "meta.data")), c("sources", "units", "labels", "notes", "revisions", 
                                       "var_names", "obs_names", "summary", "Rname",".S3Class"))
})


test_that("Skeleton reader works", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  expect_is(outMD, "meta.data")
  expect_identical(slotNames(outMD), c("sources", "units", "labels", "notes", "revisions", 
                                       "var_names", "obs_names", "summary", "Rname",".S3Class"))
})



