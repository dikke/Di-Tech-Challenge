require(dplyr)
require(data.table)
require(stringr)
require(reshape2)
###
#expand the compressed data archive, and set it as working dictionary
setwd("/Users/andrea/Documents/Project/Didi/season_1")

#read order_data
order_name <- list.files(path = "training_data/order_data", full.names = TRUE)

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

save(order, file="order.Rdata")

#read traffic_data
traffic_name <- list.files(path = "training_data/traffic_data", full.names = TRUE)

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

save(traffic, file = "traffic.Rdata")

#read weather_data
weather_name <- list.files(path = "training_data/weather_data", full.names = TRUE)

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

save(weather, file = "weather.Rdata")

#read cluster_data
cluster <- fread("training_data/cluster_map/cluster_map",
                      stringsAsFactors = FALSE,
                      na.strings = " ") %>%
  as.data.frame() %>%
  tbl_df()

save(cluster, file = "cluster.Rdata")

#read poi_data
poi <- read.csv("training_data/poi_data/poi_data",
                     header = FALSE, 
                     sep = "") %>%
  as.data.frame() %>%
  tbl_df()

save(poi, file = "poi.Rdata")
#poi, cluster, weather, traffic are the complete dataset


