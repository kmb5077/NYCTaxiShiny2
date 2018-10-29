databyyears= read.csv('taxidatabymonth.csv', stringsAsFactors = FALSE, header = TRUE)
databyyears$totalMoney/databyyears$totalMiles


stringr::str_locate(databyyears$filenames,pattern = '\\d+')
grep(databyyears$filenames,pattern = '\\d+', value=TRUE)

str_split(databyyears$filenames,pattern = '\\d+')

grep("\\d{4}",databyyears$filenames,pattern)

databyyears$year=str_extract(databyyears$filenames,pattern = '\\d{4}')
databyyears$month=gsub('-','',str_extract(databyyears$filenames,pattern = '-\\d{2}'))


extract(databyyears, col=filenames,into='year',regex = '\\d{4}')

separate(databyyears, col=filenames, into='year')

databyyears$monthyear=paste0(databyyears$month,'-',databyyears$year)

class(databyyears$monthyear)
as.POSIXct(databyyears$monthyear[4],format="%m-%Y")

as.Date(databyyears$monthyear,format="%m-%Y")
strptime(databyyears$monthyear,format="%m-%Y")

y='05-2015'
class(y)
class(as.Date(y,format = "%m-%d-%Y"))
as.POSIXct(y,format="%m-%y")
as.Date(as.yearmon(databyyears$monthyear, format = "%m-%Y"))


str_extract(databyyears$filenames,pattern = '\\d{4}-(\\d{2})')


p <- ggplot(data=databyyears, aes(x=monthyear, y=rows)) +
  geom_line(shape=1,colour="black") +     
  geom_point(size=1) +         # Use larger points, fill with white
  xlab("Time") + ylab("Ridership") + # Set axis labels
  ggtitle("Monthly Yellow Cab Ridershp") +# Set title
  geom_smooth(se=FALSE, method=lm,colour="#FFFF00")
ggplotly(p)


avgdata=databyyears%>%group_by(year)%>%summarise(mean(rows),mean(totalMiles),mean(totalMoney))
class(avgdata)
sumdata=databyyears%>%group_by(year)%>%summarise(sum(rows),sum(totalMiles),sum(totalMoney))

