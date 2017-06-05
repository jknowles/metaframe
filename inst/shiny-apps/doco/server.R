

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
  
  # your action button condition
  exportData <- observe({
    if(input$rstudio > 0) {
      # create the new line to be added from your inputs
      out_data <- isolate(hot_to_r(input$hot))
      sum_data <- isolate(sumTable())
      out_data <- dplyr::bind_cols(out_data, sum_data)
      # update your data
      # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
      save_data <<- out_data
    }
    
  })
  
  sumTable <- reactive({
    skeleton(input_data)[, c("variable", "mode", "missing", "nunique", "class", 
                             "min", "Q1", "median", "Q3", "max", "sd")]
  })

  output$dt <- renderDataTable({
    input_data
  })
  
  output$sumtable <- renderTable({
    sumTable()
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
  session$onSessionEnded(function() { stopApp({
    out_data <- isolate(hot_to_r(input$hot))
    sum_data <- isolate(sumTable())
    dplyr::bind_cols(out_data, sum_data)
    })
  })
}
)



