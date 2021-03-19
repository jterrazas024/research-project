
library(data.table)
AA_robin <- fread("data/AA.csv")

# Converting to xts
library(xts)
AA_robin <- xts(AA_robin$users_holding, order.by = AA_robin$timestamp)

# RobinTrack data has weekend observations? 
AA_robin <- AA_robin[.indexwday(AA_robin) %in% 1:5]

# Convert intraDay to daily periodicity, without Open-High-Low data for now...
AA_robin_D <- to.daily(AA_robin, OHLC = FALSE)

# create a diff measure on RobinTrack 
AA_robin_D_norm <- diff(log(AA_robin_D))

# get price data, matching the range of the RobinTrack data
library(quantmod)
getSymbols("AA", from = index(AA_robin_D)[1], to = index(AA_robin_D_norm)[length(AA_robin_D_norm)])

# Get returns
library(PerformanceAnalytics)
AA_Rts <- Return.calculate(AA$AA.Adjusted, method = "log")

# merge data, normalized RobinTrack data, daily equity returns, and daily volume
AA_complete <- merge(AA_robin_D_norm, AA_Rts, AA$AA.Volume)

# Remove observations with NAs
AA_complete <- na.omit(AA_complete)

## plots to explore
plot(AA_complete$AA_robin_D_norm[-1])
plot(AA_complete$AA.Adjusted)
plot(AA_complete$AA.Volume)

## models

 # We will estimate GARCH(1,1) with ARMA(1,1)
library(rugarch)

Spec <-ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)),
                  mean.model=list(armaOrder=c(1,1)),
                  distribution.model="std") 

Garch <- ugarchfit(spec=Spec, data=AA_complete)

Garch



