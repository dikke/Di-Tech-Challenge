require(dplyr)
require(data.table)
require(stringr)
require(reshape2)
###
## set work directory 
DiTech_directory <- "E:/GitHub/Di-Tech-Chanllenge/Di-Tech-Challenge/"
setwd(DiTech_directory);
## clean work directory
rm(list = ls());
DiTech_directory <- "E:/GitHub/Di-Tech-Chanllenge/Di-Tech-Challenge/"
## training data directory setting
## data from season_1----------------------------------------------
Ditech_originData_path_season_1 <- "E:/GitHub/Di-Tech-Chanllenge/Di-Tech-Challenge_Origin_Data/season_1/"

training_order_data_path_season_1 <- paste0(Ditech_originData_path_season_1,"training_data/order_data")
training_traffic_data_path_season_1 <- paste0(Ditech_originData_path_season_1,"training_data/traffic_data")
training_weather_data_path_season_1 <- paste0(Ditech_originData_path_season_1,"training_data/weather_data")
training_cluster_map_path_season_1 <- paste0(Ditech_originData_path_season_1,"training_data/cluster_map/cluster_map")
training_poi_data_path_season_1 <- paste0(Ditech_originData_path_season_1,"training_data/poi_data/poi_data") 

## test data 1 directory setting 
test_order_data_path_season_1_set_1 <- paste0(Ditech_originData_path_season_1,"test_set_1/order_data")
test_traffic_data_path_season_1_set_1  <- paste0(Ditech_originData_path_season_1,"test_set_1/traffic_data")
test_weather_data_path_season_1_set_1  <- paste0(Ditech_originData_path_season_1,"test_set_1/weather_data")
test_cluster_map_path_season_1_set_1  <- paste0(Ditech_originData_path_season_1,"test_set_1/cluster_map/cluster_map")
test_poi_data_path_season_1_set_1  <- paste0(Ditech_originData_path_season_1,"test_set_1/poi_data/poi_data") 


## data_saving_path
training_data_saving_path_season_1 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/season_1/training_data/")
test_data_saving_path_season_1_set_1 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/season_1/test_set_1/")

cleaned_data_saving_path_season_1 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/cleaned_data/season_1/")
## ------------------------------------------------------------data from season_1

## data from season_2---------------------------------------------------
Ditech_originData_path_season_2 <- "E:/GitHub/Di-Tech-Chanllenge/Di-Tech-Challenge_Origin_Data/season_2/"

training_order_data_path_season_2 <- paste0(Ditech_originData_path_season_2,"training_data/order_data")
training_traffic_data_path_season_2 <- paste0(Ditech_originData_path_season_2,"training_data/traffic_data")
training_weather_data_path_season_2 <- paste0(Ditech_originData_path_season_2,"training_data/weather_data")
training_cluster_map_path_season_2 <- paste0(Ditech_originData_path_season_2,"training_data/cluster_map/cluster_map")
training_poi_data_path_season_2 <- paste0(Ditech_originData_path_season_2,"training_data/poi_data/poi_data") 

## test data 1 directory setting 
test_order_data_path_season_2_set_2 <- paste0(Ditech_originData_path_season_2,"test_set_2/order_data")
test_traffic_data_path_season_2_set_2  <- paste0(Ditech_originData_path_season_2,"test_set_2/traffic_data")
test_weather_data_path_season_2_set_2  <- paste0(Ditech_originData_path_season_2,"test_set_2/weather_data")
test_cluster_map_path_season_2_set_2  <- paste0(Ditech_originData_path_season_2,"test_set_2/cluster_map/cluster_map")
test_poi_data_path_season_2_set_2  <- paste0(Ditech_originData_path_season_2,"test_set_2/poi_data/poi_data") 


## data_saving_path
training_data_saving_path_season_2 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/season_2/training_data/")
test_data_saving_path_season_2_set_2 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/season_2/test_set_2/")
## -----------------------------------------------------------data from season_2


## cleaned data saving path from season_2
cleaned_data_saving_path_season_2 <- paste0(DiTech_directory, "../Di-Tech-Challenge_Working_Data/cleaned_data/season_2/")






