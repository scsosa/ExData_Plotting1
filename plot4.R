##-------------------------  plot4.R ----------------------------------
##
##   This R script produces plot 4 for the course Exploratory Data
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
if (all(workfile$Global_active_power != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Global_active_power != "?")
}
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
if (all(workfile$Voltage != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Voltage != "?")
}
if (all(workfile$Global_reactive_power != "?") == FALSE){
  print("Missing Values Found - Eliminating Missing Data from Plot")
  workfile <- subset(workfile, Global_reactive_power != "?")
}
##--------------  Plot Data and Print Plot to File  -------------------
## plot 4 - 4 graphs - graphs #2 & #3 plus 2 new graphs

##  set up plotting field
par(mfcol = c(2,2), cex.lab = .7, cex.axis = .7)     ##  2 x 2

with(workfile, {
  ##  plot 1
  plot(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
       Global_active_power, xlab="",
       ylab = "Global Active Power", type = "l")
  
  ## plot 2 with NO box around legend
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
         bty = "n", lty = c(1,1,1), col=c("black","red","blue"), cex = 0.5,
         text.width = strwidth("sub_metering"), xjust = 1, y.intersp = .25)
    
  ## plot 3
  plot(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
       Voltage, xlab="datetime", ylab = "Voltage", type = "l")
  
  ## plot 4
  plot(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
       Global_reactive_power, xlab="datetime", type = "l", yaxt = "n")
  axis(side=2, at=seq(0, .5, by = .1), labels = c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5"),
       cex.axis = .5)
})
dev.copy(png,file="plot4.png")
dev.off()
##  end plot4.R