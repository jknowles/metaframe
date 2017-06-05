library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("CEDS Alignment Mapper"),

  fluidRow(
    column(10,
           helpText("Placeholder"),
           rHandsontableOutput("hot"),
           style='padding:10px'
    ),
    column(4,
           wellPanel(
             helpText("Select the categories of the CEDS domain specification
                      that you are looking to map:"),
             selectInput("domain", "CEDS Domain",
                         unique(CEDS$domain),
                         selected = "K12"),
             # uiOutput("entitySelect"),
             # uiOutput("catSelect"),
             selectInput("entitySelect", "CEDS Entity",
                         c("label 1" = "option1",
                           "label 2" = "option2"),
                         selected = "A"),
             selectInput("catSelect", "CEDS Category",
                         c("label 1" = "option1",
                           "label 2" = "option2"),
                         selected = "A"),
             downloadButton('downloadData', 'Download'),
             actionButton('exportData', "Send to RStudio")
           )
    ),
    column(6,
           wellPanel(
             helpText("Suggested Element Names based on your selections"),
             uiOutput("fields")
             # textOutput("debug")
           )
    )

  )
)
)

# Allow for dropdown selection to restrict domain, category, and entity in the
# autocomplete
