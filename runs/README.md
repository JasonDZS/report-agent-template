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
