# Governance Ledger

This directory stores project-specific governance records created and checked by the orchestrator.

`governance/` is runtime project state, while `.agent/schemas/` and `.agent/templates/` are reusable protocol definitions.

## Directories

- `directives/`: active or historical sponsor and editor instructions, stored as `D-0001.yaml`.
- `decisions/`: explicit decisions that resolve high-responsibility questions, stored as `DEC-0001.yaml`.
- `escalations/`: structured events that need triage, evidence, review, or human judgment, stored as `E-0001.yaml`.
- `indexes/`: generated summaries such as active directives and pending escalations.

## Ownership

- The orchestrator creates IDs, validates schema, updates indexes, and controls state transitions.
- The Chief Editor drafts directives and decision proposals from sponsor input.
- Writers and reviewers do not directly change directives or decisions; they raise questions, findings, or escalation candidates.
- Human sponsor decisions should be recorded as decision records before they are compiled into future tasks.
