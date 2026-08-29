---
name: next-task-flow
description: 
  A skill that helps you complete your next task by providing a series of steps and guidance.
---

# Next Task Flow

Use this skill when the user has already created a task and wants to understand the next steps to complete it.

## Workflow

1. Read the AGENT.md files to understand the context of the task and the relevant files.

    Check the current directory and all its child directories for AGENT.md files.
    If multiple files are found, read them all to understand the context of the task and the relevant files.

2. Read the next task.

    Read the new task description at /notes/next-task.md.
    This file contains the next task that needs to be completed, along with any relevant information or instructions.

3. Document the new task and its result.

    Create a new file at /notes/tasks/ and notes/results/
    Also add them to the project log (/notes/01-project-log.md) to keep track of the progress and completion of tasks.

4. Clear the next-task.md file.

    After documenting the new task and its result, clear the contents of /notes/next-task.md to indicate that the task has been completed and is no longer pending.

    Insert the following template:

'''
    # Next Task
    
    Place next task here. This file will be cleared after the task is completed and documented.
'''
