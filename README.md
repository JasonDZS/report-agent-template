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
  examples/                Non-runtime protocol examples
scripts/                   Local helper scripts
sources/                   Original input documents and extracted excerpts
knowledge/                 Requirements, glossary, style, risk rules
plan/                      Outline, response matrix, section task index
governance/                Directive, decision, and escalation ledgers
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

## Governance Ledgers

The orchestrator compiles sponsor instructions and agent feedback through three project ledgers:

- `governance/directives/`: instructions that should flow down into tasks, context packs, acceptance criteria, and review checks.
- `governance/decisions/`: explicit decisions that resolve high-responsibility questions or conflicts.
- `governance/escalations/`: structured events that should float up for triage, evidence, review, or human judgment.

Reusable schemas and starter templates live under `.agent/schemas/` and `.agent/templates/`.

## Orchestrator Protocol

The orchestrator drives the workspace through file-backed state, not suspended
worker processes. If a worker is blocked by a human decision, it records a
structured question or evidence request under `runs/<task-id>/`, commits allowed
artifacts, and exits. The orchestrator records the resulting escalation or
decision under `governance/` and creates a continuation task when work can resume.

See `.agent/orchestrator.md` for the detailed control loop and state transitions.
