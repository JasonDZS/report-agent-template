#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: scripts/validate-task-diff.sh <task-yaml> [base-ref]" >&2
  exit 2
fi

task_file="$1"
base_ref="${2:-main}"

if [ ! -f "$task_file" ]; then
  echo "Task file not found: $task_file" >&2
  exit 2
fi

allowed_tmp="$(mktemp)"
changed_tmp="$(mktemp)"
trap 'rm -f "$allowed_tmp" "$changed_tmp"' EXIT

awk '
  /^allowed_outputs:/ { in_allowed=1; next }
  /^[A-Za-z0-9_-]+:/ && in_allowed { in_allowed=0 }
  in_allowed && /^[[:space:]]*-/ {
    line=$0
    sub(/^[[:space:]]*-[[:space:]]*/, "", line)
    gsub(/^"|"$/, "", line)
    gsub(/^'\''|'\''$/, "", line)
    print line
  }
' "$task_file" | sed '/^$/d' | sort -u > "$allowed_tmp"

git diff --name-only "${base_ref}...HEAD" | sort -u > "$changed_tmp"

if [ ! -s "$changed_tmp" ]; then
  echo "No changed files found relative to ${base_ref}."
  exit 0
fi

violations=0
while IFS= read -r changed; do
  if ! grep -Fxq "$changed" "$allowed_tmp"; then
    echo "Out-of-scope change: $changed" >&2
    violations=1
  fi
done < "$changed_tmp"

if [ "$violations" -ne 0 ]; then
  echo "Diff boundary validation failed." >&2
  exit 1
fi

echo "Diff boundary validation passed."

