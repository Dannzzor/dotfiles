# AI Agent Configuration

Centralized configuration for Claude Code, Cursor, and GitHub Copilot. All tool configs reference a single source of truth for behavioral standards.

## Quick Start

**On a new machine**, run the main install script:
```bash
~/repos/dotfiles/install_dotfiles.sh
```

This creates symlinks from your home directory to the configs in this repo.

**To edit standards**, modify `STANDARDS.md`:
```bash
vim ~/repos/dotfiles/ai/STANDARDS.md
```

All tool-specific configs reference this file. After updating, run the sync check to see which configs need refreshing:
```bash
~/repos/dotfiles/ai/sync-check.sh
```

## File Structure

```
ai/
├── STANDARDS.md                    Central rules for all AI agents
├── sync-check.sh                   Checks for stale tool configs
├── README.md                       This file
├── claude/
│   └── CLAUDE.md                   Claude Code behavioral rules
├── cursor/
│   └── .cursorrules                Cursor in-editor AI rules
└── copilot/
    └── copilot-instructions.md     GitHub Copilot inline rules
```

## What Gets Symlinked

When `install_dotfiles.sh` runs, it creates these links:

| Home Location | Repository Location |
|---|---|
| `~/.claude/CLAUDE.md` | `ai/claude/CLAUDE.md` |
| `~/.cursorrules` | `ai/cursor/.cursorrules` |
| `~/.config/github-copilot/instructions.md` | `ai/copilot/copilot-instructions.md` |

## Updating Configurations

### Quick Updates
If you just need to tweak a tool-specific config, edit it directly:
```bash
# Edit Claude Code rules
vim ~/repos/dotfiles/ai/claude/CLAUDE.md

# Edit Cursor rules
vim ~/repos/dotfiles/ai/cursor/.cursorrules

# Edit Copilot rules
vim ~/repos/dotfiles/ai/copilot/copilot-instructions.md
```

Changes take effect immediately in the tools (they read from the symlinks).

### Major Changes
If you're changing fundamental standards (code style, architecture patterns, etc.):
1. Update `STANDARDS.md`
2. Review and update each tool config to stay in sync
3. Run `sync-check.sh` to confirm they're current

## Understanding the Standards

**STANDARDS.md** contains shared principles across all tools:
- Code style and quality expectations
- Git and commit conventions
- Architecture and scope guidelines
- Performance and security practices

**Tool-specific configs** extend these standards with tool-specific guidance:
- **CLAUDE.md**: Multi-file changes, complex logic, tool orchestration
- **.cursorrules**: In-editor AI completion, quick fixes, local improvements
- **copilot-instructions.md**: Inline suggestions, autocomplete, tight feedback loops

Use each tool for what it's best at:
- **Claude Code**: Complex multi-step tasks, refactoring, architecture decisions
- **Cursor**: Quick in-editor completions, linting fixes, local context
- **Copilot**: Fast inline suggestions, autocomplete, one-liners

## Troubleshooting

**Symlinks not created?**
```bash
# Verify they exist
ls -l ~/.claude/CLAUDE.md ~/.cursorrules ~/.config/github-copilot/instructions.md

# Re-run the install
~/repos/dotfiles/install_dotfiles.sh
```

**Tools not picking up changes?**
- Claude Code: Restart the app or use `/config` to reload
- Cursor: Check your settings to ensure `cursorRules` points to `~/.cursorrules`
- Copilot: Verify `~/.config/github-copilot/instructions.md` is present and readable

**Check which configs are stale:**
```bash
~/repos/dotfiles/ai/sync-check.sh
```

## Editing Guidelines

- Keep STANDARDS.md concise—it's a reference, not a novel
- Tool-specific configs should reference STANDARDS.md, not duplicate it
- Use markdown formatting for readability
- Include "Last Updated" date in each file for accountability
- Test changes in the actual tool before committing

---

**Created**: 2026-06-08  
**Last Updated**: 2026-06-08
