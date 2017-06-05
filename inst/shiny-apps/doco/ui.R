library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Document Your Data"),

  fluidRow(
    column(10,
           helpText("Input Metadata"),
           rHandsontableOutput("hot"),
           style='padding:10px'
    ),
    column(10,
           helpText("Data"),
           dataTableOutput("dt"),
           style='padding:10px'
    ),
    column(4,
           wellPanel(
             helpText("Export your metaframe:"),
             downloadButton('downloadData', 'Download'),
             actionButton('exportData', "Send to RStudio")
       )
      )
    )
  )
)
