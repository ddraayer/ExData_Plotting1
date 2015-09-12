################################################################
# Coursera - Exploratory Data Analysis
# https://class.coursera.org/exdata-032
#
# Course Project 1
# plot1.R - code to generate plot1.png
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


##### Code for Plot 1 #####
png('plot1.png')
hist(df$Global_active_power,
        main="Global Active Power",
        xlab="Global Active Power (kilowatts)",
        col="red")
dev.off()
