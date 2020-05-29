#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(shiny)
library(plotly)
library(shinyWidgets)
library(data.table)

# Define UI for application that draws a histogram
shinyUI( fluidPage (
    
    setBackgroundColor(
        color = c("#F5FFFA")),
        tags$head(
             tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
    "))
          
     
     ),
        
    # Application title
    headerPanel( h1( "How rich am I ?",
               style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #D8BFD8;")       
               
              
               ),
    

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("numeric", "Enter your annual income in US dollar.",value = 1000),
            checkboxInput("world","show me how rich I am in the world",value = FALSE),
            checkboxInput("US","show me how rich I am in the USA",value = FALSE),
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            
            plotlyOutput("distPlot"),
            
            h3("World!"),
            textOutput("percent"), 
           
           
            h3("United States!"),
             textOutput("percent2"),
            
            
        )
    )
))
