##-------------------------  plot3.R ----------------------------------
##
##   This R script produces plot 3 for the course Exploratory Data
##   Analysis - Project 1
##
## --------------------   Initialize Varaibles -------------------------
library(Defaults)
setDefaults('as.Date.character', format = '%d/%m/%Y')
filename <- c("household_power_consumption.txt")

##-----------------  Download and Read File ----------------------------

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
filedata <- read.csv2(unz(temp, filename),stringsAsFactors = FALSE, 
                      colClasses = c("Date", "character", "character", "character",
                                     "character", "character", "character",
                                     "character", "character"), nrows = 2075259)

##-----------------------  Subset Data  -------------------------------
workfile <- subset(filedata, Date == as.Date("2007-02-01","%Y-%m-%d") | 
                     Date == as.Date("2007-02-02","%Y-%m-%d"))

##------------------------  Clean Data  -------------------------------
##   ? indicates missing values
if (all(workfile$Sub_metering_1 != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Sub_metering_1 != "?")
}
if (all(workfile$Sub_metering_2 != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Sub_metering_2 != "?")
}
if (all(workfile$Sub_metering_3 != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Sub_metering_3 != "?")
}

##--------------  Plot Data and Print Plot to File  -------------------
##  Plot 3 - 
with(workfile, {
  plot(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
       Sub_metering_1, xlab="", ylab = "Energy sub metering",
       type = "n")
  lines(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
        Sub_metering_1)
  lines(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
        Sub_metering_2, col = "red")
  lines(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
        Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty = c(1,1,1), col=c("black","red","blue"), cex = 0.7,
         text.width = strwidth("sub_metering_1"), y.intersp = .5)
})
dev.copy(png,file="plot3.png")
dev.off()
##  End plot3.R