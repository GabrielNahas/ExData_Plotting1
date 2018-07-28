#1.Read only the data between days 1/2/2007 and 2/2/2007
file <- "household_power_consumption.txt"
data.row1 <- read.table(file, header = TRUE, nrow = 1, sep = ";")
nc <- ncol(data.row1)
data.Date <- read.table(file, header = TRUE, as.is = TRUE, sep = ";", 
                      colClasses = c(NA, rep("NULL", nc - 1)))
dates_wanted <- which(data.Date == "1/2/2007" | data.Date == "2/2/2007")
data <- read.table(file, col.names = names(data.row1), skip = dates_wanted[1], 
                   nrow = length(dates_wanted), as.is = TRUE, sep = ";")

#2. Create plot
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col="red", main = "Global Active Power", ylim = c(0,1200))

#3. Print plot to PNG file
dev.copy(png,'plot1.png')

#4. Close PNG device
dev.off()