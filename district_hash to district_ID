#I used hash table to convert the district_hash to district_ID in traffic, which makes it more readable

#create a hash table represents cluster
#district_hash is key and district_ID is value
cluster_env<-new.env()
for(i in 1:nrow(cluster))
{
  key = as.character(cluster[i,1])
  value = as.numeric(cluster[i,2])
  cluster_env[[key]] <- value
}
ls.str(cluster_env)

#find the district_ID of district_hash in traffic
traffic_ID = c()
for(i in 1:nrow(traffic)){
  key = as.character(traffic[i,1])
  value = get(key, envir = cluster_env, inherits = FALSE)
  traffic_ID = c(traffic_ID, value)
}
traffic = cbind(traffic_ID, traffic[,-1])
