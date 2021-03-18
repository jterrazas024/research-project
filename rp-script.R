
library(xts)
library(data.table)

path <- "data/"
files <- list.files(path=path, pattern="*.csv")

for(file in files)
{
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub(" ","",substr(file, 1, perpos-1)), 
    fread(paste(path,file,sep="")))
}

#converting to xts
str(AB)
ABxts <- xts(AB$users_holding, order.by = AB$timestamp)

# convert intra-day to daily periodicity, witouth Open-High-Low data for now...
ABxtsDaily <- to.daily(ABxts,  OHLC = FALSE)

#converting test folder to xts
Axts <- xts(A$users_holding, order.by = A$timestamp)

#AACAYcopy
str(AACAY)
AACAYxts <- xts(AACAY$users_holding, order.by = AACAY$timestamp)

#AACGcopy
str(AACG)
AACGxts <- xts(AACG$users_holding, order.by = AACG$timestamp)

#AAcopy
str(AAcopy)
AAxts <- xts(AA$users_holding, order.by = AA$timestamp)

#AADRcopy
str(AADRcopy)

AADRxts <- xts(AADRcopy.nona$users_holding, order.by = AADRcopy.nona$timestamp)

#getting stock prices A, AA, AACAY, AACG, AADR
library(quantmod)
Astock <- getSymbols("A", auto.assign = FALSE)
AAstock <- getSymbols("AA", auto.assign = FALSE)
AACAYstock <- getSymbols("AACAY", auto.assign = FALSE)
AACGstock <- getSymbols("AACG", auto.assign = FALSE)
AADRstock <- getSymbols("AADR", auto.assign = FALSE)

# perh
test_stocks <- gsub(".csv", "", files[3:8])
getSymbols(test_stocks, from = "2018-05-01", to = "2020-08")

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
AADR.diffp <- diff(AADRxts)

#testing to see if I could set up a regression 
cor(A.diffp[,1], Astock.dailyreturns[,1])
plot(A.diffp[,1], Astock.dailyreturns[,1])


