## This is the R script to generate the third plot.
# To save the space on GitHub, the original file is not included here,
# though the commands for reading the file are provided. The file can be downloaded and unzipped from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## I have chosen to use the "sqldf" package to efficiently read a subset of the source file.
# If the package is not installed yet, you can add it by running install.packages("sqldf")

# Read the input file
library(sqldf)
file <- "household_power_consumption.txt"
power <- read.csv.sql(file, header = TRUE, sep = ";", sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ')

# Convert date and time
power$Date <- as.Date(power$Date,"%d/%m/%Y")

# Produce a series of line plots of Global Active Power, and write it to a PNG file (size of 480x480 pixels is default)
# (using the fixed axis labels for simplicity)
plot (power$Sub_metering_1, type = "l", col="black", xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines (power$Sub_metering_2, col="red")
lines (power$Sub_metering_3, col="blue")
axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
legend(2600,42, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), x.intersp=0, xjust=1, cex = 0.7, col = c("black","red","blue"), lwd = 1, lty = 1, bty= "n")
dev.copy(png, file="plot3.png")
dev.off()
