## This is the R script to generate the second plot.
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

# Produce a line plot of Global Active Power, and write it to a PNG file (size of 480x480 pixels is default)
# (using the fixed axis labels for simplicity)
plot (power$Global_active_power, xlab = "", xaxt = "n", type = "l", ylab = "Global Active Power (kilowatts)")
axis (1, c(1,1441,2880), c("Thu","Fri","Sat"))
dev.copy(png, file="plot2.png")
dev.off()
