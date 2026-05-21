# Orchestrator Protocol

The orchestrator is the control plane for the manuscript workspace. It does not
write manuscript prose or make high-responsibility semantic decisions. It creates
bounded work, records state transitions, runs workers, validates outputs, and
turns unresolved questions into governance records.

## Core Rule

Human waiting time is represented as repository state, not as a suspended Codex
process.

When a worker is blocked by a decision, conflict, or missing evidence, it must:

1. Write `runs/<task-id>/questions.yaml` or `runs/<task-id>/evidence_requests.yaml`.
2. Write `runs/<task-id>/summary.md`.
3. Update `runs/<task-id>/manifest.yaml` when assigned to do so.
4. Commit allowed artifacts.
5. Exit.

The orchestrator then converts the blocker into `governance/escalations/E-0001.yaml`
when it needs triage or human judgment.

## Control Loop

```text
observe repository state
  -> refresh governance indexes
  -> refresh plan/task-graph.yaml
  -> select ready tasks
  -> prepare run context
  -> run worker in task worktree
  -> collect artifacts
  -> validate schema and diff boundaries
  -> route to review, escalation, continuation, merge, or failure
```

The orchestrator may run independent ready tasks in parallel, but each task must
have its own branch and worktree.

## Downward Compilation

Sponsor instructions and recorded decisions flow down into task execution:

```text
governance/directives/*.yaml
governance/decisions/*.yaml
  -> tasks/<task-id>.yaml
  -> context/<task-id>-context-pack.md
  -> runs/<task-id>/AGENT_CONTEXT.md
  -> reviewer checks and validator rules
```

The task should reference the governance records it depends on:

```yaml
directive_refs:
  - D-0003
decision_refs:
  - DEC-0012
depends_on:
  decisions:
    - DEC-0012
  resolved_escalations:
    - E-0012
```

## Upward Escalation

Workers write local run artifacts first. The orchestrator or Chief Editor converts
important blockers into governance records:

```text
runs/T-0032/questions.yaml
  -> governance/escalations/E-0012.yaml
  -> governance/decisions/DEC-0012.yaml
  -> tasks/T-0033-continue-section.yaml
```

Worker questions are raw task output. Escalations are curated decision briefs.
Decisions are durable project state.

## Continuation Tasks

The default continuation strategy is a new Codex session with file-backed context.
Use session resume only as an optimization, not as the source of truth.

A continuation task should include:

```yaml
id: T-0033
type: section_revision
role: section-writer
continues_from: T-0032
depends_on:
  decisions:
    - DEC-0012
  resolved_escalations:
    - E-0012
decision_refs:
  - DEC-0012
escalation_refs:
  - E-0012
continuation_policy:
  session_strategy: new_session
  preserve_worktree: true
  reuse_branch: false
objective: "Continue section 3.2 after the sponsor decision on availability wording."
```

The new task context pack should summarize:

- the original task and run summary
- the blocker that stopped the prior run
- the recorded decision
- the current draft state
- the exact allowed outputs

## State Responsibilities

- `tasks/*.yaml`: task contract and current task status.
- `plan/task-graph.yaml`: generated dependency and readiness index.
- `runs/<task-id>/manifest.yaml`: one worker run lifecycle.
- `runs/<task-id>/questions.yaml`: raw worker questions.
- `runs/<task-id>/evidence_requests.yaml`: raw worker evidence gaps.
- `governance/escalations/*.yaml`: curated blockers, risks, conflicts, and review summaries.
- `governance/decisions/*.yaml`: sponsor or authorized editor decisions.
- `governance/directives/*.yaml`: instructions that should affect future tasks.

## State Transitions

Typical successful task:

```text
planned -> assigned -> running -> committed -> machine_validated
  -> review_requested -> approved -> merged
```

Blocked task:

```text
running -> blocked_pending_decision
  -> escalation created
  -> decision recorded
  -> continuation task planned
```

Failed machine validation:

```text
committed -> failed
  -> fix task planned
```

## Git Commit Boundaries

Use separate commits for separate state changes:

```text
T-0032: draft section 3.2 and raise availability question
G-0012: record availability escalation
G-0012: record sponsor availability decision
T-0033: continue section 3.2 after availability decision
```

Governance commits may be made by the orchestrator because they record project
state. Manuscript content changes should remain tied to scoped task commits.
