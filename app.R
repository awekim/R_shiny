library(shiny)
library(dplyr)
library(ggplot2)
# source('./WoS_shiny/WoS_intd_ui.R', local = TRUE)
# source('./WoS_shiny/WoS_intd_server.R')

# shinyApp(
#   ui = WoS_intd_ui,
#   server = WoS_intd_server
# )

# Define UI for application that draws a histogram
WoS_intd_ui <- shinyUI(fluidPage(
  
  # Application title 
  titlePanel("Interdisciplinary Science"),
    sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "in_dataset", 
                  label = "Choose a subheading",
                  choices = c("ALL","Technology","Physical Sciences","Life Sciences & Biomedicine"))),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput(outputId = "out_caption"),
      tableOutput(outputId = "table_1"),
      tableOutput(outputId = "table_2"),
      tableOutput(outputId = "table_3"),
      tableOutput(outputId = "table_4"),
      plotOutput(outputId = "yearly_count"))
    
  )
))

# Define server logic required to draw a histogram
WoS_intd_server <- shinyServer(function(input, output) {
  
  # receive values from the input
  datasetInput <- reactive({
    
    load(file="interd.set.shiny.RData")
    
    if (input$in_dataset =="ALL"){
      interd.set.shiny
    } else{
      interd.set.shiny %>% filter(subheading == input$in_dataset)
    }

  })
  
  tags$h1("Number of publications")
  output$table_1 <- renderTable({
    datasetInput() %>% group_by(subheading) %>% dplyr::summarise(publications=length(unique(pubid))) 
  })
  output$table_2 <- renderTable({
    datasetInput() %>% group_by(source) %>% dplyr::summarise(publications=length(unique(pubid))) %>% arrange(desc(publications)) %>% head(20)
  })
  output$table_3 <- renderTable({
    datasetInput() %>% group_by(Science) %>% dplyr::summarise(publications=length(unique(pubid))) %>% arrange(desc(publications))
  })
  output$table_4 <- renderTable({
    datasetInput() %>% group_by(source,Science) %>% dplyr::summarise(publications=length(unique(pubid))) %>% 
      group_by(Science) %>% arrange(desc(publications)) %>% slice(1)
  })
  
  output$yearly_count <- renderPlot({
    datasetInput() %>% group_by(pubyear,subheading) %>% dplyr::summarise(publications=length(unique(pubid))) %>%
      ggplot(aes(x=pubyear,y=publications,group=subheading)) + geom_line(aes(color=subheading)) + theme_bw()

  })
  
})

shinyApp(WoS_intd_ui, WoS_intd_server)

# rsconnect::deployApp("./WoS_shiny")
# runGitHub("Techevo_R-shiny","awekim")
