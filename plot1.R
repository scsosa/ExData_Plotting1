##-------------------------  plot1.R ----------------------------------
##
##   This R script produces plot 1 for the course Exploratory Data
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
##  Plot 1 - Histogram
hist(as.numeric(workfile$Global_active_power), main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     col = "orangered")
dev.copy(png,file="plot1.png")
dev.off()
##  End Plot 1