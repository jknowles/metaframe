library(shiny)
library(rhandsontable)

data <- data
if(is.null(data)){
  data <- data.frame(idx = 1:50, myvar = c(LETTERS[1:25], letters[1:25]),
                          domain = rep("", 50),
                          entity = rep("", 50),
                          category = rep("", 50),
                          element = rep("", 50),
                          stringsAsFactors = FALSE)
  md <- hot_to_r(skeleton(as.data.frame(data)))

} else{
  data <- data
  md <- hot_to_r(skeleton(as.data.frame(data)))
}

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
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
    data
  })

  output$hot <- renderRHandsontable({
    if(is.null(input$md)) {
      DF <- test_data
    } else 
      DF <- hot_to_r(input$hot)
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


