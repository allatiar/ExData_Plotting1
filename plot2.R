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
  select (Global_active_power, Date, Time) %>%
  mutate(date_time = paste (Date, Time))

##plot
x <- strptime(data$date_time, format = "%d/%m/%Y %H:%M:%S")
png('plot2.png', bg = "transparent", width = 504, height = 504)
with(
  data, plot(
    x = x, y = data$Global_active_power,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)"
  )
)
dev.off()