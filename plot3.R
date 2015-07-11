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
  )  %>%
  select (Sub_metering_1, Sub_metering_2, Sub_metering_3, Date, Time) %>%
  mutate(date_time = paste (Date, Time))

## Plot
x <- strptime(data$date_time, format = "%d/%m/%Y %H:%M:%S")
png('plot3.png', bg = "transparent", width = 504, height = 504)
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
  "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red", "blue")
))
dev.off()