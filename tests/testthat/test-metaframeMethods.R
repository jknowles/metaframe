
context("Summary methods")

test_that("Metadata can be read in from outside sources", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  expect_is(outMD, "meta.data")
  data1 <- data(airquality)
  newdata1 <- document(airquality, metadata = outMD)
  expect_is(newdata1, c("meta.frame", "data.frame"))
  expect_identical(slotNames(attr(newdata1, "meta.data")), 
                   c("labels", "units", "notes", "sources", "revisions", 
                     "var_names", "obs_names", "summary", "Rname",".S3Class"))
})

test_that("Metadata objects can be printed", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  newdata1 <- document(airquality, metadata = outMD)
  zz <- capture.output(print(newdata1))
  expect_is(zz, "character")
  # expect_output(print(newdata1), "Showing metadata for object", all = FALSE, 
  #               ignore.case = TRUE)
  
})


test_that("Metadata objects can be summarized", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  newdata1 <- document(airquality, metadata = outMD)
  zz <- capture.output(summary(newdata1))
  expect_is(zz, "character")
  # expect_output(summary(newdata1), "Percentage of meta.data complete:")
  # expect_is(summary(newdata1), "summary.meta.data")
  zz <- capture.output(str(newdata1))
  expect_is(zz, "character")
  # expect_output(str(newdata1), "Object of class meta.data with slots:", all = FALSE)
})


