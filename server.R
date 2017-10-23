# Author: Abas Mohamed
# Data Application
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        maindata2 <- read.csv("dataone.csv",header = TRUE,stringsAsFactors = FALSE)
        output$mpgPlot <- renderPlot({
                
                require(ggplot2)
                var3 <- input$select
                plt <-  ggplot(maindata2,aes_string(x=var3)) + geom_histogram(col="black",fill=input$selectcol, bins = as.numeric(input$slider))+
                        theme_minimal()
                print(plt)
                
                
                
                
                
                
                
                
                
                
        }) # end of renderplot
        
        plot10 <- reactive({ggplot(iris, aes(x=iris$Sepal.Length))+ geom_histogram()})
        
        
        
        output$download <- downloadHandler(filename =function(){paste(input$select,input$filetype,sep =".")}
                                           ,
                                           content =  function(file){
                                                   if(input$filetype == "png")
                                                           png(file)
                                                   else
                                                           pdf(file)
                                                   
                                                   
                                                   require(ggplot2)
                                                   plt <-  ggplot(maindata2,aes_string(x=input$select)) + geom_histogram(col="black",fill=input$selectcol, bins = as.numeric(input$slider))+
                                                           theme_minimal()
                                                   print(plt)
                                                   dev.off()
                                                   
                                                   
                                                   
                                           }
                                           
                                           
                                           
        )
        # Scaterplot section ----------------------------------------------------------------------------------------
        output$scater1 <- renderPlot({
                maindata2 <- read.csv("dataone.csv",header = TRUE,stringsAsFactors = FALSE)
                xvarone <- input$xcol
                yvarone <- input$ycol
                
                ggplot(maindata2,aes_string(xvarone,yvarone)) + geom_point() + theme_minimal()
                
                
                
                
                
        })
        
        output$cor <- renderPlot({
                maindata2 <- read.csv("dataone.csv",header = TRUE,stringsAsFactors = FALSE)
                require(psych)
                xvarone <- input$xcol
                yvarone <- input$ycol
                corelationdata <- subset(maindata2, select = c(input$xcol,input$ycol))
                pairs.panels(corelationdata)  
                
                
        })
        output$alldownload <- downloadHandler(filename = function(){paste("alldata","pdf",sep =".")},
                                              content = function(file){
                                                      pdf(file)
                                                      require(psych)
                                                      maindata2 <- read.csv("dataone.csv",header = TRUE,stringsAsFactors = FALSE)
                                                      xvarone <- input$xcol
                                                      yvarone <- input$ycol
                                                      corelationdata <- subset(maindata2, select = c(input$xcol,input$ycol))
                                                      pairs.panels(corelationdata) 
                                                      
                                                      #ggplot(maindata2,aes_string(xvarone,yvarone)) + geom_point() + theme_minimal()
                                                      
                                                      dev.off()
                                              })
        
        
        
        output$table <- DT::renderDataTable({
                
                
                datatable1 <- read.csv("dataone.csv",
                                       header = input$header,
                                       sep = input$sep,
                                       quote = input$quote,
                                       stringsAsFactors = input$stringAsFactors,nrows =input$dataslider)
                
                DT::datatable(datatable1,
                              options = list(
                                      dom = 'T<"clear">lfrtip',
                                      columnDefs = list(list(width = '20%', targets = list(2,3,4))),
                                      deferRender=TRUE,
                                      scrollX=TRUE,
                                      scrollCollapse=TRUE,
                                      pageLength = 100, lengthMenu = c(10,50,100,200),
                                      autoWidth = TRUE,
                                      scrollY = 300
                                      
                              )
                              
                ) # end of Dt::  
                
                
                
        })
        
        output$download1 <- downloadHandler(filename =function(){paste("datatable","csv",sep =".")}, content = function(file){
                datatable1 <- read.csv("dataone.csv",
                                       header = input$header,
                                       sep = input$sep,
                                       quote = input$quote,
                                       stringsAsFactors = input$stringAsFactors,nrows =input$dataslider)
                
                write.csv(datatable1,file,row.names=FALSE)  
        })
        
        output$suma <- renderPrint({
                datatable1 <- read.csv("dataone.csv",stringsAsFactors = FALSE)
                summary(datatable1)
        })
        
        
        
        
        
        
})
