#!/bin/bash
# Regenerate memory-full-reference.md from all memory files
# Usage: ./regenerate-reference.sh [memory-directory]
#
# If no directory is specified, uses the current directory.

set -e

DIR="${1:-.}"
OUTPUT="$DIR/memory-full-reference.md"

if [ ! -f "$DIR/MEMORY.md" ]; then
  echo "Error: No MEMORY.md found in $DIR"
  echo "Usage: $0 [path/to/memory/directory]"
  exit 1
fi

# Count files
count=0
total_bytes=0
for f in "$DIR"/*.md; do
  base=$(basename "$f")
  [ "$base" = "MEMORY.md" ] && continue
  [ "$base" = "memory-full-reference.md" ] && continue
  count=$((count + 1))
  total_bytes=$((total_bytes + $(wc -c < "$f")))
done

if [ "$count" -eq 0 ]; then
  echo "No memory files found (only MEMORY.md exists)"
  exit 0
fi

# Generate
cat > "$OUTPUT" << EOF
# Claude Memory — Full Reference
> Auto-generated. All memory files concatenated for on-demand reading.
> Regenerated: $(date +%Y-%m-%d)
> Files: $count | Size: ~$((total_bytes / 4 / 1000))K tokens

EOF

for f in "$DIR"/*.md; do
  base=$(basename "$f")
  [ "$base" = "MEMORY.md" ] && continue
  [ "$base" = "memory-full-reference.md" ] && continue
  echo "---" >> "$OUTPUT"
  echo "## FILE: $base" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  cat "$f" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
done

lines=$(wc -l < "$OUTPUT")
bytes=$(wc -c < "$OUTPUT")
echo "Regenerated: $OUTPUT"
echo "  Files: $count"
echo "  Lines: $lines"
echo "  Size:  $((bytes / 1024)) KB (~$((bytes / 4 / 1000))K tokens)"
