##-------------------------  plot2.R ----------------------------------
##
##   This R script produces plot 2 for the course Exploratory Data
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
##--------------  Plot Data and Print Plot to File  -------------------
##  Plot 2 - Line Chart
with(workfile, plot(as.POSIXct(strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")),
                    Global_active_power, xlab="",
                    ylab = "Global Active Power (kilowatts)", type = "l"))
dev.copy(png,file="plot2.png")
dev.off()
## End Plot 2