fileNames =list.files()

dframe = read_csv(fileNames[1])
dframe=dframe %>% filter(dframe$total_amount>0)
dframe = dframe %>% 
  summarise(rows = n(),
            totalMiles = sum(trip_distance),
            totalMoney = sum(total_amount))

for (i in 2:length(fileNames)) {
  df = read_csv(fileNames[i])
  df=df %>% filter(df$total_amount>0)
  df=df %>% 
    summarise(rows = n(),
              totalMiles = sum(trip_distance),
              totalMoney = sum(total_amount))
  dframe = rbind(dframe, df)
}
dframe$filenames = fileNames


write_csv(dframe,"dframe.csv")
