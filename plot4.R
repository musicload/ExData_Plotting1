## This is the R script to generate the fourth plot.
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

# Produce a series of plots in a 2x2 grid, and write it to a PNG file (size of 480x480 pixels is default)
# (using the fixed axis labels for simplicity)
# margins are CCW - DOWN(x), LEFT(y), UP, RIGHT
    par(mfrow = c(2,2), mar = c(4,4,1,1), oma = c(0,0,0,0))
# Plot 1,1 (top left) - "Global Active Power"
    plot (power$Global_active_power, xlab = "", xaxt = "n", type = "l", ylab = "Global Active Power")
    axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
# Plot 1,2 (top right) - "Voltage"
    plot(power$Voltage, xlab = "datetime", xaxt = "n", type = "l", ylab = "Voltage")
    axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
# Plot 2,1 (bottom left) - "Energy sub metering" with line comparison
    plot (power$Sub_metering_1, type = "l", col="black", xaxt = "n", xlab = "", ylab = "Energy sub metering")
    lines (power$Sub_metering_2, col="red")
    lines (power$Sub_metering_3, col="blue")
    axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
    legend(2170,45, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), x.intersp=0, xjust=1, cex = 0.7, col = c("black","red","blue"), lwd = 1, lty = 1, bty= "n")
# Plot 2,2 (bottom right) - "Global_reactive_power"
    plot(power$Global_reactive_power, xlab = "datetime", xaxt = "n", type = "l", ylab = "GLobal_reactive_power")
    axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
# Write to the output file
    dev.copy(png, file="plot4.png")
    dev.off()
