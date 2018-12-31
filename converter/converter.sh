#!bin/bash

. /app/.env

# NO IMAGES
# No spaces where the images should be
# ebook-convert article.html article.mobi --title "$ARTICLE_TITLE" --authors "$ARTICLE_AUTHOR"

# NO IMAGES
# Spaces where the images should be
# ebook-convert article.html article.docx --preserve-cover-aspect-ratio --docx-no-cover --docx-no-toc --title "$ARTICLE_TITLE" --authors "$ARTICLE_AUTHOR"

# NO IMAGES
# The image URL is added instead (as text)
# ebook-convert article.html article.rtf --title "$ARTICLE_TITLE" --authors "$ARTICLE_AUTHOR"

# INCLUDE IMAGES
# Include blank page with small res image before each page that has an image
# Cannot scale the font size
# Title not working
ebook-convert article.html article.pdf --authors "$ARTICLE_AUTHOR"

# INCLUDE IMAGES
# No spaces between words on final mobi
# ebook-convert article.html article.pdf
# ebook-convert article.pdf article.mobi --title "$ARTICLE_TITLE" --authors "$ARTICLE_AUTHOR"
