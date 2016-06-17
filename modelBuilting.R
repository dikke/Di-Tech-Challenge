#setwd("/Users/sheliaxin/Documents/Duke/DIDI/season_1")
# to predict
toPredict <- read.table("test_set_1/read_me_1.txt", header = TRUE)
names(toPredict) <- c("time")
toPredict = cbind(toPredict, day = as.Date(strptime(as.character(toPredict$time),'%Y-%m-%d-%t',tz = "GMT")))
toPredict["timeslot"] = as.numeric(substring(toPredict$time,12))

toPredict["toPre"] = 1
toPredict = merge(district,toPredict,all = TRUE)

data_toPre = data_test %>%
             full_join(toPredict, by = c("start_district_ID"= "district_ID", "day"="day","timeslot"="timeslot")) %>%
             arrange(start_district_ID,day,timeslot)
head(data_toPre)
save(data_toPre, file = "data_toPre.Rdata")

# simple try
for(i in 3:nrow(data_toPre)){
  if(!is.na(data_toPre[i,"toPre"])){
    j = i-1
    tem = 0
    while(j!=0 || is.na(data_toPre[j,"toPre"])){
      if(!is.na(data_toPre[j,"gap"])){
        tem = tem + data_toPre[j,"gap"]
      }
      j = j-1
      if(j==0) break
    }
    data_toPre[i,"gap"] = tem / (i-j-1)
  }
}
  
res1 = toPredict %>% 
       left_join(data_toPre, by = c( "district_ID" = "start_district_ID", "day"="day","timeslot"="timeslot")) %>%
       filter(toPre.x==1) %>%
       select(district_ID,time.y,gap) %>%
       arrange(district_ID)
      
write.csv(res1, file = "naive.csv", row.names = FALSE,col.names = FALSE)




