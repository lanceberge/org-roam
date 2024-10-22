# Convert the provided files to HTML and push them to S3.
# If no files are provided, then delete the S3 buckets contents
# and convert all files

#!/bin/bash
AWS_S3_BUCKET="s3://braindump-bucket"

if [ $# -eq 0 ]; then
    FILES=$(git ls-files)
    aws s3 rm "$AWS_S3_BUCKET"
else
    FILES=$(echo "$@" | sed 's/ /\n/g')
fi

echo "$FILES" | while read -r file; do
    [ ! -f "$file" ] && continue

    if [[ "$file" == *.org ]]; then
        echo "converting $file"
        HTML_FILE=${file%.org}.html
        pandoc "$file" -o "$HTML_FILE" --wrap=none
        file="$HTML_FILE"
    fi
    aws s3 cp "$file" "$AWS_S3_BUCKET/$file"
done

find "." -type f -name "*.html" -print0 | xargs -0 rm
