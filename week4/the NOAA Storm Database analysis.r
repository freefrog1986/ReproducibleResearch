setwd("/Users/freefrog/Studing/DataScience/gitrepo/ReproducibleResearch/week4")
suppressMessages(library(knitr))
library(knitr)
library(dplyr)
library(ggplot2)

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
        summarize_all(.funs=sum)


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
TableStormData <- tbl_df(stormData)
SumStormData <- 
        select(TableStormData, EVTYPE, FATALITIES, INJURIES) %>%
        group_by(EVTYPE) %>% 
        summarize_all(.funs=sum)


SumStormData <- 
        select(TableStormData, EVTYPE, FATALITIES, INJURIES) %>%
        group_by(EVTYPE) %>% 
        summarize(sum=sum(FATALITIES, INJURIES)) %>%
        arrange(desc(sum))

Top10Data<-SumStormData[1:10,]

#### plot the data
barplot(Top10Data$sum,density = 20,names.arg=Top10Data$EVTYPE)

## RESULT




