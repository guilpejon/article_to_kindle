import os
import urllib.request
from urllib.parse import urlparse
from bs4 import BeautifulSoup

# Setting headers so the request is not denied
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.3'}
# Grab article url from ENV var
article_url = os.environ['URL']

# Get request to the article url
request = urllib.request.Request(article_url, headers=headers)
page = urllib.request.urlopen(request)
soup = BeautifulSoup(page, 'html.parser')

# Scrape based on the website
# Grabs the title and author of the article
# Saves them in an .env file for the next build phases
parsed_uri = urlparse(article_url)
website = parsed_uri.netloc
if website == 'medium.com':
    main_content = soup.find('div', {'data-tracking-context': 'postPage'})
    title = soup.find('h1').getText()
    author = soup.find('meta', {'property': 'author'})['content']
else:
    main_content = soup.find('body')
    title = soup.find('h1').getText()
    author = ''

# Saves the .env file with the scraped values
with open('.env', 'w') as file:
    file.write('ARTICLE_TITLE="' + title + '"\n')
    file.write('ARTICLE_AUTHOR="' + author + '"')

# Write the article as an html file for the next build phase
with open('article.html', 'w') as file:
    file.write(str(main_content))
