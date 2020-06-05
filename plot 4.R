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


##Creating the fourth plot

    par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
    
        ##top right
    plot(household$Global_active_power~household$DateTime,xlab = "",ylab = "Global Active Power (kilowatts)",type = "l")
        ##top left
    
    plot(household$Voltage~household$DateTime,xlab = "datetime",ylab = "Voltage",type = "l")
    
        ##bottom left
    plot(household$Sub_metering_1~household$DateTime,type="l",xlab="",ylab = "Global Active Power (kilowatts)")
    lines(household$Sub_metering_2~household$DateTime,col='Red')
    lines(household$Sub_metering_3~household$DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex = 0.7)
    
    
        ##bottom right
    
    plot(household$Global_reactive_power~household$DateTime,xlab = "datetime",ylab = "Global_reactive_power",type = "l")


##Saving the plot
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()