#!/bin/bash

# Session Analysis Script
SESSIONS_DIR="$HOME/.claude/sessions"

echo "=== Session Analysis Report ==="
echo

# 1. Most common git operations
echo "## Common Git Operations:"
grep -h "git " "$SESSIONS_DIR"/*.md 2>/dev/null | \
    sed 's/.*`git /git /' | \
    sed 's/`.*$//' | \
    sort | uniq -c | sort -rn | head -10

echo
echo "## Frequent Commands/Tools:"
grep -hE "(npm|yarn|pnpm|python|cargo|go) (run|install|test|build)" "$SESSIONS_DIR"/*.md 2>/dev/null | \
    sed 's/.*`//' | sed 's/`.*$//' | \
    sort | uniq -c | sort -rn | head -10

echo
echo "## Common Issues/Errors:"
grep -hB1 -A1 -i "error\|issue\|problem\|fix" "$SESSIONS_DIR"/*.md 2>/dev/null | \
    grep -v "^--$" | head -20

echo
echo "## Repeated Tasks (potential command candidates):"
grep -h "^- \[.\]" "$SESSIONS_DIR"/*.md 2>/dev/null | \
    sed 's/^- \[.\] //' | \
    sort | uniq -c | sort -rn | head -10