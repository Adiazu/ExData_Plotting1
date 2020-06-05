## Loading the libraries I will use
library(data.table)

fileIURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileIURL,destfile = "./Project.zip")
file_names <- unzip('Project.zip')

##Read data into data frames
data <- read.table(unz("Project.zip", "household_power_consumption.txt"),header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")

household <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

household <- household[complete.cases(household),]

household$DateTime <- paste(household$Date, household$Time)
household$DateTime <- as.POSIXct(household$DateTime)

##Creating the first plot

hist(household$Global_active_power,col="red",main="Global Active Power", xlab = "Global Active Power (kilowatts)")

##Saving the plot
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()