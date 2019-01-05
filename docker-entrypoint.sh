#!bin/bash

export $(egrep -v '^#' .env | xargs -d '\n')
export ARTICLE_URL=$1

python3 article_to_kindle.py
