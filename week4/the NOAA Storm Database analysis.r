setwd("/Users/freefrog/Studing/DataScience/gitrepo/ReproducibleResearch/week4")
suppressMessages(library(knitr))
library(knitr)

rm(list = ls())

url <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2'

filename <- "Storm Data.csv.bz2"
localfile <- file.path(getwd(),filename)

if(!file.exists(filename)){
        download.file(url, localfile, method = "curl")
        dateDownloaded <- date()
        message('完成数据下载: ', dateDownloaded)
}

stormData<-read.csv(filename, header = TRUE, sep = ',', quote = "\"",stringsAsFactors = F)
