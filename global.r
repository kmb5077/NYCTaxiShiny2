library(tidyverse)
library(lubridate)
library(DT)
library(shiny)
library(shinydashboard)
library(googleVis)
library(rsconnect)



data_sampled = read.csv('./taxi8Mclean.csv', stringsAsFactors = FALSE)
taxi_zone = read.csv('./taxizone.csv', stringsAsFactors = FALSE, header = TRUE)
databyyears= read.csv('taxidatabymonth.csv', stringsAsFactors = FALSE, header = TRUE)
databyyears$year=str_extract(databyyears$filenames,pattern = '\\d{4}')
databyyears$month=gsub('-','',str_extract(databyyears$filenames,pattern = '-\\d{2}'))
databyyears$monthyear=paste0(databyyears$month,'-',databyyears$year)
databyyears$monthyear=as.Date(as.yearmon(databyyears$monthyear, format = "%m-%Y"))


taxi_zone = taxi_zone%>%
  select(LocationID,Borough,Zone)


prettytable=data_sampled %>%
  select(Pick_Up_Location=PUZone,
         Pick_Up_Boro=PUBorough,
         Drop_Off_Zone=DOZone,
         Drop_Off_Boro=DOBorough,
         Distance=trip_distance,
         Pickup_Time=tpep_pickup_datetime,
         Time_of_Day=timeofday,
         Week_day=dayofweek,
         Drop_Off_Time=tpep_dropoff_datetime,
         Travel_Time=traveltimeminutes,
         Totat_Tip=tip_amount,
         Total_Amt=total_amount
           )
