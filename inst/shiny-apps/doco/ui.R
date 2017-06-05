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
    column(4,
           wellPanel(
             helpText("Export your metaframe:"),
             # add a save and quit, and a just quit button
             downloadButton('downloadData', 'Download'),
             actionButton('rstudio', "Send to Global Env.")
           )
    ),
    column(10,
           helpText("Data"),
           dataTableOutput("dt"),
           style='padding:10px'
    ),
    column(10,
           helpText("Summary Stats"),
           tableOutput("sumtable"),
           style='padding:10px'
    )
    )
  )
)
