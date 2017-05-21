setwd("~/Expedition2017/curationTool")

library(dplyr)
library(janeaustenr)
library(tidytext)
library(stringr)
library(plyr)
library(dplyr)
library(magrittr)
library(tm)
library(proxy)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)
library(SnowballC)
set.seed(1300)

# TF-IDF

NYTData <- read.csv("../data/NYTimesArticles.csv", stringsAsFactors=FALSE)
names(NYTData)[1] <- 'articleNum'

dim(NYTData)
NYTData <- NYTData[match(unique(NYTData$url), NYTData$url),]
dim(NYTData)

keyword <- 'obama'
articles <- NYTData[grepl(keyword, NYTData$keywords),]

corpus <- Corpus(VectorSource(articles$text)) %>%
#  tm_map(x = ., FUN = PlainTextDocument) #%>%
  tm_map(x = ., FUN = removePunctuation) %>%
  tm_map(x = ., FUN = removeNumbers) %>%
  tm_map(x = ., FUN = removeWords, stopwords(kind = 'en')) %>%
  tm_map(x = ., FUN = stripWhitespace)
doc_term <- TermDocumentMatrix(corpus)
doc_term$dimnames$Docs <- as.character(articles$articleNum)

tf_idf <- weightTfIdf(m = doc_term, normalize = TRUE)
tf_idf_mat <- as.matrix(tf_idf)

tf_idf_dist <- dist(t(tf_idf_mat), method = 'cosine')


clust_h <- hclust(d = t(tf_idf_dist), method = 'ward.D2')
plot(clust_h,
     main = 'Cluster Dendrogram: Ward Cosine Distance',
     xlab = '', ylab = '', sub = '')

dist_mat <- as.matrix(tf_idf_dist)

df_clust_cuts <- data_frame(cut_level = 1:length(articles$articleNum),
                            avg_size = 0,
                            avg_dist = 0)

findFreqTerms(doc_term, 100)
findAssocs(doc_term, "obama", .60)


dtm.matrix = as.matrix(doc_term)
m  <- as.matrix(doc_term)
distMatrix <- dist(t(m), method="euclidean")
groups <- hclust(distMatrix,method="ward.D")
plot(groups, cex=0.9, hang=-1)
rect.hclust(groups, k=4)
typeof(doc_term)





Group 1:

