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


##Creating the thrird plot
plot(household$Sub_metering_1~household$DateTime,type="l",xlab="",ylab = "Energy sub metering")
lines(household$Sub_metering_2~household$DateTime,col='Red')
lines(household$Sub_metering_3~household$DateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


##Saving the plot
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()