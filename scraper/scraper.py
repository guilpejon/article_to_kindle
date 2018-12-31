import os
import urllib.request
from bs4 import BeautifulSoup

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.3'}
article_url = os.environ['URL']
request = urllib.request.Request(article_url, headers=headers)
page = urllib.request.urlopen(request)

soup = BeautifulSoup(page, 'html.parser')
main_content = soup.find('main')

with open('article.html', 'w') as file:
    file.write(str(main_content))
