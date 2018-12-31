FROM python as scraper
WORKDIR /app
COPY scraper/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY scraper/scraper.py ./
ARG url
ENV URL $url
RUN python scraper.py

FROM ubuntu as converter
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN \
   apt-get update && \
   apt-get install calibre -y
COPY converter/converter.sh ./
RUN chmod +x /app/converter.sh
COPY --from=scraper /app/article.html /app/.env ./
RUN /bin/sh converter.sh

FROM ruby:2.6.0
WORKDIR /app
COPY --from=converter /app/article.pdf ./
RUN apt-get update
COPY sender/Gemfile ./
RUN bundle install
COPY --from=scraper /app/.env ./.scraper_env
COPY sender/sender.rb .env ./
RUN cat .scraper_env >> .env
RUN eval $(echo "$(cat .env) ruby sender.rb" | tr '\n' ' ')
