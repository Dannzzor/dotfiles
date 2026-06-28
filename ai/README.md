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
├── sync-claude.sh                  Symlinks Claude config into ~/.claude
├── README.md                       This file
├── claude/
│   ├── CLAUDE.md                   Claude Code global working rules
│   └── commands/                   Custom slash commands
├── cursor/
│   └── .cursorrules                Cursor in-editor AI rules
├── copilot/
│   └── copilot-instructions.md     GitHub Copilot inline rules
└── skills/                         Reusable Claude Code skills
    ├── README.md                   Skills registry & management
    ├── code-structure/
    │   └── SKILL.md                Service layer architecture guidance
    └── project-kickoff/
        └── SKILL.md                New project scaffolding
```

## What Gets Symlinked

Run `./ai/sync-claude.sh` (idempotent; backs up existing real files to `*.bak`) to create these links:

| Home Location | Repository Location |
|---|---|
| `~/.claude/CLAUDE.md` | `ai/claude/CLAUDE.md` |
| `~/.claude/commands` | `ai/claude/commands/` |
| `~/.claude/skills/<name>` | `ai/skills/<name>` (per skill) |

Because these are symlinks, an edit on any machine is just a file change in this repo: `git push`, then `git pull` on the other machine and it's live immediately (no re-sync step).

Deliberately **not** synced: `~/.claude/projects/` (project history + memory — work and personal stay separate), `settings.json`, plugins, and marketplace-installed skills (`find-skills`, `skill-creator`, which reinstall via the marketplace).

The Cursor and Copilot configs above are handled separately by `install_dotfiles.sh` / `bootstrap.sh`.

## Managing Claude Code Skills

Custom skills provide reusable guidance for specific workflows. Skills live in `ai/skills/` and are symlinked into `~/.claude/skills/` by `sync-claude.sh`.

### Active Skills

- **code-structure** — Architecture guidance for service layers and refactoring
- **project-kickoff** — Scaffolding templates for new projects

### Using a Skill

Mention the skill in your prompt:

```
"Help me refactor this using the code-structure skill"
"Use the project-kickoff skill to start a new React app"
```

### Creating a New Skill

1. Create the directory: `mkdir -p ai/skills/{skill-name}`
2. Write `ai/skills/{skill-name}/SKILL.md` with guidance
3. Run `./ai/sync-claude.sh` to symlink it into `~/.claude/skills/`
4. Commit: `git add ai/skills/ && git commit -m "add: {skill-name} skill"`

On machines where the skill already exists, a `git pull` is enough — the symlink picks it up automatically.

See `ai/skills/README.md` for the full skill template and best practices.

---

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
