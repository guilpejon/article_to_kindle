FROM python as scraper
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY scraper.py ./
RUN python scraper.py

FROM ubuntu as converter
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN \
   apt-get update && \
   apt-get install calibre -y
COPY ebook_converter.sh ./
RUN chmod +x /app/ebook_converter.sh
COPY --from=scraper /app/article.html ./
RUN /bin/sh ebook_converter.sh

FROM ruby:2.6.0
WORKDIR /app
COPY --from=converter /app/article.mobi ./
RUN \
    apt-get update
RUN gem install pony
COPY send_to_kindle.rb .env ./
RUN env `cat .env` ruby send_to_kindle.rb
