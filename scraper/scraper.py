import os
import urllib.request
from urllib.parse import urlparse
from bs4 import BeautifulSoup

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.3'}
article_url = os.environ['URL']

request = urllib.request.Request(article_url, headers=headers)
page = urllib.request.urlopen(request)
soup = BeautifulSoup(page, 'html.parser')

parsed_uri = urlparse(article_url)
website = parsed_uri.netloc
print(website)
if website == 'medium.com':
    main_content = soup.find('div', {'data-source': 'post_page'})
else:
    main_content = soup.find('body')

with open('article.html', 'w') as file:
    file.write(str(main_content))
