#Constructor tests

context("Test add_source")

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
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  outMD <- document(airquality, metadata = outMD)
  expect_error(add_source(outMD, src = "A person"), "src must be a list.")
  expect_error(add_source(outMD, src = list("A person")), "src list must be a named list.")
  expect_error(add_source(outMD, src = list("Dumb" = "A person")), 
               "Names of src must be in object@var_names.")
  expect_error(add_source(outMD, src = list("Month" = list("Cat" = "A person"))), 
               "Each src element must contain only named characters 'Name', 'Year', 'Citation', and 'Notes'.\n", fixed=TRUE)
  
})

context("Test add_label")

test_that("Metadata objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  MonthLabls <- list("Month" = "Month of observation")
  MonthLabls2 <- "Month of observation"; names(MonthLabls2) <- "Month"
  outMD2 <- add_label(outMD, label = MonthLabls)
  expect_identical(outMD2@labels$Month, "Month of observation")
  outMD2 <- add_label(outMD, label = MonthLabls2)
  expect_identical(outMD2@labels$Month, "Month of observation")
  expect_error(add_label(outMD, label = "Month of observation"), "label object must be named.")
  expect_error(add_label(outMD, label = list("Dumb" = "A person")), 
               "Names of label must be in object@var_names.")
})

test_that("Metaframe objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  testMF <- document(airquality, metadata = outMD); rm(data1)
  
  MonthLabls <- list("Month" = "Month of observation")
  MonthLabls2 <- "Month of observation"; names(MonthLabls2) <- "Month"
  outMD2 <- add_label(testMF, label = MonthLabls)
  expect_is(outMD2, c("meta.frame", "data.frame"))
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@labels$Month, "Month of observation")
  outMD2 <- add_label(testMF, label = MonthLabls2)
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@labels$Month, "Month of observation")
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  testMF <- document(airquality, metadata = outMD)
  expect_error(add_label(testMF, label = "Month of observation"), "label object must be named.")
  expect_error(add_label(testMF, label = list("Dumb" = "A person")), 
               "Names of label must be in object@var_names.")
})

context("Test add_note")

test_that("Metadata objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  MonthNote <- list("Month" = "Month was identified using star charts.")
  MonthNote2 <- "Month was identified using star charts."; names(MonthNote2) <- "Month"
  outMD2 <- add_note(outMD, note = MonthNote)
  expect_identical(outMD2@notes$Month, "Month was identified using star charts.")
  outMD2 <- add_note(outMD, note = MonthNote2)
  expect_identical(outMD2@notes$Month, "Month was identified using star charts.")
  expect_error(add_note(outMD, note = "Month was identified using star charts."), 
               "note object must be named.")
  expect_error(add_note(outMD, note = list("Dumb" = "A person")), 
               "Names of note must be in object@var_names.")
})

test_that("Metaframe objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  testMF <- document(airquality, metadata = outMD); rm(data1)
  
  MonthNote <- list("Month" = "Month was identified using star charts.")
  MonthNote2 <- "Month was identified using star charts."; names(MonthNote2) <- "Month"
  outMD2 <- add_note(testMF, note = MonthNote)
  expect_is(outMD2, c("meta.frame", "data.frame"))
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@notes$Month,  "Month was identified using star charts.")
  outMD2 <- add_note(testMF, note = MonthNote2)
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@notes$Month,  "Month was identified using star charts.")
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  testMF <- document(airquality, metadata = outMD)
  expect_error(add_note(testMF, note = "Month of observation"), "note object must be named.")
  expect_error(add_note(testMF, note = list("Dumb" = "A person")), 
               "Names of note must be in object@var_names.")
})


context("Test add_unit")

test_that("Metadata objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  MonthUnit <- list("Month" = "Month was identified using star charts.")
  MonthUnit2 <- "Month was identified using star charts."; names(MonthUnit2) <- "Month"
  outMD2 <- add_unit(outMD, unit = MonthUnit)
  expect_identical(outMD2@units$Month, "Month was identified using star charts.")
  outMD2 <- add_unit(outMD, unit = MonthUnit2)
  expect_identical(outMD2@units$Month, "Month was identified using star charts.")
  expect_error(add_unit(outMD, unit = "Month was identified using star charts."), 
               "unit object must be named.")
  expect_error(add_unit(outMD, unit = list("Dumb" = "A person")), 
               "Names of unit must be in object@var_names.")
})

test_that("Metaframe objects can be modified in place", {
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  data1 <- data(airquality)
  testMF <- document(airquality, metadata = outMD); rm(data1)
  
  MonthUnit <- list("Month" = "Month was identified using star charts.")
  MonthUnit2 <- "Month was identified using star charts."; names(MonthUnit2) <- "Month"
  outMD2 <- add_unit(testMF, unit = MonthUnit)
  expect_is(outMD2, c("meta.frame", "data.frame"))
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@units$Month,  "Month was identified using star charts.")
  outMD2 <- add_unit(testMF, unit = MonthUnit2)
  outMD <- attr(outMD2, "meta.data")
  expect_identical(outMD@units$Month,  "Month was identified using star charts.")
  outMD <- skel_reader(system.file("testdata/airqualityExample.csv",
                                   package="metaframe", mustWork=TRUE))
  testMF <- document(airquality, metadata = outMD)
  expect_error(add_unit(testMF, unit = "Month of observation"), "unit object must be named.")
  expect_error(add_unit(testMF, unit = list("Dumb" = "A person")), 
               "Names of unit must be in object@var_names.")
})