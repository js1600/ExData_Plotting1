plot1 <- function() {
# If the zip file does not exist in the temp directory, then get it at the url.
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
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
# Plot the data as a histogram.
        hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
