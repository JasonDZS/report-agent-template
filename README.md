# Agentic Manuscript Workspace

This repository is a Git-native workspace for long-form document drafting.
The intended workflow is:

1. A human sponsor gives a goal or revision request.
2. Chief Editor turns it into task files.
3. Each agent works in its own Git branch and worktree.
4. Writers produce scoped manuscript changes.
5. Reviewers produce review files or PR comments.
6. Approved changes are merged into `main`.
7. Assembler creates final delivery artifacts from approved source files.

## Repository Layout

```text
AGENTS.md                  Shared rules for all Codex agents
.agent/
  roles/                   Role-specific instructions
  prompts/                 Prompt templates for Codex CLI workers
  schemas/                 JSON Schemas for task/review artifacts
  templates/               Human-editable task and review templates
scripts/                   Local helper scripts
sources/                   Original input documents and extracted excerpts
knowledge/                 Requirements, glossary, style, risk rules
plan/                      Outline, response matrix, section task index
tasks/                     Agent task packages
context/                   Task evidence packs prepared for agents
manuscript/                Diff-friendly manuscript source
assets/                    Image/table briefs, prompts, generated assets
reviews/                   Structured review outputs
runs/                      Agent run summaries and manifests
assembly/                  Generated manuscript builds
release/                   Final approved deliverables
```

## Worktree Convention

Create task worktrees outside this repository:

```text
../agent-worktrees/T-0001-section-writer/
../agent-worktrees/T-0002-reviewer/
```

Use `scripts/new-task-worktree.sh` to create one:

```bash
scripts/new-task-worktree.sh T-0001 section-writer main
```

## Minimal Agent Loop

```text
task.yaml -> isolated worktree -> codex exec -> commit -> validate diff -> review -> merge
```

Every agent must:

- read `AGENTS.md`
- read its role file in `.agent/roles/`
- read the assigned task file
- read the required context pack under `context/`
- use searchable inputs only when required context is insufficient
- modify only the allowed outputs
- commit changes on the task branch
- write any missing-information questions to the task run directory

## Information Environment

Tasks use a three-layer information model:

```text
Layer 1: Required evidence pack  -> context/<task-id>-context-pack.md
Layer 2: Searchable excerpts     -> knowledge/source-index.yaml + sources/excerpts/
Layer 3: Restricted raw sources  -> sources/raw/
```

Writers start from Layer 1. If evidence is insufficient, they may use Layer 2 only when the task allows it. They should not read Layer 3 unless explicitly authorized by the task.
