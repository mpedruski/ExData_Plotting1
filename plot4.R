rm(list=ls())
#Use scan as quick way to read large file
fdat <- scan("household_power_consumption.txt",what="character",skip=1)
#Figure out what rows need to be included in the final data
selected_dates <- c(grep("^1/2/2007", fdat),grep("^2/2/2007", fdat))
#Subset appropriately
dtu <- fdat[selected_dates]
#Split data strings into columns/rows
mat <- matrix(NA,nrow=length(dtu),ncol=9)
for(i in 1:length(dtu)){
	mat[i,] <- unlist(strsplit(dtu[i],split=";"))
}
#Convert columns 1 and 2 to composite date/time variable
time <- paste(mat[,1],mat[,2],sep=" ")
time <- strptime(time,format="%d/%m/%Y %H:%M:%S")
#Convert columns 3-9 to numeric form
names <- c("Global Active Power (kilowatts)","Global_reactive_power","Voltage","GI", "Sub_metering_1","Sub_metering_2","Sub_metering_3")
nms <- list()
for(i in 1:length(names)){
	nms[[i]] <- as.numeric(mat[,(i+2)])
}
#Plot 4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(time,nms[[1]],type="l",ylab="Global Active Power",main="",xlab="")
plot(time,nms[[3]],type="l",ylab=names[3],main="",xlab="datetime")
plot(time,nms[[5]],type="l",main="",xlab="",ylab="Energy sub metering")
legend("topright",names[5:7],lty=c(1,1,1),col=c(1,2,4),bty="n")
lines(time,nms[[6]],col=2)
lines(time,nms[[7]],col=4)
plot(time,nms[[2]],type="l",ylab=names[2],main="",xlab="datetime")
dev.off()