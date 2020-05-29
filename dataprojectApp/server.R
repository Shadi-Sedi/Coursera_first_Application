#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(data.table)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

 income <-read.csv(url("https://cpb-us-w2.wpmucdn.com/sites.udel.edu/dist/e/9437/files/2019/10/income-data.csv"),header= TRUE)
  colnames(income)<-c("Pop","World.Incom","USIncome")
    income$Pop<-income$Pop*100
    
   
model<- reactive({
    
    v3<-input$numeric
     
    pw3<-which (income$World.Incom==v3)
     if(length(pw3)==0){ 
    
    pw1<-max(which(income$World.Incom < v3))
    vw1<-income$World.Incom[pw1]
    pw2<-min(which(income$World.Incom > v3))
    vw2<-income$World.Incom[pw2]
    pw3<-(pw2-pw1)/(vw2-vw1)*(v3-vw2)+pw2
     }
    #print(paste("You are richer than ",as.character(pw3)))
    sprintf("You are richer than %3.1f%% people in the world", pw3)
  })
    
modelp<- reactive({
    
    v3<-input$numeric
    
    pu3<-which (income$USIncome==v3)
    
    if(length(pu3)==0){ 
         
         pu1<-max(which (income$USIncome < v3))
          vu1<-income$USIncome[pu1]
          pu2<-min(which (income$USIncome > v3))
          vu2<-income$USIncome[pu2]
         
           pu3<-(pu2-pu1)/(vu2-vu1)*(v3-vu2)+pu2
    } 
    sprintf("You are richer than %3.1f%% people in the US", pu3) 
}) 



output$distPlot=renderPlotly({

    distPlot<-plot_ly(data=income,x=~Pop,name="Income distribtuion") %>%
    add_lines(y = ~World.Incom, name= "World income distribution",color = I("#FFD700") ) %>%
    add_lines(y = ~USIncome, name= "US income distribution", color = I("#33CC33") ) %>%
    layout(title ="Income Distrbution", xaxis= list( title = "Percentage population"),
           yaxis = list( title = "Income"))%>%
    layout(plot_bgcolor='rgba(245, 245, 245,1)') 
})



 output$percent=renderText({
     if (input$world){
                 model() }
     })  
                
 

  output$percent2= renderText({
      if (input$US){
   modelp()}

  })   


})
