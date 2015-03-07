plot4 <- function() {
# If the zip file does not exist in the temp directory, then get it at the url.
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
# Read the unzipped file.
power <- read.table(file, header=T, sep=";")
# Set the format for the variable Date to be in the D/M/Y format.
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
# Pull only data that is in the date range 02/01/2007 to 02/02/2007.
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
# Uniform clean up of data.
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
# Convert the Date and Time to a DateTimestamp.
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
# Set up the parameter for how many plots to output.
# Two rows with two columns.
        par(mfrow=c(2,2))
# This is for PLOT 1
        plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# This is for PLOT 2
        plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
# This is for PLOT 3
        plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1)) 
# This is for PLOT 4
        plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
# Write the file out.
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
