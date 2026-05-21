# Codex CLI Review Runner Prompt

Use this prompt shape when launching a reviewer:

```text
You are reviewing a manuscript task branch.

Follow:
- AGENTS.md
- .agent/roles/reviewer.md
- tasks/<task-id>.yaml
- knowledge/risk-rules.yaml
- knowledge/requirements.yaml
- plan/response-matrix.yaml

Review the diff against the base branch.
Do not rewrite manuscript text.
Write findings to reviews/<task-id>-review.yaml.
Write a short review summary to runs/<task-id>/summary.md.
Commit review artifacts with message: "<task-id>: review findings".
```

