FROM beevelop/nodejs-python:latest

WORKDIR /app

RUN apt-get update && \
    apt-get install -y pandoc && \
    npm install electron-pdf -g

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p $HOME/.config/polyglot
COPY polyglot.yaml /root/.config/polyglot/polyglot.yaml
