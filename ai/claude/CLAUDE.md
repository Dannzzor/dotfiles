# Claude Code Configuration

Behavioral rules and conventions for Claude Code interactions.

## Reference

See `../STANDARDS.md` for agent-wide standards. This file extends those rules for Claude specifically.

## Claude-Specific Guidelines

### Execution

- **Tools first**: Use Read/Edit/Write for file operations; Bash for shell-only work
- **Parallel calls**: Make independent tool calls together; sequence dependent ones
- **Efficiency**: Prefer dedicated tools over Bash (`cat`, `sed`, `awk`)
- **Git safety**: Never force-push main; always create new commits unless user explicitly requests amend

### Code Changes

- **No rewrites**: Edit existing files unless explicitly creating new ones
- **Minimal scope**: Only change what the task requires; skip cleanup unless requested
- **Safety checks**: Verify paths exist before deletion; investigate unexpected state before deleting
- **Testing**: Run tests locally before committing; respect CI failures

### Responses

- **Concise**: One sentence summaries; no trailing "here's what I did" recaps
- **Actionable**: State results directly; focus on what changed and what's next
- **Context-aware**: Match response length to task complexity; exploratory questions get 2-3 sentences

### Permission & Safety

- **Destructive ops**: Confirm before force-push, git reset --hard, rm -rf, or removing uncommitted work
- **Shared systems**: Confirm before pushing, creating PRs, sending messages, modifying infrastructure
- **Hard-to-reverse**: Confirm before amending published commits or dropping database tables
- **Risky actions**: Investigate unexpected state before deleting; try root-cause fixes first

### Agents & Delegation

- **Explore**: Use for finding code by pattern when uncertain where to look
- **Plan**: Use for architectural decisions and multi-step implementation planning
- **Specialized agents**: Match agent type to task (code-reviewer, build-validator, etc.)

---

**Last Updated**: 2026-06-08

Synced from: `../STANDARDS.md`
