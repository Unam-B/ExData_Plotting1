#Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./Dataset.zip")){download.file(fileUrl,destfile="./Dataset.zip")}
if(!file.exists("./ExData_Plotting1")){dir.create("./ExData_Plotting1")}
if(!file.exists("./household_power_consumption.txt")){unzip(zipfile="./Dataset.zip")}

#Read file into R
data <- read.table("./household_power_consumption.txt", header = T, sep = ";", as.is = T)
setwd("./ExData_Plotting1")
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
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

#Plot 1
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Plot 2
plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#Plot 3
    y = range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))
    
    plot(data$Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", ylim = y)
    par(new = TRUE)
    
    plot(data$Time, data$Sub_metering_2, type = "l", col = "red", xlab = "", ylab = "", axes = F, ylim = y)
    par(new = TRUE)
    
    plot(data$Time, data$Sub_metering_3, type = "l", col = "blue", xlab = "", ylab = "", axes = F, ylim = y)
    par(new = TRUE)
    
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           #bg = "transparent",
           #bty = "n",
           lty = c(1,1,1),
           col = c("black", "red", "blue")
    )

#Plot 4
plot(data$Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off
