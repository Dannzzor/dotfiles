# AI Agent Standards

Central source of truth for Claude, Cursor, and Copilot behavioral rules and conventions.

## Code Style & Quality

- **Language**: Default to clear, idiomatic code over clever patterns
- **Comments**: Only add when WHY is non-obvious; skip if naming already explains it
- **Naming**: Use full names over abbreviations (user_id not uid)
- **Error handling**: Validate at system boundaries (user input, external APIs); trust internal code
- **Testing**: Write tests for behavior, not implementation details

## Architecture & Structure

- **DRY**: Three similar lines is better than premature abstraction
- **Scope**: Don't add features beyond what's requested; no "while we're here" additions
- **Dependencies**: Prefer built-ins and established libraries; avoid experimental packages
- **Refactoring**: Fix bugs directly; don't clean up surrounding code unless part of the task

## Git & Commits

- **Commits**: One clear idea per commit; descriptive messages that explain WHY
- **History**: Rewrite local work (rebase) before pushing; never force-push to main
- **Branches**: Feature branches from main; PRs with clear scope

## Tools & Editors

- **Claude Code**: Use as primary AI assistant for complex multi-step tasks
- **Cursor**: Use for in-editor AI completion and rules-based guidance
- **Copilot**: Use for quick inline suggestions and autocomplete

## Documentation

- **READMEs**: Written and updated with features
- **Docstrings**: One-line max; only when necessary
- **Type hints**: Use in languages that support them (Python, TypeScript)

## Performance & Scalability

- **Premature optimization**: Avoid unless there's a measured bottleneck
- **Logging**: Add observability for debugging production issues, not development
- **Tests**: Run before committing; respect CI failures

---

**Last Updated**: 2026-06-08

To update tool-specific configs after editing this file, run:
```bash
~/repos/dotfiles/ai/sync-check.sh
```
