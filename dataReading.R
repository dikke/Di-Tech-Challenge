## basic configuration
## -----------------------------------
## please run configuration.R first


## ---------------------------------------------- basic configuration


## read data from season_1
## ----------------------------------------------
## read training data
## ----------------------------------------------
#read order_data

order_name <- list.files(path = training_order_data_path_season_1, full.names = TRUE)

order_data <- lapply(order_name, function(order_name){
  return(fread(order_name, 
        stringsAsFactors = FALSE, 
        na.strings = " ") %>% 
    as.data.frame() %>%
    tbl_df())
})

order <- c()
for (i in 1:21){
  order <- rbind(order, order_data[[i]])
} 

names(order) <- c("order_id", "driver_id", "passenger_id", "start_district_hash", "dest_district_hash", "Price", "Time")
save(order, file = paste0(training_data_saving_path_season_1,"order.Rdata"))

#read traffic_data
traffic_name <- list.files(path = training_traffic_data_path_season_1, full.names = TRUE)

traffic_data <- lapply(traffic_name, function(traffic_name){
  return(fread(traffic_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ",
               header = FALSE) %>% 
           as.data.frame() %>%
           tbl_df())
})

traffic <- c()
for (i in 1:21){
  traffic <- rbind(traffic, traffic_data[[i]])
}
names(traffic) <- c("district_hash", "tj_level_1", "tj_level_2", "tj_level_3", "tj_level_4", "tj_time")
save(traffic, file = paste0(training_data_saving_path_season_1,"traffic.Rdata"))

#read weather_data
weather_name <- list.files(path = training_weather_data_path_season_1, full.names = TRUE)

