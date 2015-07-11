library(dplyr)

## Read data from file
data <-
  read.csv2(file = "household_power_consumption.txt", dec = ".", na.strings = "?")

## Filter data
data <-
  filter(
    data, as.Date(Date, '%d/%m/%Y') == as.Date('01/02/2007', '%d/%m/%Y') |
      as.Date(Date, '%d/%m/%Y') == as.Date('02/02/2007', '%d/%m/%Y')
  )

## plot histogram
png('plot1.png', bg = "transparent", width = 504, height = 504)
with(
  data, hist(
    data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"
  )
)
dev.off()