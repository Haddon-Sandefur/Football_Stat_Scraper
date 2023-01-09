#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)  # for the diamonds dataset

ui <- fluidPage(
  title = "College Football Data Viewer",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "master_set"',
        checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                           names(master_set), selected = names(master_set))
      ),
      conditionalPanel(
        'input.dataset === "master_avg"',
        helpText("Click the column header to sort a column.")
      ),
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("master_set", DT::dataTableOutput("mytable1")),
        tabPanel("master_avg", DT::dataTableOutput("mytable2")),
      )
    )
  )
)

server <- function(input, output) {

  # sorted columns are colored now because CSS are attached to them
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(master_avg, options = list(orderClasses = TRUE))
  })
  
  # customize the length drop-down menu; display 5 rows per page by default
  
}

shinyApp(ui, server)