#!bin/bash

. /app/.env

ebook-convert article.html article.mobi --title "$ARTICLE_TITLE" --authors "$ARTICLE_AUTHOR"
