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
png(file = "plot2.png")
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt='n')
axis.POSIXct(1, at = data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], labels = format(data$Datetime[which(format(data$Time, "%H:%M:%S") == "00:00:00")], "%A"))
dev.off()