weather_data <- lapply(weather_name, function(weather_name){
  return(fread(weather_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ") %>% 
           as.data.frame() %>%
           tbl_df())
})

weather <- c()
for (i in 1:21){
  weather <- rbind(weather, weather_data[[i]])
}
names(weather) <- c("Time", "Weather", "temperature", "PM2.5")
save(weather, file =  paste0(training_data_saving_path_season_1,"weather.Rdata"))

#read cluster_data
cluster <- fread(training_cluster_map_path_season_1,
                      stringsAsFactors = FALSE,
                      na.strings = " ") %>%
  as.data.frame() %>%
  tbl_df()

save(cluster, file =  paste0(training_data_saving_path_season_1,"cluster.Rdata"))

#read poi_data
poi <- read.csv(training_poi_data_path_season_1,
                     header = FALSE, 
                     sep = "") %>%
  as.data.frame() %>%
  tbl_df()

save(poi, file = paste0(training_data_saving_path_season_1,"poi.Rdata"))
# training data including poi, cluster, weather, traffic are the complete dataset

##------------------------------------------------------ end read traning data


## read test_set_1 data
## -----------------------------------------------------
order_name <- list.files(path = test_order_data_path_season_1_set_1, full.names = TRUE)

order_data <- lapply(order_name, function(order_name){
    return(fread(order_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ") %>% 
               as.data.frame() %>%
               tbl_df())
})

order_test_1 <- c()
for (i in 1:5){
    order_test_1 <- rbind(order_test_1, order_data[[i]])
}

names(order_test_1) <- c("order_id", "driver_id", "passenger_id", "start_district_hash", "dest_district_hash", "Price", "Time")
save(order_test_1, file = paste0(test_data_saving_path_season_1_set_1,"order_test_1.Rdata"))

#read traffic_data
traffic_name <- list.files(path = test_traffic_data_path_season_1_set_1, full.names = TRUE)

traffic_data <- lapply(traffic_name, function(traffic_name){
    return(fread(traffic_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ",
                 header = FALSE) %>% 
               as.data.frame() %>%
               tbl_df())
})

traffic_test_1 <- c()
for (i in 1:5){
    traffic_test_1 <- rbind(traffic_test_1, traffic_data[[i]])
}
names(traffic_test_1) <- c("district_hash", "tj_level_1", "tj_level_2", "tj_level_3", "tj_level_4", "tj_time")
save(traffic_test_1, file = paste0(test_data_saving_path_season_1_set_1,"traffic_test_1.Rdata"))

#read weather_data
weather_name <- list.files(path = test_weather_data_path_season_1_set_1, full.names = TRUE)

weather_data <- lapply(weather_name, function(weather_name){
    return(fread(weather_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ") %>% 
               as.data.frame() %>%
               tbl_df())
})

weather_test_1 <- c()
for (i in 1:5){
    weather_test_1 <- rbind(weather_test_1, weather_data[[i]])
}
names(weather_test_1) <- c("Time", "Weather", "temperature", "PM2.5")
save(weather_test_1, file =  paste0(test_data_saving_path_season_1_set_1,"weather_test_1.Rdata"))

#read cluster_data
cluster_test_1 <- fread(test_cluster_map_path_season_1_set_1,
                 stringsAsFactors = FALSE,
                 na.strings = " ") %>%
    as.data.frame() %>%
    tbl_df()

save(cluster_test_1, file =  paste0(test_data_saving_path_season_1_set_1,"cluster_test_1.Rdata"))

#read poi_data
poi_test_1 <- read.csv(test_poi_data_path_season_1_set_1,
                header = FALSE, 
                sep = "") %>%
    as.data.frame() %>%
    tbl_df()

save(poi_test_1, file = paste0(test_data_saving_path_season_1_set_1,"poi_test_1.Rdata"))

## ------------------------------------------end read test_set_1 data
## ---------------------------------------------- read data from season_1


## read data from season_2
## ----------------------------------------------
## read training data
## ----------------------------------------------
#read order_data

order_name <- list.files(path = training_order_data_path_season_2, full.names = TRUE)

order_data <- lapply(order_name, function(order_name){
  return(fread(order_name, 
        stringsAsFactors = FALSE, 
        na.strings = " ") %>% 
    as.data.frame() %>%
    tbl_df())
})

order <- c()
for (i in 1:21){
  order <- rbind(order, order_data[[i]])
} 

names(order) <- c("order_id", "driver_id", "passenger_id", "start_district_hash", "dest_district_hash", "Price", "Time")
save(order, file = paste0(training_data_saving_path_season_2,"order.Rdata"))

#read traffic_data
traffic_name <- list.files(path = training_traffic_data_path_season_2, full.names = TRUE)

traffic_data <- lapply(traffic_name, function(traffic_name){
  return(fread(traffic_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ",
               header = FALSE) %>% 
           as.data.frame() %>%
           tbl_df())
})

traffic <- c()
for (i in 1:21){
  traffic <- rbind(traffic, traffic_data[[i]])
}
names(traffic) <- c("district_hash", "tj_level_1", "tj_level_2", "tj_level_3", "tj_level_4", "tj_time")
save(traffic, file = paste0(training_data_saving_path_season_2,"traffic.Rdata"))

#read weather_data
weather_name <- list.files(path = training_weather_data_path_season_2, full.names = TRUE)

weather_data <- lapply(weather_name, function(weather_name){
  return(fread(weather_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ") %>% 
           as.data.frame() %>%
           tbl_df())
})

weather <- c()
for (i in 1:21){
  weather <- rbind(weather, weather_data[[i]])
}
names(weather) <- c("Time", "Weather", "temperature", "PM2.5")
save(weather, file =  paste0(training_data_saving_path_season_2,"weather.Rdata"))

#read cluster_data
cluster <- fread(training_cluster_map_path_season_2,
                      stringsAsFactors = FALSE,
                      na.strings = " ") %>%
  as.data.frame() %>%
  tbl_df()

save(cluster, file =  paste0(training_data_saving_path_season_2,"cluster.Rdata"))

#read poi_data
poi <- read.csv(training_poi_data_path_season_2,
                     header = FALSE, 
                     sep = "") %>%
  as.data.frame() %>%
  tbl_df()

save(poi, file = paste0(training_data_saving_path_season_2,"poi.Rdata"))
# training data including poi, cluster, weather, traffic are the complete dataset

##------------------------------------------------------ end read traning data


## read test_set_2 data
## -----------------------------------------------------
order_name <- list.files(path = test_order_data_path_season_2_set_2, full.names = TRUE)

order_data <- lapply(order_name, function(order_name){
    return(fread(order_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ") %>% 
               as.data.frame() %>%
               tbl_df())
})

order_test_2 <- c()
for (i in 1:5){
    order_test_2 <- rbind(order_test_2, order_data[[i]])
}

names(order_test_2) <- c("order_id", "driver_id", "passenger_id", "start_district_hash", "dest_district_hash", "Price", "Time")
save(order_test_2, file = paste0(test_data_saving_path_season_2_set_2,"order_test_2.Rdata"))

#read traffic_data
traffic_name <- list.files(path = test_traffic_data_path_season_2_set_2, full.names = TRUE)

traffic_data <- lapply(traffic_name, function(traffic_name){
    return(fread(traffic_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ",
                 header = FALSE) %>% 
               as.data.frame() %>%
               tbl_df())
})

traffic_test_2 <- c()
for (i in 1:5){
    traffic_test_2 <- rbind(traffic_test_2, traffic_data[[i]])
}
names(traffic_test_2) <- c("district_hash", "tj_level_1", "tj_level_2", "tj_level_3", "tj_level_4", "tj_time")
save(traffic_test_2, file = paste0(test_data_saving_path_season_2_set_2,"traffic_test_2.Rdata"))

#read weather_data
weather_name <- list.files(path = test_weather_data_path_season_2_set_2, full.names = TRUE)

weather_data <- lapply(weather_name, function(weather_name){
    return(fread(weather_name, 
                 stringsAsFactors = FALSE, 
                 na.strings = " ") %>% 
               as.data.frame() %>%
               tbl_df())
})

weather_test_2 <- c()
for (i in 1:5){
    weather_test_2 <- rbind(weather_test_2, weather_data[[i]])
}
names(weather_test_2) <- c("Time", "Weather", "temperature", "PM2.5")
save(weather_test_2, file =  paste0(test_data_saving_path_season_2_set_2,"weather_test_2.Rdata"))

#read cluster_data
cluster_test_2 <- fread(test_cluster_map_path_season_2_set_2,
                 stringsAsFactors = FALSE,
                 na.strings = " ") %>%
    as.data.frame() %>%
    tbl_df()

save(cluster_test_2, file =  paste0(test_data_saving_path_season_2_set_2,"cluster_test_2.Rdata"))

#read poi_data
poi_test_2 <- read.csv(test_poi_data_path_season_2_set_2,
                header = FALSE, 
                sep = "") %>%
    as.data.frame() %>%
    tbl_df()

save(poi_test_2, file = paste0(test_data_saving_path_season_2_set_2,"poi_test_2.Rdata"))

## ------------------------------------------end read test_set_2 data
## ---------------------------------------------- read data from season_2