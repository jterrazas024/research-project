path <- "~/Desktop/tmp/robintrackdata/"

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

subset(AB, is.na(AB))

#these were the rows that contained NA variables 
AB <- AB[-c(7113,15416),]

ABxts <- xts(AB$users_holding, order.by = AB$timestamp)