#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  echo "Usage: scripts/new-task-worktree.sh <task-id> <role> [base-branch]" >&2
  exit 2
fi

task_id="$1"
role="$2"
base_branch="${3:-main}"

case "$role" in
  reviewer)
    prefix="review"
    ;;
  asset-director)
    prefix="asset"
    ;;
  assembler)
    prefix="assembly"
    ;;
  chief-editor|requirement-analyst|document-architect|section-writer)
    prefix="task"
    ;;
  *)
    echo "Unknown role: $role" >&2
    exit 2
    ;;
esac

branch="${prefix}/${task_id}-${role}"
worktree_dir="../agent-worktrees/${task_id}-${role}"

mkdir -p ../agent-worktrees

if git show-ref --verify --quiet "refs/heads/${branch}"; then
  git worktree add "${worktree_dir}" "${branch}"
else
  git worktree add -b "${branch}" "${worktree_dir}" "${base_branch}"
fi

echo "Created worktree: ${worktree_dir}"
echo "Branch: ${branch}"

