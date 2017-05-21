from newspaper import Article
from gensim.summarization import summarize

url = 'http://www.espn.com/nba/story/_/id/19426266/isaiah-thomas-boston-celtics-miss-rest-playoffs'

a = Article(url)
a.download()
a.parse()

#print(a.text)

print(a.title)

print('Input text:')
print(a.text)

print('Summary:')
print(summarize(a.text))
