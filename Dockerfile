FROM beevelop/nodejs-python:latest

WORKDIR /app

RUN \
  apt-get update && \
  apt-get install -y pandoc && \
  npm install electron-pdf -g

RUN \
  curl http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -o kindlegen_linux_2.6_i386_v2_9.tar.gz && \
  mkdir kindlegen && \
  mv kindlegen_linux_2.6_i386_v2_9.tar.gz kindlegen && \
  cd kindlegen && \
  tar -xzf kindlegen_linux_2.6_i386_v2_9.tar.gz && \
  rm kindlegen_linux_2.6_i386_v2_9.tar.gz

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p $HOME/.config/polyglot
COPY polyglot.yaml /root/.config/polyglot/polyglot.yaml
