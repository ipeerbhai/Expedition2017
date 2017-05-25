# Input format:  python3 hello.py [[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]

import csv
from gensim.summarization import summarize
import json
import sys
import pandas

args = sys.argv[1:]
# Example args
#args = '[[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]'

articleList = json.loads(str(args[0]))
#print(articleList)

df = pandas.read_csv('data/NYTimesArticles_woAds.csv')

masterArticles = []
masterTitles = []
masterImages = []
masterArticleURLs = []

for articleGroup in articleList:
  concatedArticles = ''
  concatedURLs = ''
  image = ''
  urlCount = 1
  for article in articleGroup:
    concatedArticles = concatedArticles + df['text'][article] + '\n'
    tempURL = df['url'][article].strip()
    concatedURLs += '<li><a href="' + tempURL + '">' + tempURL + '</a>'
    concatedURLs += '<br /><p style=\"font-size:9px\">Keywords: ' + df['keywords'][article] + '</p></li>'
    urlCount = urlCount + 1
    if (df['top_image'][article] != ''):
      image = df['top_image'][article]
  masterArticles.append(concatedArticles)
  masterTitles.append(df['summary'][articleGroup[0]])
  masterImages.append(image)
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
  print(summarize(art, word_count=150).replace('\n', '<br /><br />'))
  print("<br/>")
  print("<br/>")
  print('<ol>')
  print(masterArticleURLs[i])
  print('</ol>')
  print('</article>')

print('</section>')
