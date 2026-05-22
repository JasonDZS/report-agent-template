# Agent Configuration

This directory contains reusable instructions, schemas, templates, and reference
examples for Codex CLI workers.

It also contains governance schemas for the orchestrator. The project-specific directive,
decision, and escalation records themselves live under `governance/`.

See `.agent/orchestrator.md` for the control-plane protocol that explains how
tasks, run manifests, questions, escalations, decisions, and continuation tasks
fit together.

Layering model:

1. `AGENTS.md`: shared repository rules.
2. `.agent/roles/<role>.md`: role-specific responsibilities and boundaries.
3. `tasks/<task-id>.yaml`: task objective, inputs, outputs, and acceptance criteria.
4. `context/<task-id>-context-pack.md`: task-specific evidence pack prepared by the orchestrator.
5. `runs/<task-id>/AGENT_CONTEXT.md`: concrete launch instructions for one worker run.

Governance records are compiled into this stack as task constraints, acceptance criteria,
context-pack notes, reviewer checks, and human decision prompts.

Examples under `.agent/examples/` are not active project state. They are copied
there so the top-level runtime directories can remain clean in a freshly cloned
workspace.

Agents should not edit files in this directory unless assigned an explicit governance task.
