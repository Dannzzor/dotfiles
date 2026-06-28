# Claude Code Skills Registry

Centralized management of custom Claude Code skills. Each skill is a reusable agent designed for specific workflows.

## Active Skills

### 1. **code-structure**
**Purpose**: Architecture guidance for service layer patterns  
**Trigger**: When multiple workflows duplicate logic, when deciding component boundaries, or when refactoring repeated operational blocks  
**Files**: 
- `code-structure/SKILL.md`

**Key Concepts**:
- Two-layer separation: Actions (orchestration) + Services (mechanics)
- Composable capability blocks over monoliths
- Domain logic stays in actions, reusable operations in services

**Usage**: Ask Claude Code about service architecture, refactoring repeated logic, or component organization

---

### 2. **project-kickoff**
**Purpose**: Scaffold new projects with team-standard boilerplate  
**Trigger**: When user says "new project", "scaffold", "start a project", "initialize"  
**Files**:
- `project-kickoff/SKILL.md`

**Key Concepts**:
- Full project template with README, CLAUDE.md, .cursorrules
- Stack-aware scaffolding (node/python/fullstack)
- AI agent config integrated from the start
- Consistent folder structure across projects

**Usage**: Ask Claude Code to start a new project, and it will guide you through setup

---

## Skill File Structure

Each skill has a standardized layout:

```
ai/skills/
├── code-structure/
│   └── SKILL.md          # Skill definition and guidance
├── project-kickoff/
│   └── SKILL.md          # Skill definition and guidance
└── README.md             # This file
```

Each `SKILL.md` contains:
- YAML frontmatter: `name`, `description`, `trigger conditions`
- Full guidance on when to use the skill
- Step-by-step procedures
- Examples and anti-patterns

---

## Adding a New Skill

### Step 1: Create the skill file

```bash
mkdir -p ~/repos/dotfiles/ai/skills/{skill-name}
touch ~/repos/dotfiles/ai/skills/{skill-name}/SKILL.md
```

### Step 2: Write the SKILL.md

Use this template:

```markdown
---
name: skill-name
description: One-line description of what this skill does and when to use it
---

# Skill Title

## Overview
Detailed explanation of the skill's purpose and domain.

## When to Use
- Trigger condition 1
- Trigger condition 2

## Core Pattern / Approach
Main guidance and workflows.

## Quick Reference
Key points in table or list form.

## Example
Concrete example showing the skill in action.

## Anti-Patterns
What NOT to do.
```

### Step 3: Sync to Claude Code

Symlink the new skill into `~/.claude/skills/`:

```bash
~/repos/dotfiles/ai/sync-claude.sh
```

---

## Sync to Claude Code

Skills in this directory are symlinked into `~/.claude/skills/` by `sync-claude.sh`, so Claude Code can use them.

**One-time setup** (on a new machine), after pulling the repo:

```bash
~/repos/dotfiles/ai/sync-claude.sh
```

**After adding a new skill**, re-run the same script to create its symlink. **Editing an existing skill** needs nothing extra — it's a symlink into the repo, so a `git pull` makes the change live immediately.

---

## Best Practices

### For Skill Authors

✅ **Do**:
- Keep skills focused on a single domain or workflow
- Use concrete examples
- Document when NOT to use the skill (anti-patterns)
- Include step-by-step procedures
- Use tables for quick reference
- Keep descriptions under 2 sentences

❌ **Don't**:
- Mix multiple unrelated concepts into one skill
- Write skills that are just copies of public documentation
- Include secrets, API keys, or personal information
- Create skills for trivial one-liners

### For Skill Users

✅ **Do**:
- Mention the skill explicitly when you want Claude to use it
- Review the SKILL.md file to understand the approach
- Provide context that matches the skill's trigger conditions
- Give feedback if a skill needs updating

❌ **Don't**:
- Assume a skill exists for everything (ask Claude if unsure)
- Use a skill when the problem doesn't match its scope
- Modify SKILL.md files without understanding the full context

---

## Maintenance

### Updating a Skill

1. Edit the `.md` file in `~/repos/dotfiles/ai/skills/{skill-name}/` (the live `~/.claude/skills/{skill-name}` is a symlink, so the edit is immediate)
2. Commit changes: `git add ai/skills/ && git commit -m "update: {skill-name}"`

### Retiring a Skill

1. Move the directory to `ai/skills/archived/{skill-name}/`
2. Update this README
3. Remove from `~/.claude/skills/`
4. Commit: `git add ai/skills/ && git commit -m "archive: {skill-name}"`

### Sharing Skills

Skills in this directory are **safe to share** as long as they don't contain:
- Secrets or API keys
- Company-specific logic
- Personal information
- Hardcoded usernames or emails

All skills here have been reviewed and are safe for public GitHub.

---

## Skill Inventory

| Skill | Status | Last Updated | Owner |
|-------|--------|--------------|-------|
| code-structure | ✅ Active | 2026-06-08 | Danny |
| project-kickoff | ✅ Active | 2026-06-08 | Danny |

---

## Resources

- [Claude Code Skills Documentation](https://claude.ai/help)
- [Your STANDARDS.md](../STANDARDS.md) - Share these with projects scaffolded by project-kickoff
- [CLAUDE.md](../claude/CLAUDE.md) - Global Claude Code rules

---

**Last Updated**: 2026-06-08
