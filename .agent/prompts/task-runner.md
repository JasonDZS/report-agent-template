# Codex CLI Task Runner Prompt

Use this prompt shape when launching a worker:

```text
You are running inside a Git worktree for a manuscript engineering task.

Follow:
- AGENTS.md
- .agent/roles/<role>.md
- tasks/<task-id>.yaml
- context/<task-id>-context-pack.md
- runs/<task-id>/AGENT_CONTEXT.md, if present

Complete the assigned task.
Modify only files listed in allowed_outputs.
Start from required inputs. Use searchable inputs only if the evidence pack is insufficient.
Do not read restricted inputs unless the task explicitly authorizes it.
If information is still missing, write evidence requests to runs/<task-id>/evidence_requests.yaml or questions to runs/<task-id>/questions.yaml.
Write a short summary to runs/<task-id>/summary.md.
Commit your changes with message: "<task-id>: <summary>".
```
