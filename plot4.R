################################################################
# Coursera - Exploratory Data Analysis
# https://class.coursera.org/exdata-032
#
# Course Project 1
# plot4.R - code to generate plot4.png
# Written by: ddraayer
################################################################

setwd("~/Documents/Coursera/ExploratoryDataAnalysis/ExData_Plotting1")


##### Load and finagle data #####

# Grab column names from first row of data file (the 'skip' arg used below
# skips the header row too).
df <- read.table('household_power_consumption.txt',
                 sep=";", header=TRUE, nrows=1)
headers <- names(df)

# For data, grab only the rows for the two days of interest
df <- read.table('household_power_consumption.txt',
                sep=';', na.strings='?',
                skip=66637, nrows=69517-66637)
names(df) <- headers

# Add a Timestamp column by combining Date & Time string columns and converting
# that to a POSIXct.
df <- transform(df, Timestamp=as.POSIXct(paste(df$Date, df$Time, sep=" "),
                                         format="%d/%m/%Y %H:%M:%S", tz="UTC"))

### OK, the data are now ready in dataframe 'df' ###


##### Code for Plot 4 #####
png('plot4.png')
par(mfcol=c(2,2))

# Plot A
plot(df$Timestamp, df$Global_active_power,
        ylab="Global Active Power",
        xlab="",
        type="n")
lines(df$Timestamp, df$Global_active_power)

# Plot B
plot(df$Timestamp, df$Sub_metering_1, xlab="", ylab="Energy sub metering", type="s", col="black")
points(df$Timestamp, df$Sub_metering_2, type="s", col="red")
points(df$Timestamp, df$Sub_metering_3, type="s", col="blue")
legend("topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"), lwd=2, bty="n")

# Plot C
plot(df$Timestamp, df$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Plot D
plot(df$Timestamp, df$Global_reactive_power, type="h",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
