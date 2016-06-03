require(dplyr)
require(data.table)
require(stringr)
require(reshape2)

setwd("/Users/andrea/Documents/Project/Didi/season_1")

#read order_data
order_name <- list.files(path = "training_data/order_data", full.names = TRUE)

order_data <- lapply(order_name, function(order_name){
  return(fread(filename, 
        stringsAsFactors = FALSE, 
        na.strings = " ") %>% 
    as.data.frame() %>%
    tbl_df())
})

#read traffic_data
traffic_name <- list.files(path = "training_data/traffic_data", full.names = TRUE)

traffic_data <- lapply(traffic_name, function(traffic_name){
  return(fread(traffic_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ") %>% 
           as.data.frame() %>%
           tbl_df())
})

#read weather_data
weather_name <- list.files(path = "training_data/weather_data", full.names = TRUE)

weather_data <- lapply(weather_name, function(weather_name){
  return(fread(weather_name, 
               stringsAsFactors = FALSE, 
               na.strings = " ") %>% 
           as.data.frame() %>%
           tbl_df())
})


#read cluster_data
cluster_data <- fread("training_data/cluster_map/cluster_map",
                      stringsAsFactors = FALSE,
                      na.strings = " ") %>%
  as.data.frame() %>%
  tbl_df()

#read poi_data
poi_data <- fread("training_data/poi_data/poi_data",
                      stringsAsFactors = FALSE,
                      na.strings = " ") %>%
  as.data.frame() %>%
  tbl_df()

