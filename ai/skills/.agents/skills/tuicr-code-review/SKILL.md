---
name: tuicr-code-review
description: Read comments from an existing tuicr review session and address them in the current codebase.
---

# Address tuicr Review Comments

Use this skill when the user has already reviewed local changes with `tuicr` and wants the review comments addressed.

## Workflow

1. Find the relevant tuicr review session:

   ```bash
   tuicr review list --repo .
   ```

2. Select the active review session associated with the current repository.

   Prefer a session that:
   - is active;
   - contains comments;
   - corresponds to the current local/worktree changes.

   If multiple sessions are plausible and it is not possible to determine the correct one safely, ask the user which session to use.

3. Read the comments:

   ```bash
   tuicr review comments --repo . --session "<slug>"
   ```

4. For every comment:
   - inspect the referenced file and surrounding code;
   - understand the intent of the comment before making changes;
   - implement the requested change when actionable;
   - preserve existing project conventions and architecture;
   - avoid unrelated refactoring.

5. Treat comment types as follows:
   - `issue`: address it;
   - `suggestion`: implement it unless there is a concrete reason not to;
   - `note`: determine whether a code change is requested;
   - `praise`: no code change is required.

6. After applying the changes:
   - inspect the resulting diff;
   - run relevant tests, linters, formatters, or type checks when available;
   - fix failures caused by the changes.

7. Re-read the tuicr comments before finishing:

   ```bash
   tuicr review comments --repo . --session "<slug>"
   ```

   Make sure no actionable comment was accidentally skipped.

## Rules

- Do not launch `tuicr`.
- Do not create a new review session.
- Do not use tmux, Zellij, or other terminal multiplexers.
- Do not modify code unrelated to the review comments unless required for correctness.
- Do not invent a mechanism for marking tuicr comments as resolved.
- Do not silently ignore a comment.
- If a comment cannot or should not be implemented, explain why.
- Prefer small, targeted changes.

## Completion

When finished, briefly report:
- which comments were addressed;
- any comments not implemented and why;
- tests or checks that were run and their results.
