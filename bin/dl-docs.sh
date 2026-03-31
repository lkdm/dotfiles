#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-~/Documents/SingleFile}"

mkdir -p "$OUT_DIR"

urls=(
  "https://devhints.io/python"
  "https://devhints.io/bash"
)

for url in "${urls[@]}"; do
  name="$(basename "$url")"
  out_file="$OUT_DIR/${name}.html"

  echo "Downloading $url -> $out_file"
  docker run --rm singlefile "$url" > "$out_file"
done

echo "Done."
