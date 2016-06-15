## basic configuration
## -----------------------------------
# require(dplyr)
# require(data.table)

## remove data var
rm(order,order_test_1,order_test_2,
   traffic,traffic_test_1,traffic_test_2,
   weather,weather_test_1,weather_test_2,
   cluster,cluster_test_1,cluster_test_2,
   poi,poi_test_1,poi_test_2)

## load files------------------------
load(paste0(training_data_saving_path_season_2,"order.Rdata"))
load(paste0(training_data_saving_path_season_2,"traffic.Rdata"))
load(paste0(training_data_saving_path_season_2,"weather.Rdata"))
load(paste0(training_data_saving_path_season_2,"cluster.Rdata"))
load(paste0(training_data_saving_path_season_2,"poi.Rdata"))

load(paste0(test_data_saving_path_season_2_set_2,"order_test_2.Rdata"))
load(paste0(test_data_saving_path_season_2_set_2,"traffic_test_2.Rdata"))
load(paste0(test_data_saving_path_season_2_set_2,"weather_test_2.Rdata"))
load(paste0(test_data_saving_path_season_2_set_2,"cluster_test_2.Rdata"))
load(paste0(test_data_saving_path_season_2_set_2,"poi_test_2.Rdata"))
## ---------------------------------- load files


#####

#####

data_clean <- function(order, traffic, weather, cluster, isTest){
    names(cluster_test_2) <- c("start_district_hash","start_district_ID" )
    order <- merge(x = order, y = cluster_test_2, by = "start_district_hash", all.x = TRUE)
    names(cluster_test_2) <- c("district_hash","district_ID" )
    traffic <- merge(x = traffic, y = cluster_test_2, by = "district_hash", all.x = TRUE)
    
    ## transfer data.frame into data.table
    order <- data.table(order)
    traffic <- data.table(traffic)
    weather <-  data.table(weather)
    
    ##
    ## order
    # add new col represent date
    order[, date := as.Date(as.character(Time))]
    # calculate timeslot based on Time
    order[, timeslot:= ceiling(
        as.numeric(
            difftime(
                as.POSIXct(Time,tz="GMT"), as.POSIXct(date,tz="GMT"), units = 'mins'))/10)]
    
    ## traffic
    traffic[, date := as.Date(as.character(tj_time))]
    traffic[, timeslot := ceiling(
        as.numeric(
            difftime(
                as.POSIXct(tj_time,tz="GMT"), as.POSIXct(date,tz="GMT"), units = 'mins'))/10)]
    # select b in a:b and set a new col
    traffic[, L1 := as.integer(sapply(strsplit(as.character(tj_level_1), split = ":"), '[', 2))]  
    traffic[, L2 := as.integer(sapply(strsplit(as.character(tj_level_2), split = ":"), '[', 2))] 
    traffic[, L3 := as.integer(sapply(strsplit(as.character(tj_level_3), split = ":"), '[', 2))] 
    traffic[, L4 := as.integer(sapply(strsplit(as.character(tj_level_4), split = ":"), '[', 2))] 
    traffic[, LSum := L1+L2+L3+L4]
    traffic[, LValue := (L1+L2*2+L3*3+L4*4)/LSum]               
    
    ## weather
    weather[, date := as.Date(as.character(Time))]
    weather[, timeslot := ceiling(
        as.numeric(
            difftime(
                as.POSIXct(Time,tz="GMT"), as.POSIXct(date,tz="GMT"), units = 'mins'))/10)]
    
    ## gourp, summarise and arrange dataframe
    # order
    # group data by slice(district,date,timeslot) and summarise gap
    order <- order %>%
        group_by(start_district_ID,date,timeslot) %>%
        summarise(order_amount = n(), gap = sum(driver_id == "NULL")) %>%
        arrange(start_district_ID,date,timeslot)
    # change district_id name
    names(order)[1] <- "district_ID"
    # traffic
    traffic = traffic %>%
        group_by(district_ID, date,timeslot) %>%
        summarise(traffic_LValue = LValue) %>%
        arrange(district_ID,date,timeslot)
    # weather
    weather = weather %>% 
        group_by( date,timeslot) %>%
        summarise(temperature_m = mean(temperature), PM2.5_m = mean(PM2.5)) %>%
        arrange(date,timeslot)
    
    ## join all
    
    if(!isTest){
        data = order %>% 
            full_join(traffic, by = c("district_ID" = "district_ID", "date" = "date", "timeslot" = "timeslot")) %>%
            full_join(weather, by = c("date" = "date", "timeslot" = "timeslot"))
        save(data, file = paste0(cleaned_data_saving_path_season_2,"data.Rdata"))
    }else{
        data_test = order %>% 
            full_join(traffic, by = c("district_ID" = "district_ID", "date" = "date", "timeslot" = "timeslot")) %>%
            full_join(weather, by = c("date" = "date", "timeslot" = "timeslot"))
        save(data_test, file = paste0(cleaned_data_saving_path_season_2,"data_test.Rdata"))
    }
    
}

data_clean(order, traffic, weather, cluster,0)
data_clean(order_test_2, traffic_test_2, weather_test_2, cluster_test_2,1)

load(paste0(cleaned_data_saving_path_season_2,"data_test.Rdata"))

scatterplot3d(data_test$start_district_ID,data_test$timeslot,data_test$gap,grid = TRUE,highlight.3d=TRUE)
plot(data_test$start_district_ID, data_test$gap, col = data_test$date, cex = 0.6)
#legend("topleft", legend = data$day, pch = 1, cex = 0.6, col = data$day)

plot(data[which(data$start_district_ID == 51),]$timeslot, data[which(data$start_district_ID == 51),]$gap, col = data[which(data$start_district_ID == 51),]$da)
