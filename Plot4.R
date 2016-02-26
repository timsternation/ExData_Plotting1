# Read data from file
hhdata <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",header = T)

#Convert Date column from factor variable to Date object, store in new column
hhdata$d1 <- as.Date(hhdata$Date, format='%d/%m/%Y')

#Subset the two days we want, February 1-2, 2007
twodays <- hhdata[which(hhdata$d1 == as.Date("01/02/2007",format="%d/%m/%Y")
                        |hhdata$d1 == as.Date("02/02/2007",format="%d/%m/%Y")),]

#Create a datetime object that combines the d1 date column we created with
# the Time column
twodays$dt1 <- with(twodays, as.POSIXct(paste(d1,Time, 
                                              format = "%d/%m/%Y %H:%M:%S")))

#Activate PNG device with appropriate filename
png("Plot4.png",width=480,height = 480, units = "px")

#Set parameter for 2 rows of 2 columns
par(mfrow = c(2,2))

#adjust margins
par(mar = c(5.1,4.1,1.1,2.1))

#Generate plots
#top left plot
with(twodays,plot(dt1,Global_active_power, cex.axis=.6, cex.lab=.6, 
                  xlab = "", ylab = "Global Active Power (kilowatts)",type = "n"))

with(twodays, lines(dt1,Global_active_power))

#top right plot
with(twodays,plot(dt1,Voltage, cex.axis=.6, cex.lab=.6, 
                  xlab = "datetime", ylab = "Voltage",type = "n"))

with(twodays, lines(dt1,Voltage))

#bottom left plot
with(twodays,plot(dt1,Sub_metering_1, type="n", xlab = "",
                  ylab = "Energy sub metering", cex.lab = .6, cex.axis = .6))
with(twodays, lines(dt1, Sub_metering_1))
with(twodays, lines(dt1, Sub_metering_2, col="red"))
with(twodays, lines(dt1, Sub_metering_3, col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), col = c("black","red","blue"), cex = .45)

#bottom right plot
with(twodays,plot(dt1,Global_reactive_power, cex.axis=.6, cex.lab=.6, 
                  xlab = "datetime", ylab = "Global_reactive_power",type = "n"))

with(twodays, lines(dt1,Global_reactive_power))

#turn off graphic device
dev.off()
