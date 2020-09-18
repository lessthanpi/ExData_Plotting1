# Coursera Exploratory Data Analysis Proj 1 #

#I try to comment everything!  Sorry if its annoying.



#####################################################
# Part I:  Download, unzip, import, and filter data #
#####################################################


##provided link from instructions ##

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##build a directory(if needed)
#saw this in videos for another course
if(!file.exists("./data2")){dir.create("./data2")}

##grab the file from url ##

download.file(url,destfile="./data2/coursera.zip")

## since it's all zipped, we call this function ##

unzip(zipfile="./data2/coursera.zip",exdir="./data2")

##put it in a table, needs sep, and header ##

df <- read.table("./data2/household_power_consumption.txt"
                 ,sep=";",header=T)

## have a look  ##

dim(df)   #output:  2075259       9     HUGE!!
head(df)

##suggested refinement from assignment ##

feb_1_2007 <- df[df$Date == "1/2/2007", ]
feb_2_2007 <- df[df$Date == "2/2/2007", ]
table_dates <- rbind(feb_1_2007,feb_2_2007)

dim(table_dates)  #output:   2880    9    Much Better!

#####################################################
# End of Part I
#####################################################


#####################################################
# Part II:  Plot 1
#####################################################

#pull the column we need to put in the histogram
hist_data <- as.numeric(table_dates$Global_active_power)

#setup the y-axis
y_ticks <- c(0,1200)

#call the histogram with all the parameters requested
hist(hist_data,col="red",main="Global Active Power",
     xlab = "Global Active Power (Kilowatts)",ylim=y_ticks)

#save the picture to disk with requested resolution and file type
png(file="./data2/plot1.png",
    width=480, height=480)
hist(hist_data,col="red",main="Global Active Power",
     xlab = "Global Active Power (Kilowatts)",ylim=y_ticks)
dev.off()

#####################################################
# End of Part II
#####################################################


#####################################################
# Part III:  Plot 2
#####################################################


#make the time column from feb1 usable numeric
Thursday <- gsub(":","",feb_1_2007$Time)
Thursday <- as.numeric(Thursday)

#same for next day
Friday <- gsub(":","",feb_2_2007$Time)
Friday <- as.numeric(Friday)
#Friday needs to start with its "zero" after Thursday
Friday <- Friday +236000

#glue the days back together for proper list length
days <- append(Thursday,Friday)

#make the requested line graph with paramaters
plot(days,hist_data,type="l",xaxt="none",xlab="",
     ylab="Global Active Power (Kilowatts)")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))

#save the picture to disk with requested resolution and file type
png(file="./data2/plot2.png",
    width=480, height=480)
plot(days,hist_data,type="l",xaxt="none",xlab="",
     ylab="Global Active Power (Kilowatts)")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))
dev.off()

#####################################################
# End of Part III
#####################################################
s1<-table_dates$Sub_metering_1
s2<-table_dates$Sub_metering_2
s3<-table_dates$Sub_metering_3

plot(days,s1,type="l",xaxt="none",xlab="",
     yaxt="none",ylab="Energy Sub Metering",
     col="black",ylim=c(0,40),lwd=2)
lines(days,s2, col = "red")
lines(days,s3, col = "blue")
legend("topright", legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),
        col=c("black","red","blue"),lty=1)
axis(2, at=c(10,20,30),labels=c("10","20","30"))
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))

#save the picture to disk with requested resolution and file type
png(file="./data2/plot3.png",
    width=480, height=480)
plot(days,s1,type="l",xaxt="none",xlab="",
     yaxt="none",ylab="Energy Sub Metering",
     col="black",ylim=c(0,40),lwd=2)
lines(days,s2, col = "red")
lines(days,s3, col = "blue")
legend("topright", legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),
       col=c("black","red","blue"),lty=1)
axis(2, at=c(10,20,30),labels=c("10","20","30"))
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))
dev.off()

#####################################################
# End Part IV
#####################################################

#####################################################
# Part V: Final Plot
#####################################################


#need 2 more line graphs
voltage <- table_dates$Voltage
reactive_power <- table_dates$Global_reactive_power

#Voltage Graph
plot(days,voltage,type="l",xlab = "Datetime",
     xaxt="none", ylab="Voltage")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))

#Reactive Power Graph
plot(days,reactive_power,type="l",xlab="Datetime", xaxt="none",
     ylab="Global_reactive_power")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))


## Save it to disk
png(file="./data2/plot4.png",
    width=480, height=480)
#this builds the 2x2 graph panels
par(mfrow=c(2,2))
#top left: Global Active Power
hist(hist_data,col="red",main="Global Active Power",
     xlab = "Global Active Power (Kilowatts)",ylim=y_ticks)
#top right: Voltage
plot(days,voltage,type="l",xlab = "Datetime",
     xaxt="none", ylab="Voltage")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))
#lower left:  Submeters
plot(days,s1,type="l",xaxt="none",xlab="",
     yaxt="none",ylab="Energy Sub Metering",
     col="black",ylim=c(0,40),lwd=2)
lines(days,s2, col = "red")
lines(days,s3, col = "blue")
legend("topright", legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),
       col=c("black","red","blue"),lty=1,pt.cex=1,cex=0.4,box.lty=1)
axis(2, at=c(10,20,30),labels=c("10","20","30"))
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))
#lower right:  Reactive Power
plot(days,reactive_power,type="l",xlab="Datetime", xaxt="none",
     ylab="Global_reactive_power")
axis(1, at=c(1,235900,471900), labels=c("Thu","Fri","Sat"))
dev.off()
#####################################################
# End Part V, End Project
#####################################################
