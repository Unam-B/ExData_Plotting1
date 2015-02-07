#Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./Dataset.zip")){download.file(fileUrl,destfile="./Dataset.zip")}

if(!file.exists("./household_power_consumption.txt")){unzip(zipfile="./ExData_Plotting1/Dataset.zip",exdir="./ExData_Plotting1")}

#Read file into R
data <- read.table("./household_power_consumption.txt", header = T, sep = ";", as.is = T)
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#Subset data between 2007-02-01 and 2007-02-02
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

#Change column classes
data$Time <- paste(data$Date, data$Time, sep=" ")
data$Time <- strptime(data$Time, "%Y-%m-%d %H:%M:%S")
data$Global_active_power <- as(data$Global_active_power, "numeric")
data$Global_reactive_power <- as(data$Global_reactive_power, "numeric")
data$Voltage <- as(data$Voltage, "numeric")
data$Global_intensity <- as(data$Global_intensity, "numeric")
data$Sub_metering_1 <- as(data$Sub_metering_1, "numeric")
data$Sub_metering_2 <- as(data$Sub_metering_2, "numeric")

#Start Plotting Histomgram
png("plot2.png", width = 480, height = 480)
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off