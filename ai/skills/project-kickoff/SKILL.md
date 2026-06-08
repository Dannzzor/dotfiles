---
name: project-kickoff
description: >
  Scaffold a new project with all standard boilerplate: README, CLAUDE.md, .cursorrules,
  .gitignore, folder structure, and initial config files. Use this skill whenever a user
  says "new project", "start a project", "kick off", "scaffold", "initialize", "bootstrap",
  or asks to set up a fresh codebase. Also trigger when a user opens an empty directory
  and asks what to do first.
---

# Project Kickoff Skill

Scaffolds a new project with team-standard boilerplate in one pass.

---

## Step 1 — Gather Intent

Before writing any files, collect the following. Check conversation history first —
only ask for what's genuinely missing:

| Field          | Question                                  | Default    |
| -------------- | ----------------------------------------- | ---------- |
| `project_name` | What's the project called?                | (required) |
| `stack`        | Tech stack? (node/python/fullstack/other) | node       |
| `description`  | One sentence: what does it do?            | (required) |
| `author`       | Author or team name?                      | (optional) |
| `private`      | Is this a private repo?                   | yes        |

Use `ask_user_input_v0` if the user hasn't provided these.

---

## Step 2 — Generate File Tree

Once you have the answers, scaffold the following. Adapt paths to the chosen stack.

```
{project_name}/
├── .ai/
│   ├── STANDARDS.md           ← copy from global; customize for project
│   ├── claude/
│   │   └── CLAUDE.md          ← project-level Claude config
│   └── cursor/
│       └── .cursorrules       ← project-level Cursor rules
├── .github/
│   └── copilot-instructions.md
├── src/                       ← main source (or app/ for fullstack)
├── tests/                     ← test files
├── docs/
│   └── decisions/             ← ADRs go here
├── .env.example               ← template for env vars
├── .gitignore
├── README.md
└── CLAUDE.md                  ← root CLAUDE.md (points to .ai/claude/CLAUDE.md)
```

Stack-specific additions:

- **node**: `package.json`, `tsconfig.json`, `eslint.config.js`
- **python**: `pyproject.toml`, `requirements.txt`, `.python-version`
- **fullstack**: `apps/web/`, `apps/api/`, root `turbo.json` or equivalent

---

## Step 3 — File Contents

### `README.md`

```markdown
# {project_name}

{description}

## Setup

\`\`\`bash

# clone and install

git clone <repo>
cd {project_name}
cp .env.example .env

# fill in .env values

# node

npm install

# python

pip install -r requirements.txt
\`\`\`

## Usage

_TODO: describe how to run the project_

## Contributing

1. Branch from `main` using `feat/`, `fix/`, or `chore/` prefix
2. Write tests for new behavior
3. Open a PR — one review required before merge
```

### `CLAUDE.md` (root, short)

```markdown
# CLAUDE.md

@.ai/claude/CLAUDE.md
```

### `.ai/claude/CLAUDE.md`

```markdown
# CLAUDE.md — {project_name}

## Project Context

- **Name**: {project_name}
- **Description**: {description}
- **Stack**: {stack}

## Standards

@.ai/STANDARDS.md

## Project-Specific Rules

_Add project-specific agent instructions here._

## File Map

- `src/` — application source
- `tests/` — test suite
- `docs/decisions/` — Architecture Decision Records
```

### `.env.example`

```
# Copy to .env and fill in values. Never commit .env.
# APP_PORT=3000
# DATABASE_URL=
# API_KEY=
```

### `.gitignore` (node baseline; extend for python)

```
node_modules/
dist/
.env
.env.local
*.log
.DS_Store
coverage/
__pycache__/
*.pyc
.venv/
```

---

## Step 4 — Post-Scaffold Checklist

After generating files, print this checklist for the user:

```
✅ Project scaffolded: {project_name}

Next steps:
  [ ] Fill in .env from .env.example
  [ ] Run: git init && git add . && git commit -m "chore: initial scaffold"
  [ ] Add project-specific rules to .ai/claude/CLAUDE.md
  [ ] Create your first ADR in docs/decisions/ if you've made key architecture choices
  [ ] Push to remote and set branch protection on main
```

---

## Notes

- Always prefer copying from the global `.ai/STANDARDS.md` rather than rewriting from scratch
- If a project CLAUDE.md already exists, **extend** it — don't overwrite
- If the user has a monorepo, scaffold under `apps/{project_name}/` and ask about a root-level config
- For stack = `other`, generate only the language-agnostic files and ask what else is needed
