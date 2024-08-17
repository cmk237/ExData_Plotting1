url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file <- "data.zip"
download.file(url, file)
unzip("data.zip")
file.remove("data.zip")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
data <- data[data$Date %in% c('1/2/2007', '2/2/2007'), ]
data[data == '?'] <- NA
data$Global_active_power <- as.numeric(data$Global_active_power)
png("plot.png")
hist(data$Global_active_power, main = "Global Active Power", xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', col = 'red')
dev.off()
