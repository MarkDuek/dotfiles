---
name: next-task-flow
description: Complete a project's notes/next-task.md task, verify the result, and record it in the project notes.
---

# Next Task Flow

Use this skill when the user has written a next task in the current project's
`notes/next-task.md` and asks to work through it. If the user asks only for a plan,
provide the plan without changing task files.

## Workflow

1. Identify the project root from the current working directory and the user's
   context. Read applicable `AGENTS.md` files in ancestors and directories being
   worked on. Honor a legacy `AGENT.md` if the project uses one. Ask if the
   intended project is ambiguous.
2. Read `notes/next-task.md` relative to that project root, not the filesystem
   root or the global notes vault. If missing, empty, or only a template, report
   that there is no pending task and stop. Inspect Git status and preserve
   unrelated work.
3. Explain the intended work, implement the requested task, and run relevant
   checks. If blocked or incomplete, leave the next-task file intact and report
   what remains.
4. Document the task in `notes/tasks/` and its outcome and checks in
   `notes/results/`. Follow existing filename conventions and use unique names;
   do not overwrite existing records. Append links and a short summary to
   `notes/01-project-log.md`, preserving existing entries.
5. Only after implementation, verification, and documentation succeed, replace
   the completed next-task content with the template below. Re-read the file
   first; if it changed during the run, preserve the new task instead of clearing
   it. Do not commit or push unless the user asks.

```markdown
# Next Task

Place next task here. This file will be cleared after the task is completed and documented.
```

Report the result, checks, documentation paths, and any remaining work.
