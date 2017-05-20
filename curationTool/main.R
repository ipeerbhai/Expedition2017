setwd("~/Expedition2017/curationTool")

#install.packages("XML") 
library(XML)
library(plyr)

# Grab all NYTimes RSS feeds
xmls <- c(
'http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml',
'http://www.nytimes.com/services/xml/rss/nyt/World.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Africa.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Americas.xml',
'http://www.nytimes.com/services/xml/rss/nyt/AsiaPacific.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Europe.xml',
'http://www.nytimes.com/services/xml/rss/nyt/MiddleEast.xml',
'http://www.nytimes.com/services/xml/rss/nyt/US.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Education.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Politics.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Upshot.xml',
'http://www.nytimes.com/services/xml/rss/nyt/NYRegion.xml',
'http://www.nytimes.com/services/xml/rss/nyt/EnergyEnvironment.xml',
'http://www.nytimes.com/services/xml/rss/nyt/SmallBusiness.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Economy.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Dealbook.xml',
'http://www.nytimes.com/services/xml/rss/nyt/MediaandAdvertising.xml',
'http://www.nytimes.com/services/xml/rss/nyt/YourMoney.xml',
'http://www.nytimes.com/services/xml/rss/nyt/PersonalTech.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Sports.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Baseball.xml',
'http://www.nytimes.com/services/xml/rss/nyt/CollegeBasketball.xml',
'http://www.nytimes.com/services/xml/rss/nyt/CollegeFootball.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Golf.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Hockey.xml',
'http://www.nytimes.com/services/xml/rss/nyt/ProBasketball.xml',
'http://www.nytimes.com/services/xml/rss/nyt/ProFootball.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Soccer.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Tennis.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Science.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Environment.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Space.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Health.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Research.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Nutrition.xml',
'http://www.nytimes.com/services/xml/rss/nyt/HealthCarePolicy.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Views.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Arts.xml',
'http://www.nytimes.com/services/xml/rss/nyt/ArtandDesign.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Books.xml',
'http://www.nytimes.com/services/xml/rss/nyt/SundayBookReview.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Dance.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Movies.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Music.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Television.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Theater.xml',
'http://www.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml',
'http://www.nytimes.com/services/xml/rss/nyt/DiningandWine.xml',
'http://www.nytimes.com/services/xml/rss/nyt/HomeandGarden.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Weddings.xml',
'http://www.nytimes.com/services/xml/rss/nyt/tmagazine.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Travel.xml',
'http://www.nytimes.com/services/xml/rss/nyt/JobMarket.xml',
'http://www.nytimes.com/services/xml/rss/nyt/RealEstate.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Commercial.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Automobiles.xml',
'http://www.nytimes.com/services/xml/rss/nyt/Obituaries.xml',
'http://www.nytimes.com/services/xml/rss/nyt/pop_top.xml',
'http://www.nytimes.com/services/xml/rss/nyt/MostShared.xml',
'http://www.nytimes.com/services/xml/rss/nyt/MostViewed.xml',
'http://www.nytimes.com/services/xml/rss/nyt/sunday-review.xml')

# Gather all docs from nytimes XML.
docs <- lapply(xmls, function(x) xmlTreeParse(x))
#xmlRoot(doc)

if(exists("DATA")) {rm("DATA")}
# Gather all of articles' data
for(doc in docs) {
  src<-xpathApply(xmlRoot(doc), "//item")
  
  for (i in 1:length(src)) {
    if (!exists("DATA")) {
      foo<-xmlSApply(src[[i]], xmlValue)
      DATA<-data.frame(t(foo), stringsAsFactors=FALSE)
    }
    else {
      foo<-xmlSApply(src[[i]], xmlValue)
      tmp<-data.frame(t(foo), stringsAsFactors=FALSE)
      DATA<-rbind.fill(DATA, tmp)
    }
  }
}

for(i in names(DATA)) {
  print(i)
  DATA[[i]][which(sapply(DATA[[i]], function(x) {length(x) == 0}))] <- '#NA'
  DATA[[i]] <- unlist(DATA[[i]])
}

DATA$articleURL <- NA
for(i in 1:nrow(DATA)) {
  pos <- regexpr('\\?', DATA$link)
  DATA$articleURL <- substr(DATA$link, 0, pos-1)
} 

# Save all articles
write.csv(as.data.frame(DATA), '../data/articles.csv')


