# Runs

Each task can have a run directory:

```text
runs/<task-id>/
  AGENT_CONTEXT.md
  stdout.log
  stderr.log
  manifest.yaml
  questions.yaml
  evidence_requests.yaml
  summary.md
```

Runtime records belong here. Task evidence packs belong under `context/`.
Raw logs may be ignored by Git. Keep summaries and manifests for audit when useful.

Workers should not remain suspended while waiting for human decisions. If a run is
blocked, the worker writes structured questions or evidence requests, updates the
summary, commits the allowed artifacts, and exits. The orchestrator records any
user decision under `governance/decisions/` and creates a continuation task when
work can proceed.
