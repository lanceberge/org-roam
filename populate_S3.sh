#!/bin/bash

## TODO make the script runnable in any dir

AWS_S3_BUCKET="s3://braindump-bucket"

git ls-files | while read -r file; do

        if [[ "$file" == *.org ]]; then
                HTML_FILE=${file%.org}.html
                pandoc "$file" -o "$HTML_FILE"
                file="$HTML_FILE"
        fi

        aws s3 cp "$file" "$AWS_S3_BUCKET/$file"
done

find "." -type f -name "*.html" -print0 | xargs -0 rm
