## Download and unzip the file:

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "explor1.zip")
unzip("explor1.zip")

## Identify the dataset's column classes and header names for faster/easier import:

tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)
colnames <- names(tab5rows)

## Use pipe() with findstr to subset the data to only dates 1/2/2007 and 2/2/2007
## NOTE:  findstr within pipe() works only for Windows - alternative is to read in full
## dataset and then subset using subset <- data[grep("^[1-2]/2/2007", data[,1]),]

data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), 
                   header = F, sep=";", na.strings = "?", colClasses = classes,
                   col.names = colnames)

## Convert "Date" and "Time" variables from class == factor to class == date & time

data[,1] <- as.Date(data[,1], "%d/%m/%Y")
data[,2] <- list(strptime(paste(data[,1], data[,2]), "%Y-%m-%d %H:%M:%S"))

## Create line graph from the Global_active_power variable

png(file = "plot2.png")
plot(data$Time, data$Global_active_power, type = "l", 
          ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()