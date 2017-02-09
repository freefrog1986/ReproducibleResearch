# This script is to create two plots, plot1 and plot2. plot1 is 
# what is the relationship between mean covered charges (Average.Covered.Charges) and mean total payments (Average.Total.Payments) in New York
# how does the relationship between mean covered charges (Average.Covered.Charges) and mean total payments (Average.Total.Payments) vary by medical condition (DRG.Definition) and the state in which care was received (Provider.State)?

#### set directory and clean the environment
setwd("/Users/freefrog/Studing/DataScience/gitrepo/ReproducibleResearch/week1")
rm(list = ls())

#### download and unzip files to the working directory
url <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1486425600&Signature=bVUpNT7u~gSn2UZPJ8jtAnVUerUMwbdupjjJQcr0FzX5v5f4ooJHiFbfP1uHEVxixgK0z~kzDzGT~TyiIG7aUrBM2msufeTAWWD0iyi6W6noFZzdhawJkhUEDIaJ6XoVI55b9yZeHz5DSK7rGnhLwAMmcbdps0CXPeHqtVS9fw8_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"
localfile <- file.path(getwd(),"original_data.csv")
if(!file.exists("original_data.csv")){
        download.file(url, localfile, mode="wb")
        dateDownloaded <- date()
        message("完成数据下载: ", dateDownloaded)
}
rm(localfile)
rm(url)

#### readin data
dataset<- read.table(file = 'original_data.csv', sep = ",", header = TRUE)

#### make plot1
plot(dataset$Average.Covered.Charges,dataset$Average.Total.Payments,
     xlab='mean covered charges', 
     ylab = 'mean total payments',
     main = 'Relationship in New York',
     col = rgb(0,.5,.5, .3))
model <- lm(Average.Total.Payments~Average.Covered.Charges, data = dataset)
abline(model, lwd = 1, col = "red")
legend("topright", pch = 1, col = 'red', legend = "trend line")

#### save plot1 to file
dev.copy(png, file = "Plot1.png")
dev.off()

#### make plot2
defi<-unique(dataset$DRG.Definition)
state<-unique(dataset$Provider.State)
par(mfrow=c(length(defi),length(state)),mar=c(1,1,1,1),oma = c(0, 0, 3, 0))
for(x in defi){
  for(y in state){
    tempdata<-subset(x=dataset,
                     subset=(DRG.Definition== x)&(Provider.State== y),
                     select=c(Average.Covered.Charges,Average.Total.Payments)
    )
    plot(tempdata$Average.Covered.Charges,
         tempdata$Average.Total.Payments,
         col = rgb(0,.5,.5, .3))
    model <- lm(Average.Total.Payments~Average.Covered.Charges, data = tempdata)
    abline(model, lwd = 1, col = "red")
  }
}
mtext("Page Title", side = 3, outer = TRUE)




