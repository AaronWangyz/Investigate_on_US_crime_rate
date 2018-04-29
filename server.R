library(shiny)
library(fiftystater)
library(ggplot2)
load("final_dataset.RData")

server <- shinyServer(function(input, output, session) {
  
  countMethod <- reactive({
    year <- input$year
    temp <- input$methods
    temp <- (as.numeric(year) - 2012) * 2 + as.numeric(temp)
    temp <- crime_data[[temp]]
  })
  
  crimeType <- reactive({
    temp <- input$types
    temp <- countMethod()[,c(temp)]
  })
  
  crimeMap <- reactive({
    ggplot(data = countMethod(), aes(map_id = States)) + 
      geom_map(aes(fill = crimeType()), map = fifty_states) +
      scale_fill_gradientn(colours = c("#fff5f0","#fee0d2","#fcbba1","#fc9272","#fb6a4a","#ef3b2c","#cb181d","#a50f15","#67000d")) +
      expand_limits(x = fifty_states$long, y = fifty_states$lat) +
      coord_map() +
      scale_x_continuous(breaks = NULL) + 
      scale_y_continuous(breaks = NULL) +
      labs(x = "", y = "") +
      theme(legend.position = "bottom", 
            panel.background = element_blank())
  })
  
  eduYear <- reactive({
    temp <- input$year
    temp <- as.numeric(temp) - 2011
    temp <- edu_data[[temp]]
  })
  
  eduType <- reactive({
    temp <- eduYear()[,"Total..Estimate..Percent.bachelor.s.degree.or.higher"]
  })
  
  eduMap <- reactive({
    ggplot(data = eduYear(), aes(map_id = States)) + 
      geom_map(aes(fill = eduType()), map = fifty_states) +
      scale_fill_gradientn(colours = c("#f7fbff","#deebf7","#c6dbef","#9ecae1","#6baed6","#4292c6","#2171b5","#08519c","#08306b")) +
      expand_limits(x = fifty_states$long, y = fifty_states$lat) +
      coord_map() +
      scale_x_continuous(breaks = NULL) + 
      scale_y_continuous(breaks = NULL) +
      labs(x = "", y = "") +
      theme(legend.position = "bottom", 
            panel.background = element_blank())
  })
  
  incomeYear <- reactive({
    temp <- input$year
    temp <- as.numeric(temp) - 2011
    temp <- income_data[[temp]]
  })
  
  incomeType <- reactive({
    temp <- incomeYear()[,"Households..Estimate..Median.income..dollars."]
  })
  
  incomeMap <- reactive({
    ggplot(data = incomeYear(), aes(map_id = States)) + 
      geom_map(aes(fill = incomeType()), map = fifty_states) +
      scale_fill_gradientn(colours = c("#fcfbfd","#efedf5","#dadaeb","#bcbddc","#9e9ac8","#807dba","#6a51a3","#54278f","#3f007d")) +
      expand_limits(x = fifty_states$long, y = fifty_states$lat) +
      coord_map() +
      scale_x_continuous(breaks = NULL) + 
      scale_y_continuous(breaks = NULL) +
      labs(x = "", y = "") +
      theme(legend.position = "bottom", 
            panel.background = element_blank())
  })
  
  output$USMap <- renderPlot({
    if (input$compare1 == "Crime Rate")
      crimeMap()
    else if (input$compare1 == "Educational Attainment")
      eduMap()
    else if (input$compare1 == "Household Income")
      incomeMap()
  })
  
  output$USMap2 <- renderPlot({
    if (input$compare2 == "Crime Rate")
      crimeMap()
    else if (input$compare2 == "Educational Attainment")
      eduMap()
    else if (input$compare2 == "Household Income")
      incomeMap()
  })
  
  output$bubbleChart <- renderPlot({
    ggplot(overall_data, aes(x = crime_year, y = crime_rate)) +
      geom_point(aes(size = edu_level, colour = income_level)) +
      scale_color_gradientn(colours = c("#fcfbfd","#efedf5","#dadaeb","#bcbddc","#9e9ac8","#807dba","#6a51a3","#54278f","#3f007d")) +
      scale_size(range = c(5,20))
  })
  
  output$lineChart1 <- renderPlot({
    ggplot(overall_data, aes(x = crime_year, y = crime_rate)) +
      geom_line(color = "#fb6a4a", size = 2) +
      labs(x = "Year", y = "Crime Rate")
  })
  
  output$lineChart2 <- renderPlot({
    ggplot(overall_data, aes(x = crime_year, y = edu_level)) +
      geom_line(color = "#6baed6", size = 2) +
      labs(x = "Year", y = "Educational Attainment")
  })
  
  output$lineChart3 <- renderPlot({
    ggplot(overall_data, aes(x = crime_year, y = income_level)) +
      geom_line(color = "#9e9ac8", size = 2) +
      labs(x = "Year", y = "Household Income")
  })
})