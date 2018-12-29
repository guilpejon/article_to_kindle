FROM python as scraper
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY scraper.py ./
RUN python scraper.py

FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN \
  apt-get update && \
  apt-get install calibre -y
COPY ebook_converter.sh ./
RUN chmod +x /app/ebook_converter.sh
COPY --from=scraper /app/article.html ./
RUN /bin/sh ebook_converter.sh
