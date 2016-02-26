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
png("Plot1.png",width=480,height = 480, units = "px")

#Plot histogram with appropriate specifications
hist(twodays$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", cex.lab = .85, cex.axis = .85)

#turn off graphics device
dev.off()