#setwd("~/Expedition2017/curationTool")
options(warn = -1)

packages <- c("dplyr","janeaustenr","tidytext","stringr","plyr","dplyr","magrittr","tm","proxy","ggplot2","RColorBrewer","wordcloud","SnowballC")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos="http://cran.rstudio.com/")  
}

library(dplyr, warn.conflicts = FALSE)
#library(janeaustenr)
#library(tidytext)
#library(stringr)
#library(plyr)
#library(magrittr)
library(tm, warn.conflicts = FALSE)
library(proxy, warn.conflicts = FALSE)
#library(ggplot2)
#library(RColorBrewer)
#library(wordcloud)
#library(SnowballC)
set.seed(1300)

# Get command line args
args = commandArgs(trailingOnly=TRUE)
if(identical(args, character(0))) {
  print("Please supply a number number of clusters and then keywords, separated by spaces.")
  print("e.g. Rscript curationTool/tfidfer.R 5 obama trump")
  return
}
nClusters <- args[1]
keywords <- tolower(args[-1])

#print("nClusters:")
#print(nClusters)
#print('Keywords:')
#keywords
# TF-IDF

#setwd("/Users/danielrb/Expedition2017")
#setwd("~/Expedition/expedition/Expedition2017")

NYTData <- read.csv("data/NYTimesArticles.csv", stringsAsFactors=FALSE)
names(NYTData)[1] <- 'articleNum'
#Sort by publish date
NYTData <- NYTData[order(NYTData$publish_date),]

# Remove duplicate articles based on URL
NYTData <- NYTData[match(unique(NYTData$url), NYTData$url),]

orKeywords <- paste(keywords, collapse='|')
andKeywords <- paste(keywords, collapse='&')

orArticles <- NYTData[grepl(orKeywords, NYTData$keywords),]
andArticles <- NYTData[grepl(andKeywords, NYTData$keywords),]

if(nrow(andArticles) > 10) {
  articles <- andArticles
} else {
  articles <- orArticles
}

if(nrow(articles) > 20) {
  articles <- tail(articles, 20)
}
  
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
#plot(clust_h,
#     main = 'Cluster Dendrogram: Ward Cosine Distance',
#     xlab = '', ylab = '', sub = '')

dist_mat <- as.matrix(tf_idf_dist)

df_clust_cuts <- data_frame(cut_level = 1:length(articles$articleNum),
                            avg_size = 0,
                            avg_dist = 0)

#findFreqTerms(doc_term, 100)
#findAssocs(doc_term, "obama", .60)


dtm.matrix = as.matrix(doc_term)
m  <- as.matrix(doc_term)
distMatrix <- dist(t(m), method="euclidean")
groups <- hclust(distMatrix,method="ward.D")
#plot(groups, cex=0.9, hang=-1)
#rect.hclust(groups, k=4)


for(i in groups) {
#  print(i)
}



corpus <- Corpus(VectorSource(articles$text)) %>%
  #  tm_map(x = ., FUN = PlainTextDocument) #%>%
  tm_map(x = ., FUN = removePunctuation) %>%
  tm_map(x = ., FUN = removeNumbers) %>%
  tm_map(x = ., FUN = removeWords, stopwords(kind = 'en')) %>%
  tm_map(x = ., FUN = stripWhitespace)
doc_term <- DocumentTermMatrix(corpus)
doc_term$dimnames$Docs <- as.character(articles$articleNum)

tf_idf <- weightTfIdf(m = doc_term, normalize = TRUE)
tf_idf_mat <- as.matrix(tf_idf)

tf_idf_dist <- dist(tf_idf_mat, method = 'cosine')

clust_h <- hclust(d = tf_idf_dist, method = 'ward.D2')
plot(clust_h,
     main = 'Cluster Dendrogram: Ward Cosine Distance',
     xlab = '', ylab = '', sub = '')

dist_mat <- as.matrix(tf_idf_dist)
df_clust_cuts <- data_frame(cut_level = 1:length(articles$file_name),
                            avg_size = 0,
                            avg_dist = 0)

for (i in 1:(nrow(df_clust_cuts) - 1)) {
  df_clust_cuts[df_clust_cuts$cut_level == i, 'avg_size'] <- mean(table(cutree(tree = clust_h, k = i)))
  
  df_dist <- data_frame(doc_name = doc_term$dimnames$Docs,
                        clust_cut = cutree(tree = clust_h, k = i)) %>%
    inner_join(x = ., y = ., by = 'clust_cut') %>%
    filter(doc_name.x != doc_name.y)
  df_dist$cos_dist <- NA
  for (t in 1:nrow(df_dist)) {
    df_dist$cos_dist[t] <- dist_mat[df_dist$doc_name.x[t], df_dist$doc_name.y[t]]
  }
  df_dist <- df_dist %>%
    group_by(clust_cut) %>%
    summarise(cos_dist = mean(cos_dist))
  
  df_clust_cuts[df_clust_cuts$cut_level == i, 'avg_dist'] <- mean(df_dist$cos_dist)
}

#ggplot(data = df_clust_cuts, aes(x = cut_level, y = avg_dist)) +
#  geom_line(color = 'steelblue', size = 2) +
#  labs(title = 'Cosine Distance of Hierarchical Clusters by Tree Cut',
#       x = 'Tree Cut Level / Number of Final Clusters',
#       y = 'Intra-Cluster Mean Cosine Distance')

#ggplot(data = df_clust_cuts, aes(x = avg_size, y = avg_dist, color = cut_level)) +
#  geom_point(size = 4) +
#  labs(title = 'Mean Cluster Size & Cosine Distance by Tree Cut',
#       x = 'Mean Number of Documents per Cluster',
#       y = 'Intra-Cluster Mean Cosine Distance')

tf_idf_norm <- tf_idf_mat / apply(tf_idf_mat, MARGIN = 1, FUN = function(x) sum(x^2)^0.5)
km_clust <- kmeans(x = tf_idf_norm, centers = nClusters, iter.max = 25)

returnVal = 
  paste0('[', 
         paste(sapply(1:nClusters, function(i) {
           returnVal = paste0('[', 
                              paste0(names(which(km_clust$cluster == i)), collapse=','),
                              ']')  
           }), collapse=','),
         ']'
  )

cat(returnVal)
q()

# THE FOLLOWING BREAKS ARTICLES INTO PCA REPRESENTATIONS AND DRAWS THE TWO
#pca_comp <- prcomp(tf_idf_norm)
#pca_rep <- data_frame(articleNum = articles$articleNum,
#                      pc1 = pca_comp$x[,1],
#                      pc2 = pca_comp$x[,2],
#                      clust_id = as.factor(km_clust$cluster))
#ggplot(data = pca_rep, mapping = aes(x = pc1, y = pc2, color = clust_id)) +
#  scale_color_brewer(palette = 'Set1') +
#  geom_text(mapping = aes(label = articleNum), size = 2.5, fontface = 'bold') +
#  labs(title = 'K-Means Cluster: 5 clusters on PCA Features',
#       x = 'Principal Component Analysis: Factor 1',
#       y = 'Principal Component Analysis: Factor 2') +
#  theme_grey() +
#  theme(legend.position = 'right',
#        legend.title = element_blank())


## THE FOLLOWING MAKES WORDCLOUDS
#term_doc <- TermDocumentMatrix(corpus)
#term_doc$dimnames$Docs <- articles$articleNum
#td_mat <- as.matrix(term_doc)
#td_mat <- td_mat[!row.names(td_mat) %in% stopwords(kind = 'SMART'),]
#commonality.cloud(term.matrix = td_mat)


