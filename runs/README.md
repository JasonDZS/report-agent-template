# Runs

Each task can have a run directory:

```text
runs/<task-id>/
  AGENT_CONTEXT.md
  questions.yaml
  evidence_requests.yaml
  summary.md
  manifest.yaml
```

Runtime records belong here. Task evidence packs belong under `context/`.
Raw logs may be ignored by Git. Keep summaries and manifests for audit when useful.
