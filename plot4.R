## Download dataset https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## to the working directory and unzip it before running this code
##
## Set the working directory properly. For example,
## the following code sets the working directory based
## on relative path:
## setwd("../onedrive/documents/training/projects/EDA1")
##
## This code validates the unzipped file exists
## (working directory/exdata_data_household_power_consumption/
##  household_power_consumption.txt) and then creates a
## histogram in the output file

# It is always a good idea to first clear the workspace
rm(list = ls())

## constants
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
unzippedFilePath <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
plotFilePath <- "./plot4.png"

## does the file exist?
if (!file.exists(unzippedFilePath))
{
	print(paste0("File '", unzippedFilePath, "' does not exist"))
	print(paste0("Download dataset ", dataFileURL, " to working directory and and unzip it"))
}

## read data
powerDF <- read.table(unzippedFilePath, na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)

## add a new column by combining date and time
powerDF$datetime = strptime(paste(powerDF$Date,powerDF$Time), "%d/%m/%Y %H:%M:%S")

## subset the data (all of 2007-02-01 and 2007-02-02)
df <- subset(powerDF, datetime > "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00")

## open graphics device
png(filename = plotFilePath, width = 480, height = 480)

## set rows and columns
par(mfrow = c(2,2))

## ROW:1 COL:1 - Global active power
plot(df$datetime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## ROW:1 COL:2 - Voltage
plot(df$datetime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## ROW:2 COL:1 - Sub_metering
plot (df$datetime, df$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines (df$datetime, df$Sub_metering_2, col = "red")
lines (df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	   col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")
	   
## ROW:2 COL:2 - Global reactive power
plot(df$datetime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
	   
## close the device
dev.off()