#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: scripts/validate-task-diff.sh <task-yaml> [base-ref]" >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
backend_src="${REPORT_AGENT_BACKEND_SRC:-}"

if [ -z "$backend_src" ] && [ -d "$repo_root/../orchestrator/backend/src" ]; then
  backend_src="$repo_root/../orchestrator/backend/src"
fi

if [ -n "$backend_src" ]; then
  export PYTHONPATH="$backend_src${PYTHONPATH:+:$PYTHONPATH}"
fi

export REPORT_AGENT_WORKSPACE="${REPORT_AGENT_WORKSPACE:-$(pwd)}"

"${PYTHON:-python3}" -m report_agent_backend.validate_task_diff "$@"
