---
name: git-commit
description: Create focused Git commits using Conventional Commits. Use when asked to commit changes or prepare commit messages.
---

# Git Commit

## Workflow

1. Inspect Git status, staged changes, and unstaged changes.
   If there are unrelated changes, list them and ask whether they should also be committed. Wait for the user's answer before staging or committing; include approved changes in separate, focused commits.
2. Group changes into single, self-contained commits. Never mix unrelated changes.
3. Preserve unrelated work and existing staging. If the intended scope is unclear, ask before staging or committing.
4. Stage only the intended changes, review the staged diff, and run relevant checks.
5. Create the commit using the guidelines below. If asked only to prepare a message, do not stage or commit.
6. Report the commit hash, subject, and any remaining changes.

Do not push, amend, or rewrite history unless explicitly requested.

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) using:

`type: Imperative description`

Types:
- `feat`: A new feature.
- `fix`: A bug fix.
- `docs`: Documentation-only changes.
- `style`: Formatting changes that do not affect code meaning.
- `refactor`: Code changes that neither fix bugs nor add features.
- `test`: Add missing tests or correct existing tests.

Never include parentheses or a scope after the type:
- Correct: `feat: Add search`
- Incorrect: `feat(): Add search`
- Incorrect: `feat(search): Add search`

Use imperative mood: "Add", not "Added".
Keep subjects concise and descriptive, ideally under 50 characters.
