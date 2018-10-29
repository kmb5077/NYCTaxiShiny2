
dashboardPage(
  
  dashboardHeader(title = "NYC Yellow Taxi Dashboard"

  ),
  
  
  dashboardSidebar(
    sidebarUserPanel("Taxi Data",
                    image = "taximed.jpeg"
    ),
    
    
    sidebarMenu(
      id = "tabs",
      menuItem("Why", tabName = "why", icon = icon("asterisk")),
      menuItem("Charts", tabName = "chart", icon = icon("taxi")),
      menuItem("Dashboard", icon = icon("dashcube"), tabName = "dashboard"),
      menuItem("Tables", tabName='table', icon = icon("table")),
      menuItem("Heat Map", icon = icon("map-signs"), tabName = "heatmap", badgeLabel = "Coming Soon",
               badgeColor = "blue")
    )
    
    
  ),
  
  
  
  dashboardBody(
    
    tabItems(
    tabItem(tabName = 'why',
            fluidRow(box(strong(h1("Welcome to my NYC Taxi Data Shiny App", align="center")),solidHeader = TRUE, background = 'blue',width = 12)),
            fluidRow(plotlyOutput("plot2")),
            fluidRow(box(strong(h2('Taxi Facts',align='center')),
                         h4('-NYC taxi rider ship is down 53% since 2014, averaging an annual ridership of 13.8M in 2014 down to 8.9M in 2018'),br(),
                         h4('-The average cost per ride has actually increased from $15.25 to $16.13, however the decrease in the number of rides is not covered by the increase in average cost per ride'),br(),
                         h4('-Result is a loss of $663M annual revenue between 2014 and 2017, 2.5B and 1.85B respectively'),br(),
                         h4('-UBER introducded to NYC'),br(),
                         h4('-July 2017 UBER overtook yellow cabs in average daily ridership'),br(),
                         h4('-UBER did lose a vote in Aug 18, allowing the city to place a cap on the for-hire vehicles(which UBER operates as) for a year'),
                         
                         
                         
                         
                         
                         
                         
                         width=6), box(img(src='taxis.jpeg', height=300, width=600) ,width=6))),
    tabItem(tabName = "chart",
            box(fluidRow(checkboxGroupInput("breakdownofday",
                                 label = h4("Day"),
                                 selected= "Sun",
                                 inline = TRUE,
                                 choices = list("Sun" = "Sun", "Mon" = "Mon", "Tue" = "Tue", "Wed"="Wed","Thu"="Thu","Fri"="Fri","Sat"="Sat")),
              
                     
                     
                       plotOutput("histbytod")
                     ),width = 12,collapsible = TRUE,title = "Ridership by Time of Day", solidHeader = TRUE,status = 'primary',collapsed = TRUE),
            
              box(fluidRow(selectInput("tableday",
                                   label = h4("Day"), 
                                   choices = c('Sun','Mon',"Tue","Wed","Thu","Fri","Sat")),
                       selectInput("tabletimeofday",
                                   label = h4("Time of Day"), 
                                   choices = unique(data_sampled$timeofday)[order(unique(data_sampled$timeofday))])          
                       
              ),
              fluidRow(
                htmlOutput("hist")),width = 12,collapsible = TRUE,title = "Popularity of Neighborhood by Day and Time", solidHeader = TRUE,status = 'warning',collapsed = TRUE
              ),
            fluidRow(br()),
            fluidRow(br()),
            fluidRow(br()),
            fluidRow(br()),
            fluidRow(br())

      ),
      
      
      tabItem(tabName = "dashboard",
              fluidRow(infoBoxOutput("numtrips"),
                       infoBoxOutput("maxtimeBox"),
                       infoBoxOutput("mintimeBox"),
                       infoBoxOutput("maxcostBox"),
                       infoBoxOutput("mincostBox")
                       
                       
                      
                       ),
              fluidRow(
                column(4,
                       selectizeInput("pickup",
                                   label = h4("Pickup Location"), 
                                   choices = unique(data_sampled$PUZone)[order(unique(data_sampled$PUZone))], 
                                   selected="East Village"),
                       selectizeInput("destination",
                                   label = h4("Destination Location"), 
                                   choices = unique(data_sampled$DOZone)[order(unique(data_sampled$DOZone))],
                                   selected="West Village"),
                       selectInput("day",
                                   label = h4("Day"), 
                                   choices = c('Sun','Mon',"Tue","Wed","Thu","Fri","Sat")),
                       selectInput("timeofday",
                                   label = h4("Time of Day"), 
                                   choices = unique(data_sampled$timeofday)[order(unique(data_sampled$timeofday))])
                ),
                column(8,
                       infoBoxOutput("avgtimeBox"),
                       infoBoxOutput("avgcostBox"),
                       infoBoxOutput("avgtipBox"),
                       h1("Please Select", br(),
                          strong("A Pick Up Zone,"),br(),
                          strong("Drop Off Zone"),br(),
                          strong(" Day,"),br(),
                          strong("and Expeceted Time of Day")),
                       h3("If zone name are unknown, use map and key below to pinpoint the name of the zone you're looking for")
                       
                       )
              ),
              fluidRow(box(width=6,img(src='taxi_zone_map_manhattan.jpg',aligh='left',width=500,height=500),
                           img(src='taxi_zone_map_brooklyn.jpg',align='left',width=500,height=500),
                           fluidRow(img(src='taxi_zone_map_bronx.jpg',align='left',width=500,height=500)),
                           fluidRow(img(src='taxi_zone_map_queens.jpg',align='left',width=500,height=500)),
                           fluidRow(img(src='taxi_zone_map_staten_island.jpg',align='left',width=500,height=500))
                           
                           ),box(width=6,htmlOutput("taxi_view")))
      ),
      
      
      tabItem(tabName = "table",
              fluidRow(DT::dataTableOutput("table"), width = 12)
              )
    )
    

        )
        
        
        
     )
    
    
    
    

