library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Interdisciplinary Science"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        selectInput(inputId = "in_dataset", 
                    label = "Choose a subheading",
                    choices = c("Technology","Physical Sciences","Life Sciences & Biomedicine"))
    ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)
