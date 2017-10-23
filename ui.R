# Author: Abas Mohamed
# Data Application
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
#
#
maindata2 <- read.csv("dataone.csv",header = TRUE,stringsAsFactors = FALSE)
library(shiny)
require(markdown)

# Define UI for application that draws a histogram
shinyUI( fluidPage(
        
        tags$style(HTML("p{width:1200px}")),
        # Show the caption and plot of the requested variable against mpg
        tags$style(type="text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"
        ),
        
        fluidRow(
                tabsetPanel( tabPanel("Documentation", mainPanel(
                        #includeMarkdown("include.md")
                        tags$div(
                                tags$h1("Interactive data visualization with shiny."),
                                tags$h5("Author: Abas Mohamed ---22/10/2017"),
                                tags$br(),
                                
                                tags$p("The goal of this application is to give the user
                                       of this application the maximum flexibility for deriving a clear insight form the data.
                                       This application evaluates diabetes data which covers A population of women who were at least 21 years old, of Pima Indian heritage
                                       and living near Phoenix, Arizona and was tested for diabetes according to World Health Organization criteria. 
                                       The data were collected by the US National Institute of Diabetes and Digestive and Kidney Diseases. 
                                       To understand more about the disease factor, the user is invited to manipulate the different variables that are presented in the application.
                                       This will lead a solid understanding about the relationship amongst the variables.  The data has 768 rows and 9 variables including the target 
                                       variable which is coded as 1 and 0 indicating disease or no-disease based on the information provided in the data. Here are the variables that are presented in the data:"
                                ),
                                tags$br(),
                                tags$li("the variable pregnancy is the Number of times pregnant"),
                                tags$li("the variable Glucose is the Plasma glucose concentration a 2 hours in an oral glucose tolerance test "),
                                tags$li("The variable Blood-pressure is the Diastolic blood pressure (mm Hg)"),
                                tags$li("The variable Skin Thickness is the Triceps skin fold thickness (mm)"),
                                tags$li("Insulin is rhe 2-Hour serum insulin (mu U/ml)"),
                                tags$li("BMI is the Body mass index (weight in kg/(height in m)^2)"),
                                tags$li("Diabetes pedigree function "),
                                tags$li("Age (years)"),
                                tags$li("Class is a variable coded as  (0 or 1) "),
                                tags$a(href="https://github.com/hamza-abas/dataproduct","You can Click here to see the code in github"), tags$p("the app has four mature parts, the first one presents a histogram of the data where the user is able to 
                                                                                                       manipulate and download the plot. The second section of the app covers two important data visualization, 
                                                                                                       one which shows the relationship between the two variables that are selected and the other one which shows 
                                                                                                       the strength of the relationship which called correlation plot. The third tab-panel provides the data table 
                                                                                                       in which the user can filter the data and retrieve any selected rows. Last but not least you will find a data summary.
                                                                                                       Have a look. Many Thanks ")
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                ) # end of div tag
                                )
                        ),
                        tabPanel("Histogram",
                                 column(9,
                                        h3(textOutput("caption")),
                                        
                                        plotOutput("mpgPlot")
                                 ),
                                 
                                 column(3,
                                        selectInput("select", "select variable",choices = names(maindata2)),
                                        selectInput("selectcol", "SelectColour",list("blue"="blue",
                                                                                     "red"="red",
                                                                                     "purple"="purple",
                                                                                     "green"="green",
                                                                                     "orange"="orange"), selected ="purple"),
                                        sliderInput("slider", "Number of bins in histogram", value = 50, min = 1,max = 75),
                                        tags$hr(),
                                        h5(helpText("Download by file type")),
                                        radioButtons("filetype", "Select the file type", choices = list("png","pdf")),
                                        downloadButton("download", "Download")
                                        
                                        
                                 ) # en of column
                                 
                                 
                                 
                                 
                        ), # end of histo
                        # End of tabpanel
                        tabPanel("ScaterPlot",
                                 column(6,
                                        
                                        plotOutput("scater1")
                                 ),
                                 column(4,plotOutput("cor")),
                                 column(2,
                                        
                                        
                                        selectInput('xcol', 'X Variable',choices = names(maindata2)),
                                        selectInput('ycol', 'Y Variable',choices = names(maindata2), selected =names(maindata2)[2]),
                                        
                                        downloadButton("alldownload","Download") 
                                        
                                        
                                        
                                 )# end of column
                        ), # End of tabpanel
                        tabPanel("Table",
                                 column(8,
                                        DT::dataTableOutput("table")   ),
                                 column(3,
                                        h5(helpText("Select the read.table parameters below")),
                                        # Input: Checkbox if file has header ----
                                        checkboxInput("header", "Header", TRUE),
                                        checkboxInput("stringAsFactors", "stringAsFactors", TRUE),         
                                        
                                        
                                        # Input: Select separator ----
                                        radioButtons("sep", "Separator",
                                                     choices = c(Comma = ",",
                                                                 Semicolon = ";",
                                                                 Tab = "\t"),
                                                     selected = ","),
                                        
                                        # Horizontal line ----
                                        tags$hr(),
                                        sliderInput("dataslider","Select the number of rows",value = 15,min = 10,max =500 ),
                                        downloadButton("download1","Download")
                                 )
                        ), # end of table
                        tabPanel("Summary",
                                 column(12,
                                        verbatimTextOutput("suma",placeholder = FALSE)))
                       
                       
                        
                ) # end of tabsetpanel
                
                
                
        )
))
