import os
from os.path import basename
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
import urllib.request
from bs4 import BeautifulSoup

# Setting headers so the request is not denied
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.3'}
# Grab article url from ENV var
article_url = os.environ['ARTICLE_URL']

# GET request to the article url
request = urllib.request.Request(article_url, headers=headers)
page = urllib.request.urlopen(request)
soup = BeautifulSoup(page, 'html.parser')

# Extract main content, title and author
main_content = soup.find('div', {'data-tracking-context': 'postPage'})
title = soup.find('h1').getText()
author = soup.find('meta', {'property': 'author'})['content']

# Writes the parser result
with open('article.html', 'w') as file:
    file.write(str(main_content))

# Call ebook-convert
os.system("./converter.sh '" + title + "' '" + author + "'")

# Send email with article as attachment
gmail_user = os.environ['GMAIL_USER']
send_to = os.environ['KINDLE_EMAIL']
subject = 'Article ' + title
body = ''
file = title + '.pdf'

msg = MIMEMultipart()
msg['From'] = gmail_user
msg['To'] = send_to
msg['Subject'] = subject
msg.attach(MIMEText(body))

try:
    with open(file, "rb") as fil:
        ext = file.split('.')[-1:]
        attachedfile = MIMEApplication(fil.read(), _subtype=ext)
        attachedfile.add_header(
            'content-disposition', 'attachment', filename=basename(file))
    msg.attach(attachedfile)

    smtp = smtplib.SMTP(host="smtp.gmail.com", port=587)
    smtp.starttls()
    smtp.login(gmail_user, os.environ['GMAIL_PASSWORD'])
    smtp.sendmail(gmail_user, send_to, msg.as_string())
    print('Article Sent!')
    smtp.close()
except Exception as e:
    print('ERROR: ' + e)
