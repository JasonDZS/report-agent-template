# Shared Agent Rules

This repository is a Git-native manuscript engineering workspace.
All agents must follow these rules unless a higher-priority user instruction overrides them.

## Operating Model

- Treat the manuscript as an auditable engineering artifact, not a chat transcript.
- Do not write a whole document in one step. Work only on the assigned task.
- Use Git branches and commits for every material change.
- Prefer Markdown, YAML, and JSON as source artifacts. Do not treat Word/PDF files as primary source.
- Keep changes small, reviewable, and directly tied to the task ID.

## Boundaries

- Read the assigned task file before making changes.
- Modify only files listed in `allowed_outputs` for the task.
- If a needed file is outside the allowed outputs, write a question or proposed follow-up task instead of editing it.
- Do not delete or revert work from other agents.
- Do not rewrite approved content unless the task explicitly asks for it.
- Do not change `.agent/roles`, `.agent/schemas`, or this `AGENTS.md` unless assigned a governance task.

## Evidence and Claims

- Do not invent technical parameters, project facts, references, standards, or compliance claims.
- If evidence is missing, mark it explicitly and write a question file.
- Use requirement IDs and source IDs where available.
- Avoid over-commitment. Use conditional wording when the underlying evidence is conditional.
- Treat `context/<task-id>-context-pack.md` as the required evidence pack for the task.
- If the evidence pack is insufficient, search only the task's `allowed_inputs.searchable` paths.
- Do not read `allowed_inputs.restricted` paths unless the task explicitly authorizes it.
- If evidence is still insufficient, write `runs/<task-id>/evidence_requests.yaml` or `runs/<task-id>/questions.yaml` instead of guessing.
- Do not wait for human input inside a worker process. Record blocking questions or evidence gaps, summarize the blocker, commit allowed artifacts, and exit.

## Manuscript Source Rules

- Main manuscript text lives under `manuscript/sections/`.
- Tables should be represented as Markdown tables or structured YAML/JSON before export.
- Image generation starts from briefs and prompts under `assets/briefs/` and `assets/prompts/`.
- Generated images live under `assets/generated/` and should be referenced by metadata, not embedded as base64.
- Section metadata must stay near the section source when practical.

## Review Rules

- Reviewers should prioritize correctness, requirement coverage, unsupported claims, inconsistency, and missing evidence.
- Reviewers should not directly edit manuscript text unless assigned a review-fix task.
- Review findings must be structured and actionable.

## Commit Rules

- Commit message format:

```text
<task-id>: <short action summary>
```

Example:

```text
T-0001: draft section 3.2 architecture overview
```

- Include generated review or run summaries when they are useful for audit.
- Do not commit raw logs unless explicitly requested.
