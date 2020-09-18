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