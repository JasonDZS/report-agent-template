# Agent Configuration

This directory contains reusable instructions, schemas, and templates for Codex CLI workers.

Layering model:

1. `AGENTS.md`: shared repository rules.
2. `.agent/roles/<role>.md`: role-specific responsibilities and boundaries.
3. `tasks/<task-id>.yaml`: task objective, inputs, outputs, and acceptance criteria.
4. `runs/<task-id>/context_pack.md`: task-specific context prepared by the orchestrator.

Agents should not edit files in this directory unless assigned an explicit governance task.

