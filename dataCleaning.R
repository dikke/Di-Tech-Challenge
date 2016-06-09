require(dplyr)
require(data.table)
load("order.rdata")
load("traffic.rdata")
load("weather.rdata")

#####

## order
# district
names(cluster) <- c("start_district_hash","start_district_ID" )
orderPre <- merge(x = order, y = cluster, by = "start_district_hash", all.x = TRUE)
# table(orderPre$start_district_ID)
# hist(orderPre$start_district_ID)
# time
orderPre = data.table(orderPre)
orderPre[,day := as.Date(as.character(Time))]
orderPre = cbind(orderPre, datetime = orderPre[,strptime(as.character(Time),'%Y-%m-%d %H:%M:%S',tz = "GMT")])
orderPre[,timeslot:= ceiling(as.numeric(difftime(datetime, as.POSIXct(as.character(day),tz="GMT"),units = 'mins'))/10)]

orderPre = orderPre %>%
  group_by(start_district_ID, day, timeslot) %>%
  summarise(n = n(), sum(driver_id == "NULL")) %>%
  arrange(start_district_ID,day,timeslot)


## traffic
names(cluster) <- c("district_hash","district_ID" )
traffic <- merge(x = traffic, y = cluster, by = "district_hash", all.x = TRUE)
traffic = data.table(traffic)
traffic[,day := as.Date(as.character(tj_time))]
traffic = cbind(traffic, datetime = traffic[,strptime(as.character(tj_time),'%Y-%m-%d %H:%M:%S',tz = "GMT")])
traffic[,timeslot:= ceiling(as.numeric(difftime(datetime, as.POSIXct(as.character(day),tz="GMT"),units = 'mins'))/10)]
traffic$L1 = as.integer(lapply(strsplit(as.character(traffic$tj_level_1), split=":"), "[", 2))
traffic$L2 = as.integer(lapply(strsplit(as.character(traffic$tj_level_2), split=":"), "[", 2))
traffic$L3 = as.integer(lapply(strsplit(as.character(traffic$tj_level_3), split=":"), "[", 2))
traffic$L4 = as.integer(lapply(strsplit(as.character(traffic$tj_level4), split=":"), "[", 2))
traffic$LSum = traffic$L1+traffic$L2 +traffic$L3 + traffic$L4 
traffic$index = (traffic$L1 + traffic$L2 *2 + traffic$L3 * 3 + traffic$L4 *4)/traffic$LSum

trafficPre = traffic %>%
          group_by(district_ID, day,timeslot) %>%
          summarise(traffic_index = index) %>%
          arrange(district_ID,day,timeslot)

# weather

weather =  data.table(weather)
weather[,day := as.Date(as.character(Time))]
weather = cbind(weather, datetime = weather[,strptime(as.character(Time),'%Y-%m-%d %H:%M:%S',tz = "GMT")])
weather[,timeslot:= ceiling(as.numeric(difftime(datetime, as.POSIXct(as.character(day),tz="GMT"),units = 'mins'))/10)]

weatherPre = weather %>% 
  group_by( day,timeslot) %>%
  summarise(temperature_m = mean(temperature), PM2.5_m = mean(PM2.5)) %>%
  arrange(day,timeslot)

# join all
data = orderPre %>% 
       full_join(trafficPre, by = c("start_district_ID" = "district_ID", "day" = "day", "timeslot" = "timeslot")) %>%
       full_join(weatherPre, by = c("day" = "day", "timeslot" = "timeslot"))

save(data, "data.Rdata")
