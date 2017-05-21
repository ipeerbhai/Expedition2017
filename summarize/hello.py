# Input format:  python3 hello.py [[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]

import csv
from gensim.summarization import summarize
import json
import sys
import pandas


# 
#args = '[[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]'
args = sys.argv[1:]
articleList = json.loads(str(args[0]))
#print(articleList)

#ifile = open('C:\\Users\\soth02\\Documents\\Expedition\\expedition\\Expedition2017\\data\\NYTimesArticles_woAds.csv',"r",encoding='utf8')

df = pandas.read_csv('/Users/danielrb/Expedition2017/data/NYTimesArticles_woAds.csv')


masterArticles = []
masterTitles = []
masterImages = []
masterArticleURLs = []

for articleGroup in articleList:
  concatedArticles = ''
  concatedURLs = ''
  for article in articleGroup:
    concatedArticles = concatedArticles + df['text'][article-1]
    tempURL = df['url'][article-1]
    concatedURLs = concatedURLs + '<a href="' + tempURL + '">' + tempURL + '</a>' + '<br />'
  masterArticles.append(concatedArticles)
  masterTitles.append(df['summary'][articleGroup[0]-1])
  masterImages.append(df['top_image'][articleGroup[0]-1])
  masterArticleURLs.append(concatedURLs)

print('<section class="articleList">')

#for art in masterArticles:
for i in range(0, len(masterArticles)):
  art = masterArticles[i]
  headline = masterTitles[i][0:100]
  print('<article class="article">')
  print("<br/>")
  print("<p style=\"font-size:20px\"><strong>")
  print(headline)
  print("</strong></p>")
  print('<img src="' + str(masterImages[i]) + '" style="width:304px;height:228px;">')
  print("<br/>")
  print('Summary:')
  print("<br/>")
  print(summarize(art, word_count=200).replace('\n', '<br />'))
  print("<br/>")
  print("<br/>")
  print(masterArticleURLs[i])
  print('</article>')

print('</section>')
