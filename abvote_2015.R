
library(RColorBrewer)
library(gridExtra)
source("getTweets.R")

N=2000

dir.create("abpoli",showWarnings = FALSE)

abpoli<-getTweets(keyword = "#abpoli OR #abvote",n=N,exclude.words = c("http","ableg","cdnpoli","abpoli","onpoli"))

png("abpoli/abpoli.png",width=2880,height=800)
wordcloud(abpoli$word,abpoli$freq,scale = c(12,4),max.words = 150,min.freq = 4,fixed.asp = FALSE,rot.per=0,colors = (brewer.pal(9,"Greens")[4:9]))
dev.off()

ndp<-getTweets(keyword = "#abndp",n=N,exclude.words = c("http","ableg","cdnpoli","abvote","ableg","abpoli"))

png("abpoli/abndp.png",width=720,height=1000)
wordcloud(ndp$word,ndp$freq,scale = c(8,2),max.words = 150,use.r.layout = FALSE,fixed.asp = FALSE,rot.per=0,colors = (brewer.pal(9,"Oranges")[4:9]))
dev.off()

abpc<-getTweets(keyword = "#abpc OR #pcaa",n=N,exclude.words = c("http","ableg","cdnpoli","abvote","ableg","abpoli","abpc"))

png("abpoli/abpc.png",width=720,height=1000)
wordcloud(abpc$word,abpc$freq,scale = c(8,2),max.words = 100,use.r.layout = FALSE,fixed.asp = FALSE,rot.per=0,colors = (brewer.pal(9,"Blues")[4:9]))
dev.off()

wrp<-getTweets(keyword = "#wrp",n=N,exclude.words = c("http","ableg","cdnpoli","abvote","ableg","abpoli"))

png("abpoli/abwrp.png",width=720,height=1000)
wordcloud(wrp$word,wrp$freq,scale = c(8,2),max.words = 100,use.r.layout = FALSE,fixed.asp = FALSE,rot.per=0,colors = (brewer.pal(6,"PiYG")))
dev.off()

ablib<-getTweets(keyword = "#ablib",n=N, exclude.words = c("http","ableg","cdnpoli","abvote","ableg","abpoli"))

png("abpoli/ablib.png",width=720,height=1000)
wordcloud(ablib$word,ablib$freq,scale = c(8,2),max.words = 100,use.r.layout = FALSE,fixed.asp = FALSE,rot.per=0,colors = (brewer.pal(9,"Reds")[4:9]))
dev.off()


