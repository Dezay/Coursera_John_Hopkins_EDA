library(tidyverse)
library(lubridate)

if(!dir.exists("data")) { dir.create("data") }


data.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.path  <- "data/household_power_consumption.zip"
data.unzip <- "data/household_power_consumption.txt"

if(!file.exists(data.path) & !file.exists(data.unzip)) {
  download.file(data.url, data.path)
  unzip(data.path, exdir = "data")
}


data <- read_delim("data/household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))


data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))


plot(Global_active_power ~ datetime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)


dev.copy(png, "Plot 2.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())