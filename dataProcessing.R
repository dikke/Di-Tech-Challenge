#setwd("/Users/sheliaxin/Documents/Duke/DIDI/season_1")
# to predict

load(paste0(training_data_saving_path_season_2,"cluster.Rdata"))
load(paste0(cleaned_data_saving_path_season_2,"data_test.Rdata"))

toPredict <- read.table(paste0(Ditech_originData_path_season_2,"test_set_2/read_me_2.txt"), header = FALSE)
names(toPredict) <- c("time")
toPredict = cbind(toPredict, date = as.Date(strptime(as.character(toPredict$time),'%Y-%m-%d-%t',tz = "GMT")))
toPredict["timeslot"] = as.numeric(substring(toPredict$time,12))

toPredict["toPre"] = 1
district = as.data.frame(unique(cluster[2]))
names(district) = "district_ID"
toPredict = merge(district,toPredict,all = TRUE)



data_toPre = data_test %>%
    full_join(toPredict, by = c("district_ID"= "district_ID", "date"="date","timeslot"="timeslot")) %>%
    arrange(district_ID,date,timeslot)
data_toPre["wday"] = format(data_toPre$date,'%A')
head(data_toPre)
save(data_toPre, file = "data_toPre.Rdata")


## for training

str(data_toPre)



pre_xg <- function(data_pre, isTest){
    ## processing
    data_pre <- data.table(data_pre)
    data_pre[,gap_1 := shift(gap,n=1)]
    data_pre[,gap_2 := shift(gap,n=2)]
    data_pre[,gap_3 := shift(gap,n=3)]
    
    data_pre[,traffic_value_1 := shift(traffic_LValue,n=1)]
    data_pre[,traffic_value_2 := shift(traffic_LValue,n=2)]
    data_pre[,traffic_value_3 := shift(traffic_LValue,n=3)]
    
    data_pre[,temperature_1 := shift(temperature_m,n=1)]
    data_pre[,temperature_2 := shift(temperature_m,n=2)]
    data_pre[,temperature_3 := shift(temperature_m,n=3)]
    
    data_pre[,PM2.5_1 := shift(PM2.5_m,n=1)]
    data_pre[,PM2.5_2 := shift(PM2.5_m,n=2)]
    data_pre[,PM2.5_3 := shift(PM2.5_m,n=3)]
    
    data_pre_processed <- subset(data_pre,is.na(gap) == TRUE)
    
    if(!isTest){
        data_pre_train <- data_pre_processed
        save(data_train2, file = "data_pre_train2.RData")
    }else{
        data_pre_test <- data_pre_processed
        save(data_pre_test, file = "data_pre_test2.RData")
    }
    
    
}

pre_xg(data_toPre,1)

data_train = cbind(data, toPre = 1)
data_train["wday"] =format(data_train$day,"%A")
pre_xg(data_train,0)