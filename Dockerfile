FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

WORKDIR /app

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    python3.7.2 \
    python3-pip \
    calibre

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

COPY converter.sh article_to_kindle.py docker-entrypoint.sh .env ./
RUN chmod +x converter.sh
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
