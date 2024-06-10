#!/bin/bash

base_date="2024-06-01"
i=0

# Find all files recursively and sort
find . -type f ! -path "./.git/*" | sort | while read file; do
    git add "$file"

    # Backdated commit for each file
    commit_date=$(date -v+${i}d -j -f "%Y-%m-%d" "$base_date" +"%Y-%m-%dT12:00:00")

    GIT_AUTHOR_DATE="$commit_date" GIT_COMMITTER_DATE="$commit_date" \
    git commit -m "Add file: $file"

    echo "✅ Committed: $file at $commit_date"
    ((i++))
done

