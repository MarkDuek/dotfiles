# Shared AI skills

Reusable workflows for Codex and OpenCode, installed at `~/.agents/skills`.

Link from the repository root:

```sh
stow --dir=ai --target="$HOME" skills
```

| Skill | Usage |
| --- | --- |
| `next-task-flow` | Complete and document a project's next task |
| `tuicr-code-review` | Address comments in an existing tuicr review session |
| `process-library-inbox` | Classify and organize library resources |

In Codex, use `/skills` or `$skill-name`; in OpenCode, use `@skill-name`.
Restart the tool if new skills do not appear.

The review skill requires `tuicr`. Library processing requires an accessible
notes repository and Drive library whose paths agree with the live `kb.yaml`.
If migrating from the old Codex package, remove only its old skill symlink to
avoid duplicate discovery.
