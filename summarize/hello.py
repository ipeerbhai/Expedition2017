import csv
from gensim.summarization import summarize

print("hello")

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