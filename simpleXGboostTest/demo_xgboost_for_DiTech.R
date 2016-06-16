require(xgboost)

# load("Di-Tech-Challenge_Working_Data/cleaned_data/season_2/data_test.Rdata")
# trainDatap <- data_test[,c(1,2,3,5)]
# trainData <- subset(trainDatap,date==as.Date("2016-01-23"),drop=FALSE)[,c(1,3,4)]
# row.names(trainData) <- 1:1824
# trainData <- trainData[1:1700,]
# 
# save(trainData,file = "testData_1700.Rdata")
# rm(data_test,trainDatap)

## please set directory as this file's folder
## clear work directory
## rm(list = ls())
##

load(file = "testData_1700.Rdata")

## built train set matrix
dataMatrix <- data.matrix(trainData)
# set first 1500 as train and next 100 as test in train_set
dtrain <- xgb.DMatrix(data = dataMatrix[1:1500,-3], label = dataMatrix[1:1500,3])
dtest <- xgb.DMatrix(data = dataMatrix[1501:1600,-3], label = dataMatrix[1501:1600,3])
# set predict test_set
dtest_test <- xgb.DMatrix(data = dataMatrix[1601:1700,-3])
# set basic param of xgboost
param <- list(objective = "reg:linear")
# set reg round
n_round <- 20
# set watch list
watchlist <- list(eval = dtest, train = dtrain)
# run xgboost
bst <- xgboost(data = dtrain,
               params = param,
               nrounds = n_round
               )

# run test_set
y_test_pre <- predict(bst,dataMatrix[1:100,-3])


