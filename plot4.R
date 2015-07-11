library(dplyr)
##Override French locale
Sys.setlocale("LC_ALL", "English")

## Read data from file
data <-
  read.csv2(file = "household_power_consumption.txt", na.strings = "?", dec = ".")

##Filter and tidy data
data <-
  filter(
    data, as.Date(Date, '%d/%m/%Y') == as.Date('01/02/2007', '%d/%m/%Y') |
      as.Date(Date, '%d/%m/%Y') == as.Date('02/02/2007', '%d/%m/%Y')
  ) %>%
  select (
    Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3, Global_reactive_power, Voltage, Date, Time
  ) %>%
  mutate(date_time = paste (Date, Time))


##Plots
x <- strptime(data$date_time, format = "%d/%m/%Y %H:%M:%S")
png('plot4.png', bg = "transparent", width = 504, height = 504)
with(data, par(mfrow = c(2,2)))
##Plot1
with(
  data, plot(
    x = x, y = data$Global_active_power,type = "l",xlab = "", ylab = "Global Active Power"
  )
)
##Plot2
with(data, plot(
  x = x, y = data$Voltage,type = "l", xlab = "datetime", ylab = "Voltage"
))
##Plot3
with(data, plot(
  x = x, y = data$Sub_metering_1,type = "n", xlab = "", ylab = "Energy sub metering"
))
with(data, lines(
  x = x, y = data$Sub_metering_1,  col = "black"
))
with(data, lines(
  x = x, y = data$Sub_metering_2, col = "red"
))
with(data, lines(
  x = x, y = data$Sub_metering_3, col = "blue"
))
with(data, legend(
  "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red", "blue"), bty = "n"
))
##Plot4
with(
  data, plot(
    x = x, y = data$Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power"
  )
)
##End of plotting
dev.off()