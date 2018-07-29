#1.Read only the data between days 1/2/2007 and 2/2/2007
file <- "household_power_consumption.txt"
data.row1 <- read.table(file, header = TRUE, nrow = 1, sep = ";")
nc <- ncol(data.row1)
data.Date <- read.table(file, header = TRUE, as.is = TRUE, sep = ";", 
                        colClasses = c(NA, rep("NULL", nc - 1)))
dates_wanted <- which(data.Date == "1/2/2007" | data.Date == "2/2/2007")
data <- read.table(file, col.names = names(data.row1), skip = dates_wanted[1], 
                   nrow = length(dates_wanted), as.is = TRUE, sep = ";")

#2. Condensate time & date together
time <- paste(data$Date, data$Time)
data$completetime <- strptime(time, format = "%d/%m/%Y %H:%M:%S")

#3. Set parameters to have four plots
par(mfrow = c(2,2))

#4. Create 1st plot (Global Active Power in function of time)
plot(x = data$completetime, y = data$Global_active_power, type = "l"
     , ylab = "Global Active Power (kilowatts)", xlab="")

#5. Create 2nd plot (Voltage in function of time)
plot(x = data$completetime, y = data$Voltage, type = "l"
     , ylab = "Voltage", xlab="datetime")

#6. Create 3rd plot (Global Active Power in function of time)
plot(x = data$completetime, y = data$Sub_metering_1, type = "l"
     , col = "black", ylab = "Energy sub metering", xlab="")
lines(x = data$completetime, y = data$Sub_metering_2, col="red")
lines(x = data$completetime, y = data$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"),
       col=c("black","red", "blue"), lty=1, cex = 0.7, bty="n", y.intersp = 0.5)

#7. Create 4th plot (Global Reactive Power in function of time)
plot(x = data$completetime, y = data$Global_reactive_power, type = "l"
     , ylab = "Global_reactive_Power", xlab="datetime")

#8. Print plot to PNG file
dev.copy(png,width = 480, height = 480,'plot4.png')

#9. Close PNG device
dev.off()