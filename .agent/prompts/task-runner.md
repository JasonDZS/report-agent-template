# Codex CLI Task Runner Prompt

Use this prompt shape when launching a worker:

```text
You are running inside a Git worktree for a manuscript engineering task.

Follow:
- AGENTS.md
- .agent/roles/<role>.md
- tasks/<task-id>.yaml
- runs/<task-id>/context_pack.md, if present

Complete the assigned task.
Modify only files listed in allowed_outputs.
If information is missing, write questions to runs/<task-id>/questions.yaml.
Write a short summary to runs/<task-id>/summary.md.
Commit your changes with message: "<task-id>: <summary>".
```

