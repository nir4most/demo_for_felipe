#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



total_combinations <- tibble::tribble(
  ~pollutant, ~station,
        "a1",     "s1",
        "b2",     "s1",
        "c3",     "s1",
        "a1",     "s2",
        "b2",     "s2"
  )



library(shiny)
library(shinyWidgets)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "pollutant_picker",
                        label = "Pick your pollutant",
                        choices = unique(total_combinations$pollutant),
                        selected = unique(total_combinations$pollutant)[[1]],
                        multiple = FALSE
        ),
        selectInput(inputId = "stations_picker",
                    label = "Pick your stations",
                    choices = NULL,
                    selected = NULL,
                    multiple = TRUE
        ),
        )
        ,

        # Show a plot of the generated distribution
        mainPanel(
         
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    observeEvent(input$pollutant_picker,
                 {
                   result <-  total_combinations %>% 
                         filter( pollutant == input$pollutant_picker) %>%
                       pull(station) %>% unique()
                   
                   print("updateSelectInput")
                   updateSelectInput(session=session,
                                     inputId = "stations_picker",
                                     choices = result,
                                     select = result[[1]]
                                     )
                 })
   
}

# Run the application 
shinyApp(ui = ui, server = server)
