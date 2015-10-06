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
#Plot 1
png("plot1.png",width=480,height=480)
hist(nms[[1]],xlim=c(0,7.5),breaks=12,xlab=names[1],main="Global Active Power",col=2)
dev.off()