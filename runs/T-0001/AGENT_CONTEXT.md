# Agent Context: T-0001

## Role

Section Writer.

## Required Instructions

- `AGENTS.md`
- `.agent/roles/section-writer.md`
- `tasks/T-0001-example-write-section.yaml`

## Required Evidence

- `context/T-0001-context-pack.md`

## Searchable Inputs

- `knowledge/source-index.yaml`
- `sources/excerpts/`

## Restricted Inputs

- `sources/raw/`

Do not read restricted inputs unless the task is updated to explicitly authorize it.

## Governance Inputs

No directives, decisions, or escalations are attached to this placeholder task.

## Expected Outputs

- `manuscript/sections/00/00-example-section.md`
- `manuscript/sections/00/00-example-section.meta.yaml`
- `runs/T-0001/questions.yaml`
- `runs/T-0001/evidence_requests.yaml`
- `runs/T-0001/summary.md`

## Blocking Questions

Do not wait for human input inside the worker process. If a question, evidence gap,
or decision point blocks the task, write it to `runs/T-0001/questions.yaml` or
`runs/T-0001/evidence_requests.yaml`, summarize the blocker in `runs/T-0001/summary.md`,
commit the allowed run artifacts, and stop.
