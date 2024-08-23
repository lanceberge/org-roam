#!/bin/bash

to_title_case() {
    echo "$1" | perl -pe 's/(_.|^.)/uc($1)/ge'
}

find . -type f | while read -r file; do
    dir=$(dirname "$file")
    base=$(basename "$file")

    title_case_name=$(to_title_case "$base")

    mv "$file" "$dir/$title_case_name"
done
