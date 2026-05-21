# Worktree Policy

Each agent task should run in a separate Git worktree.

Recommended location:

```text
../agent-worktrees/<task-id>-<role>/
```

Recommended branch names:

```text
task/<task-id>-<role>
review/<task-id>-<role>
asset/<task-id>-<role>
integration/<topic>
release/<version>
```

Do not create nested worktrees inside the main repository unless there is a specific reason.
Nested worktrees are harder to ignore, clean, and reason about.

Before merging a task branch:

1. Run a diff boundary check against the base branch.
2. Confirm all changed files are listed in the task `allowed_outputs`.
3. Confirm required outputs exist.
4. Confirm reviewer findings are resolved or explicitly accepted.

