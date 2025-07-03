#!/usr/bin/env bash
# @my prose(fiction) - Show a random prose snippet with attribution

# Pick a random line from the TSV
line=$(shuf -n 1 ~/.prose.tsv)

# Extract author, title, and quote
author=$(echo "$line" | cut -f1)
title=$(echo "$line" | cut -f2)
quote=$(echo "$line" | cut -f3)

# Replace literal '\n' with actual newlines (if needed)
quote=$(echo -e "$quote")

# Output with borders and strict 79-column wrapping (including indentation)
border="======================================================================="
echo "$border"
echo "“$quote”" | fold -s -w64 | sed 's/^/    /'
echo ""
echo -e "    — from *$title* by $author"
echo "$border"
