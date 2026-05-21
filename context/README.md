# Context Packs

`context/` stores task evidence packs prepared by the orchestrator.

Context packs are inputs, not runtime logs. They answer:

```text
What evidence and decisions did this task receive?
```

Runtime records belong under `runs/<task-id>/`.

Tasks use three information layers:

```text
Layer 1: required evidence pack  -> context/<task-id>-context-pack.md
Layer 2: searchable excerpts     -> knowledge/source-index.yaml + sources/excerpts/
Layer 3: restricted raw sources  -> sources/raw/
```

Writers should start from Layer 1. If evidence is insufficient, they may use Layer 2 only when the task allows it. They should not read Layer 3 unless explicitly authorized.

