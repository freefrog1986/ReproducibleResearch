setwd("/Users/freefrog/Studing/DataScience/gitrepo/ReproducibleResearch/week4")
suppressMessages(library(knitr))
suppressMessages(library(dplyr))
library(knitr)
library(dplyr)


rm(list = ls())

#### get data
url <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2'

filename <- "Storm Data.csv.bz2"
localfile <- file.path(getwd(),filename)
if(!file.exists(filename)){
        download.file(url, localfile, method = "curl")
        dateDownloaded <- date()
        message('完成数据下载: ', dateDownloaded)
}
stormData<-read.csv(filename, 
                    header = TRUE, 
                    sep = ',', 
                    quote = "\"", 
                    stringsAsFactors = F)

## Most harmful events 
#### processing data
TableStormData <- tbl_df(stormData)
SumStormData <- 
        select(TableStormData, EVTYPE, FATALITIES, INJURIES) %>%
        group_by(EVTYPE) %>% 
        summarize(sum=sum(FATALITIES, INJURIES)) %>%
        arrange(desc(sum))
Top10Data<-SumStormData[1:10,]

#### plot the data
barplot(Top10Data$sum,density = 20,names.arg=Top10Data$EVTYPE)

## Greatest economic consequences events
#### processing data
setnum<-function(a){
        if((a=='K')|(a=='k')){a<-1000}
        else if((a=='M')|(a=='m')){a<-1000000}
        else if((a=='B')|(a=='b')){a<-1000000000}
        else if((a=='H')|(a=='h')){a<-100}
        else{a<-1}
}

multiply<-function(x,y){
        x*y
}

DmgStormData <- select(TableStormData, 
                       EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)
m<-lapply(DmgStormData$PROPDMGEXP,FUN = setnum)
DmgStormData$PROPDMGEXP<-unlist(m)
m<-lapply(DmgStormData$CROPDMGEXP,FUN = setnum)
DmgStormData$CROPDMGEXP<-unlist(m)

CostStormData <- 
        mutate(DmgStormData, PROPs=multiply(PROPDMG, PROPDMGEXP)) %>%
        mutate(CROPs=multiply(CROPDMG, CROPDMGEXP)) %>%
        select(EVTYPE,PROPs,CROPs) %>%
        group_by(EVTYPE) %>%
        summarize(sum=sum(PROPs,CROPs)) %>%
        arrange(desc(sum))

Top10Cost<-CostStormData[1:10,]

#### plot the data
barplot(Top10Cost$sum,density = 20,names.arg=Top10Cost$EVTYPE)

## RESULT




