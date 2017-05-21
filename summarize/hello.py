import csv
from gensim.summarization import summarize
import json
import sys

print("hello")

# 
#args = '[[162,191,838,1431,1433,1446,1493,1522,17,27],[1496,130],[50,91,95,1444,1464,13,15],[21,129,160,310,314,316,332,5],[189,190,131]]'
args = sys.argv[1:]
articleList = json.loads(str(args[0]))
print(articleList)

ifile = open('C:\\Users\\soth02\\Documents\\Expedition\\expedition\\Expedition2017\\data\\NYTimesArticles.csv',"r",encoding='utf8')
reader = csv.reader(ifile)

text = []

headers = next(reader)

print(headers)
print("<br/>")


for i in range(2):
	text.append((next(reader)[4]))
	#print(text)
	#print('appending text')


print('Summary:')
print("<br/>")
print("<p style=\"font-size:20px\"><strong>")
print("Woooo")
print("</strong></p")
print("<br/>")
print(summarize(text[0], ratio=0.1))

print("<br/>")
print("<br/>")

print('Summary:')
print("<br/>")
print("<br/>")

print(summarize(text[1], ratio=0.1))

print("<br/>")
print("<br/>")

print('Summary:')
print("<br/>")
print("<br/>")
print(summarize(text[1] + text[0], word_count=200))

#print(headers[3])


