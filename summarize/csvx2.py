import csv
from gensim.summarization import summarize

ifile = open('C:\\Users\\soth02\\Documents\\Expedition\\expedition\\Expedition2017\\data\\NYTimesArticles.csv',"r",encoding='utf8')
reader = csv.reader(ifile)

text = []

headers = next(reader)

for i in range(2):
	text.append((next(reader)[3]))
	#print(text)


print('Summary:')
print(summarize(text[0], ratio=0.1))

print('\n')

print('Summary:')
print(summarize(text[1], ratio=0.1))

print('\n')

print('Summary:')
print(summarize(text[1] + text[0], ratio=0.1))

print(headers[3])

print('\n')

text_file = open("Output.txt", "w")
text_file.write(text[0]+text[1])
text_file.close()
