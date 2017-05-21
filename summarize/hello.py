# Input format:  python3 hello.py [[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]

import csv
from gensim.summarization import summarize
import json
import sys
import pandas

print("hello")

# 
#args = '[[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]'
args = sys.argv[1:]
articleList = json.loads(str(args[0]))
print(articleList)

#ifile = open('C:\\Users\\soth02\\Documents\\Expedition\\expedition\\Expedition2017\\data\\NYTimesArticles.csv',"r",encoding='utf8')

df = pandas.read_csv('/Users/danielrb/Expedition2017/data/NYTimesArticles.csv')


masterArticles = []
masterTitles = []
for articleGroup in articleList:
  concatedArticles = ''
  for article in articleGroup:
    concatedArticles = concatedArticles + df['text'][article-1]
  masterArticles.append(concatedArticles)
  masterTitles.append(df['summary'][articleGroup[0]-1])


print('<section class="articleList">')

#for art in masterArticles:
for i in range(0, len(masterArticles)):
  art = masterArticles[i]
  headline = masterTitles[i]
  print('<article class="article">')
  print("<br/>")
  print("<p style=\"font-size:20px\"><strong>")
  print(headline)
  print("</strong></p")
  print("<br/>")
  print('Summary:')
  print(summarize(art, ratio=0.1))
  print("<br/>")
  print("<br/>")
  print('</article>')

print('</section>')
