

# Define server logic required to draw a histogram
shinyServer(function(session, input, output) {
  
  filtered_data <- reactive({
    return(data_sampled %>% 
             filter(PUZone==input$pickup,DOZone==input$destination,dayofweek==input$day,timeofday==input$timeofday))
  })

  top_10_list <- reactive({
    return(data_sampled %>% 
             filter(dayofweek==input$tableday,timeofday==input$tabletimeofday)%>%
             group_by(PUZone)%>%
             summarize(trips = n()) %>% 
             top_n(10)
    )
  })
  
  breakdownbyday <- reactive({
    data_sampled%>%
      filter(dayofweek==input$breakdownofday)%>%
      group_by(dayofweek, timeofday)%>%
      summarize(trips = n())
      
     })
  
  observe({
    dest <- unique(data_sampled %>%
                     filter(PUZone == input$pickup) %>%
                     .$DOZone)
    updateSelectizeInput(
      session, "destination",
      choices = dest,
      selected = dest[1])
  })
  
  observe({
    time <- unique(data_sampled %>%
                     filter(PUZone == input$pickup, DOZone==input$destination) %>%
                     .$dayofweek)
    updateSelectizeInput(
      session, "day",
      choices = time,
      selected = time[1])
  })
  
  observe({
    tod <- unique(data_sampled %>%
                     filter(PUZone == input$pickup, DOZone==input$destination, dayofweek ==input$day) %>%
                     .$timeofday)
    updateSelectizeInput(
      session, "timeofday",
      choices = tod,
      selected = tod[1])
  })
  
  
  
  output$maxtimeBox <- renderInfoBox({
    infoBox(
      "Max Duration",
      paste(max(filtered_data() %>% select(traveltimeminutes)),"Minutes"),
      icon = icon("hourglass", lib = 'glyphicon'),
      color = "black"
    )
  })
  
  output$numtrips <- renderInfoBox({
    infoBox(
      "Number of Trips",
      paste(filtered_data() %>% summarise(n()),'Trips'),
      icon = icon("list"),
      color = "black"
    )
  })
  
  output$mintimeBox <- renderInfoBox({
    infoBox(
      "Min Duration",
      paste(min(filtered_data() %>% select(traveltimeminutes)),"Minutes"),
      icon = icon("hourglass", lib = 'glyphicon'),
      color = "black"
    )
  })
  
  output$maxcostBox <- renderInfoBox({
    infoBox(
      "Max Cost",
      paste0("$",max(filtered_data() %>% select(total_amount))),
      icon = icon("usd", lib = 'glyphicon'),
      color = "black"
    )
  })

  output$mincostBox <- renderInfoBox({
    infoBox(
      "Min Cost",
      paste0("$",min(filtered_data() %>% select(total_amount))),
      icon = icon("usd", lib = 'glyphicon'),
      color = "black"
    )
  })
  
  output$avgtimeBox <- renderInfoBox({
    infoBox(
      "Average Time",
      paste(filtered_data() %>% select(traveltimeminutes)%>%summarise(avgtime=round(mean(traveltimeminutes),2)),"Minutes"),
      icon = icon("hourglass", lib = 'glyphicon'),
      color = "yellow"
    )
  })
  
  output$avgcostBox <- renderInfoBox({
    infoBox(
      "Average Cost",
      paste0("$",filtered_data() %>% select(total_amount)%>%summarise(avgtime=round(mean(total_amount),2))),
      icon = icon("usd", lib = 'glyphicon'),
      color = "yellow"
    )
  })
  
  output$avgtipBox <- renderInfoBox({
    infoBox(
      "Average Tip",
      paste0("$",filtered_data() %>% select(tip_amount)%>%summarise(avgtime=round(mean(tip_amount),2))),
      icon = icon("usd", lib = 'glyphicon'),
      color = "yellow"
    )
  })
  
  output$table <- DT::renderDataTable({
    datatable(prettytable, rownames=FALSE) %>%
      formatStyle(input$selected, background="skyblue", fontWeight='bold')
  })

  
  # show histogram using googleVis
  output$hist <- renderGvis({
    gvisBarChart(top_10_list(),
                    xvar="PUZone",
                    yvar = "trips",
                    options=list(width='1150px', height='450px', title="Top 10 Neighborhoods", hAxis="{title:'Number of Pick Ups'}",
                                 vAxis="{title:'Neighborhood'}"      ))

                 
    })
  
  output$histbytod <- renderPlot({
    ggplot(data=breakdownbyday(), aes(x=timeofday, y=trips, group=dayofweek)) +
      geom_line(aes(color=dayofweek))+scale_x_discrete(limits=c('Early Morning',"AM Rush Hour",
                                                                "Morning","Afternoon","PM Rush Hour",
                                                                "Evening","Night","Late Night"))+geom_point(size=2)
  })
  
  output$taxi_view <- renderGvis({
    gvisTable(data=taxi_zone)})
  
  output$plot2 <- renderPlotly({
    print(
      ggplotly(
        ggplot(data=databyyears, aes(x=monthyear, y=rows)) +
          geom_line(shape=1,colour="black") +     
          geom_point(size=1) +         # Use larger points, fill with white
          xlab("Time") + ylab("Ridership") + # Set axis labels
          ggtitle("Monthly Yellow Cab Ridershp") +# Set title
          geom_smooth(se=FALSE, method=lm,colour="#FFFF00")))
    
  })
  
  
  
  
  
    
  })
  