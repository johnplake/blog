#!/bin/bash
# Generate status JSON mappings for all listing sections

cd "$(dirname "$0")"

for section in readings videos books papers listening; do
  if [ -d "$section" ]; then
    # Determine output filename (singular form)
    case "$section" in
      readings) output="reading-status.json" ;;
      videos) output="video-status.json" ;;
      books) output="book-status.json" ;;
      papers) output="paper-status.json" ;;
      listening) output="listening-status.json" ;;
    esac
    
    echo "Generating $output..."
    
    cd "$section"
    for dir in */; do
      if [ -f "$dir/index.qmd" ]; then
        status=$(grep '^status:' "$dir/index.qmd" | awk '{print $2}')
        echo "\"./$section/${dir%/}/index.html\": \"$status\""
      fi
    done | jq -Rs 'split("\n") | map(select(length > 0)) | map(split(": ") | {(.[0] | fromjson): (.[1] | fromjson)}) | add' > "../$output"
    cd ..
    
    echo "  ✓ Created $output"
  fi
done

echo "Done!"
