#!/bin/bash

AWS_S3_BUCKET="s3://braindump-bucket"

aws s3 rm "$AWS_S3_BUCKET"
git ls-files | while read -r file; do

    if [[ "$file" == *.org ]]; then
        HTML_FILE=${file%.org}.html
        pandoc "$file" -o "$HTML_FILE" --wrap=none
        file="$HTML_FILE"
    fi

    aws s3 cp "$file" "$AWS_S3_BUCKET/$file"
done

find "." -type f -name "*.html" -print0 | xargs -0 rm
