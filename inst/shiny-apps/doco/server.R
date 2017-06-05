library(shiny)
library(rhandsontable)

test_data <- NULL
if(is.null(test_data)){
  test_data <- data.frame(idx = 1:50, myvar = c(LETTERS[1:25], letters[1:25]),
                          domain = rep("", 50),
                          entity = rep("", 50),
                          category = rep("", 50),
                          element = rep("", 50),
                          stringsAsFactors = FALSE)

} else{
  test_data <- hot_to_r(test_data)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  observe({
    # We'll use these multiple times, so use short var names for
    # convenience.
    domain <- input$domain
    # Text =====================================================
    # Change both the label and the text
    s_options <- as.list(as.character(unique(CEDS$entity[CEDS$domain == domain])))
    names(s_options) <- as.character(unique(CEDS$entity[CEDS$domain == domain]))
    # Change values for input$inSelect
    entity <- input$entitySelect
  updateSelectInput(session, "entitySelect",
                    choices = s_options,
                    selected = ifelse(!is.null(entity), entity,
                                      s_options[[1]]))

  if(is.na(entity) | is.null(entity)){
    c_options <- as.list("")
    names(c_options) <- ""
  }else{
    c_options <- as.list(as.character(unique(CEDS$category[CEDS$domain == domain & CEDS$entity == entity])))
    names(c_options) <- as.character(unique(CEDS$category[CEDS$domain == domain & CEDS$entity == entity]))
  }
  category <- input$catSelect

  updateSelectInput(session, "catSelect",
                    choices = c_options,
                    selected = ifelse(!is.null(category), category,
                                      ""))

  if(is.na(category) | is.null(category) | category == ""){
    elem_options <- as.list(as.character(unique(CEDS$`Element Name`[CEDS$domain == domain & CEDS$entity == entity])))
    names(elem_options) <- as.character(unique(CEDS$`Element Name`[CEDS$domain == domain & CEDS$entity == entity]))
  } else{
    elem_options <- as.list(as.character(unique(CEDS$`Element Name`[CEDS$domain == domain &
                                                             CEDS$entity == entity &
                                                             CEDS$category == category])))
    names(elem_options) <- as.character(unique(CEDS$`Element Name`[CEDS$domain == domain &
                                                            CEDS$entity == entity &
                                                            CEDS$category == category]))
  }
  output$fields = renderUI(HTML({
    zzz <- names(elem_options)
    zzz <- as.character(zzz)
    names(zzz) <- NULL
    zzz <- sapply(zzz, function(x) as.character(tags$li(x)))
    zzz
  }))
# Note that download button does not work in RStudio viewer
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
      data <- hot_to_r(input$hot)
      write.csv(data, file)
    }
  )

  # Consider ease of maintenance by making this pop up
  # output$rstudio <- eventReactive(input$exportData, {
  #   rslt <- capture.output(dput(hot_to_r(input$hot)))
  #   rstudioapi::insertText(Inf, paste0("CEDS_map = ",
  #                                      paste(rslt, collapse = "\n")))
  #
  # })

  output$hot <- renderRHandsontable({
    if(is.null(input$hot)) {
      DF <- test_data
    } else DF <- hot_to_r(input$hot)
    rhandsontable(DF, rowHeaders = NULL, stretchH = "all", height = 300) %>%
      hot_rows(fixedRowsTop = 1) %>%
      hot_col(col = "domain", type = "dropdown", source = input$domain) %>%
      hot_col(col = "entity", type = "dropdown", source = names(s_options)) %>%
      hot_col(col = "category", type = "dropdown", source = names(c_options)) %>%
      hot_col(col = "element", type = "dropdown", source = names(elem_options))
  })


})

}
)


