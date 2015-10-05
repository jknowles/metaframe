
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
  expect_output(print(outMD), "Showing metadata for object", all = FALSE, 
                ignore.case = TRUE)
  
})


test_that("Metadata objects can be summarized", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  expect_output(summary(outMD), "Percentage of meta.data complete:")
  expect_is(summary(outMD), "summary.meta.data")
  expect_output(str(outMD), "Object of class meta.data with slots:", all = FALSE)
})


