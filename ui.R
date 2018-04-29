library(shiny)
library(fiftystater)

shinyUI(navbarPage("U.S. Crime Report",
   tabPanel("Bubble Plot",
            fluidPage(
              
              titlePanel("On The Bubbles"),
              
              plotOutput("bubbleChart")
            )
   ),
   
   tabPanel("Line Chart",
            fluidPage(
              
              titlePanel("On The Lines"),
              
              plotOutput("lineChart1"),
              plotOutput("lineChart2"),
              plotOutput("lineChart3")
            )
   ),
   
  tabPanel("Map",
    fluidPage(
    
      titlePanel("On The Maps"),
      
      hr(),
      
      sidebarLayout(
        mainPanel(
          plotOutput("USMap"),
          plotOutput("USMap2")
        ),
        
        sidebarPanel(
          h4("Crime Type"),
     
               sliderInput("year",
                           "Which year to investigae:",
                           min = 2012, max = 2016, value = 1),
               br(),
               selectInput("methods",
                           "By rate or by total:",
                           choices = c("Crime Rate" = "1", "Crime Total" = "2")),
               br(),
               selectInput("types",
                           "Please select data kind:",
                           choices = c("Violent.crime", "Aggravated..assault", "Burglary", "Larceny..theft", "Motor..vehicle..theft", "Murder.and..nonnegligent..manslaughter", "Property..crime", "Rape..legacy.definition.", "Rape..revised.definition.", "Robbery", "Population")),
               br(),
               radioButtons("compare1",
                            "Please select graphs to be compared:",
                            choices = list("Crime Rate","Educational Attainment","Household Income"),
                            selected = "Crime Rate"),
               HTML('<hr style="color: purple;">'),
               radioButtons("compare2",
                       "Please select graphs to be compared:",
                       choices = list("Crime Rate","Educational Attainment","Household Income"),
                       selected = "Educational Attainment")
        )
      )
    )
  )
))