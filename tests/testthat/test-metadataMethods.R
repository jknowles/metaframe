# Metadata methods

context("Summary methods")

test_that("Metadata can be read in from outside sources", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  expect_is(outMD, "meta.data")
  data1 <- data(airquality)
  newdata1 <- document(airquality, metadata = outMD)
  expect_is(newdata1, c("meta.frame", "data.frame"))
  expect_identical(slotNames(outMD), c("labels", "units", "notes", "sources", "revisions", 
                                       "var_names", "obs_names", "summary", "Rname",".S3Class"))
})

test_that("Metadata objects can be printed", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  # hack to avoid console output
  zz <- capture.output(print(outMD))
  expect_is(zz, "character")
  expect_equal(length(zz), 52)
})


test_that("Metadata objects can be summarized", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  zz <- capture.output(summary(outMD))
  expect_equal(length(zz), 13)
  # expect_output(summary(outMD), "Percentage of meta.data complete:")
  expect_is(summary(outMD), "summary.meta.data")
  # expect_output(str(outMD), "Object of class meta.data with slots:", all = FALSE,ignore.case = TRUE)
})

test_that("Metadata objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  MonthSrc <- list("Month" = list("Name" = "A Person", "Year" = 1973, 
                                  "Citation" = "Not available", 
                                  "Notes" = "Must I cite a month?"))
  outMD2 <- add_source(outMD, src = MonthSrc)
  expect_identical(outMD2@sources$Month$Name, "A Person")
  expect_identical(outMD2@sources$Month$Year, 1973)
  expect_identical(outMD2@sources$Month$Citation, "Not available")
  expect_identical(outMD2@sources$Month$Notes, "Must I cite a month?")
  expect_error(add_source(outMD, src = "A person"), "src must be a list.")
  expect_error(add_source(outMD, src = list("A person")), "src list must be a named list.")
  expect_error(add_source(outMD, src = list("Dumb" = "A person")), 
               "Names of src must be in object@var_names.")
  expect_error(add_source(outMD, src = list("Month" = list("Cat" = "A person"))), 
               "Error in add_source.meta.data(outMD, src = list(Month = list(Cat = \"A person\"))) : \n  Each src element must contain only named characters 'Name', 'Year', 'Citation', and 'Notes'.\n", fixed=TRUE)
  
})


test_that("Metaframe objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  outMD <- document(airquality, metadata = outMD); rm(data1)
  MonthSrc <- list("Month" = list("Name" = "A Person", "Year" = 1973, 
                                  "Citation" = "Not available", 
                                  "Notes" = "Must I cite a month?"))
  outMD2 <- add_source(outMD, src = MonthSrc)
  expect_is(outMD2, c("meta.frame", "data.frame"))
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@sources$Month$Name, "A Person")
  expect_identical(outMD@sources$Month$Year, 1973)
  expect_identical(outMD@sources$Month$Citation, "Not available")
  expect_identical(outMD@sources$Month$Notes, "Must I cite a month?")
  expect_error(add_source(outMD, src = "A person"), "src must be a list.")
  expect_error(add_source(outMD, src = list("A person")), "src list must be a named list.")
  expect_error(add_source(outMD, src = list("Dumb" = "A person")), 
               "Names of src must be in object@var_names.")
  expect_error(add_source(outMD, src = list("Month" = list("Cat" = "A person"))), 
               "Error in add_source.meta.data(outMD, src = list(Month = list(Cat = \"A person\"))) : \n  Each src element must contain only named characters 'Name', 'Year', 'Citation', and 'Notes'.\n", fixed=TRUE)
  
})

