

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  if(is.null(input_data)){
    input_data <- data.frame(idx = 1:50, myvar = c(LETTERS[1:25], letters[1:25]),
                             domain = rep("", 50),
                             entity = rep("", 50),
                             category = rep("", 50),
                             element = rep("", 50),
                             stringsAsFactors = FALSE)
    md <- as.data.frame(skeleton(input_data)[, c("variable", "labels", "units", 
                                                       "notes", "sources.name", 
                                                       "sources.year", 
                                                       "sources.citation", 
                                                       "sources.notes", 
                                                       "revisions")])
    
  } else{
    md <- as.data.frame(skeleton(input_data)[, c("variable", "labels", "units", 
                                                       "notes", "sources.name", 
                                                       "sources.year", 
                                                       "sources.citation", 
                                                       "sources.notes", 
                                                       "revisions")])
  }
  
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
  output$dt <- renderDataTable({
    input_data
  })
  
  output$sumtable <- renderTable({
    skeleton(input_data)[, c("variable", "mode", "missing", "nunique", "class", 
                       "min", "Q1", "median", "Q3", "max", "sd")]
  })

  observe({
    output$hot <- renderRHandsontable({
      if(is.null(input$hot)) {
        DF <- md
      } else 
        DF <- hot_to_r(input$hot)
      rhandsontable(DF, rowHeaders = NULL, stretchH = "all", height = 300) %>%
        hot_rows(fixedRowsTop = 1)
    })
    
  })
  
}
)



