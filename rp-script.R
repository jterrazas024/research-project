path <- "~/Desktop/tmp/test folder/"

files <- list.files(path=path, pattern="*.csv")

for(file in files)
{
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub(" ","",substr(file, 1, perpos-1)), 
    read.csv(paste(path,file,sep="")))
}

#converting to xts
str(AB)

AB$timestamp <- as.character(AB$timestamp)

AB$timestamp <- as.POSIXct(AB$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

AB$timestamp <- as.character(AB$timestamp)

AB$timestamp <- as.POSIXct(AB$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(AB, is.na(AB))

#these were the rows that contained NA variables 
AB <- AB[-c(7113,15416),]

#or use na.omit
AB.nona <- na.omit(AB)

ABxts <- xts(AB.nona$users_holding, order.by = AB.nona$timestamp)

#converting test folder to xts
#Acopy
str(Acopy)

Acopy$timestamp <- as.character(Acopy$timestamp)

Acopy$timestamp <- as.POSIXct(Acopy$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(Acopy, is.na(Acopy))

Acopy.nona <- na.omit(Acopy)

Axts <- xts(Acopy.nona$users_holding, order.by = Acopy.nona$timestamp)


#AACAYcopy
str(AACAYcopy)

AACAYcopy$timestamp <- as.character(AACAYcopy$timestamp)

AACAYcopy$timestamp <- as.POSIXct(AACAYcopy$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(AACAYcopy, is.na(AACAYcopy))

AACAYcopy.nona <-  na.omit(AACAYcopy)

AACAYxts <- xts(AACAYcopy.nona$users_holding, order.by = AACAYcopy.nona$timestamp)

#AACGcopy
str(AACGcopy)

AACGcopy$timestamp <- as.character(AACGcopy$timestamp)

AACGcopy$timestamp <- as.POSIXct(AACGcopy$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(AACGcopy, is.na(AACGcopy))

AACGcopy.nona <-  na.omit(AACGcopy)

AACGxts <- xts(AACGcopy.nona$users_holding, order.by = AACGcopy.nona$timestamp)

#AAcopy
str(AAcopy)

AAcopy$timestamp <- as.character(AAcopy$timestamp)

AAcopy$timestamp <- as.POSIXct(AAcopy$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(AAcopy, is.na(AAcopy))

AAcopy.nona <-  na.omit(AAcopy)

AAxts <- xts(AAcopy.nona$users_holding, order.by = AAcopy.nona$timestamp)

#AADRcopy
str(AADRcopy)

AADRcopy$timestamp <- as.character(AADRcopy$timestamp)

AADRcopy$timestamp <- as.POSIXct(AADRcopy$timestamp, tz = "", format = "%Y-%m-%d %H:%M:%OS")

subset(AADRcopy, is.na(AADRcopy))

AADRcopy.nona <-  na.omit(AADRcopy)

AADRxts <- xts(AADRcopy.nona$users_holding, order.by = AADRcopy.nona$timestamp)


#getting stock prices A, AA, AACAY, AACG, AADR
install.packages("quantmod")
library(quantmod)
Astock <- getSymbols("A", auto.assign = FALSE)
AAstock <- getSymbols("AA", auto.assign = FALSE)
AACAYstock <- getSymbols("AACAY", auto.assign = FALSE)
AACGstock <- getSymbols("AACG", auto.assign = FALSE)
AADRstock <- getSymbols("AADR", auto.assign = FALSE)

#getting only the closing prices
Astock.closing <- Cl(Astock)
AAstock.closing <- Cl(AAstock)
AACAYstock.closing <- Cl(AACAYstock)
AACGstock.closing <- Cl(AACGstock)
AADRstock.closing <- Cl(AADRstock)

#calculating daily returns
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

Astock.dailyreturns <- CalculateReturns(Astock.closing)

#plotting returns to visualize returns 
plot(Astock.dailyreturns["2018/2020"])
#plotting returns to visualize returns 


AAstock.dailyreturns <- CalculateReturns(AAstock.closing)
AACAYstock.dailyreturns <- CalculateReturns(AACAYstock.closing)
AACGstock.dailyreturns <- CalculateReturns(AACGstock.closing)
AADRstock.dailyreturns <- CalculateReturns(AADRstock.closing)

#difference in RH participation???
A.diffp <- diff(Axts)
AA.diffp <- diff(AAxts)
AACAY.diffp <- diff(AACAYxts)
AACG.diffp <- diff(AACGxts)
AADR.diffp <- diff(AADR.xts)

#test
