FROM python

WORKDIR /app

RUN \
  apt-get update && \
  apt-get install calibre -y

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ebook_converter.sh ./
RUN chmod +x /ebook_converter.sh
# COPY index.html ./

# ENTRYPOINT ["/ebook_converter.sh"]

COPY scraper.py ./

CMD ["python", "scraper.py"]

# FROM ubuntu

# WORKDIR /app

# RUN  \
#   apt-get update && \
#   apt-get install libx11-6 -y && \
#   apt-get install -y libgl1-mesa-dev && \
#   apt-get install wget -y

# RUN \
#   apt-get install -y software-properties-common && \
#   add-apt-repository ppa:jonathonf/python-3.6 && \
#   apt-get update && \
#   apt-get install python3.6

# RUN \
#   wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin



# FROM beevelop/nodejs-python:latest

# WORKDIR /app

# RUN \
#   apt-get update && \
#   apt-get install -y pandoc && \
#   npm install electron-pdf -g

# RUN \
#   curl http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -o kindlegen_linux_2.6_i386_v2_9.tar.gz && \
#   mkdir kindlegen && \
#   mv kindlegen_linux_2.6_i386_v2_9.tar.gz kindlegen && \
#   cd kindlegen && \
#   tar -xzf kindlegen_linux_2.6_i386_v2_9.tar.gz && \
#   rm kindlegen_linux_2.6_i386_v2_9.tar.gz

# COPY requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt

# RUN mkdir -p $HOME/.config/polyglot
# COPY polyglot.yaml /root/.config/polyglot/polyglot.yaml
