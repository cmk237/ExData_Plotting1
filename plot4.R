url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file <- "data.zip"
download.file(url, file)
unzip("data.zip")
file.remove("data.zip")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
data[data == '?'] <- NA
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$Global_active_power <- as.numeric(data$Global_active_power)
datetime <- paste((data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
data$Time <- as.POSIXct(data$Time, format="%H:%M:%S")
png(file = "plot4.png")
par(mfrow=c(2,2))
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt='n')
axis.POSIXct(1, at = data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], labels = format(data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], "%A"))

plot(data$Datetime, data$Voltage, type = 'l', xlab='datetime', ylab='Voltage', xaxt='n')
axis.POSIXct(1, at = data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], labels = format(data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], "%A"))

plot(data$Datetime, data$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering", xaxt='n')
lines(data$Datetime, data$Sub_metering_2, col = 'red')
lines(data$Datetime, data$Sub_metering_3, col = 'blue')
axis.POSIXct(1, at = data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], labels = format(data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], "%A"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

plot(data$Datetime, data$Global_reactive_power, type = 'l', xlab='datetime', ylab='Global_reactive_power', xaxt='n')
axis.POSIXct(1, at = data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], labels = format(data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], "%A"))

dev.off()