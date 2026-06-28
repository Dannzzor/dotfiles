# new-project

Bootstrap a brand-new project in the current working directory: gather context, write docs, configure Claude Code, initialize git, and save memory.

---

You are setting up a brand-new software project. Follow every step below in order. Do not skip steps.

## Step 1 — Gather project info

The user's project idea may have been passed directly as: $ARGUMENTS

- If `$ARGUMENTS` is non-empty, treat it as the project brief and extract everything you can from it: purpose, stack, audience, integrations, and constraints.
- If `$ARGUMENTS` is empty, ask the user to paste their project idea or brief in a single open-ended question.

After parsing the brief, identify any gaps that are **critical to proceed** (e.g., stack is completely unknown). Ask only about those gaps — one `AskUserQuestion` call, max 3 questions. Do not ask about things that can be reasonably inferred or decided later.

## Step 2 — Configure Claude Code

Create `.claude/settings.json` with the following content (create the `.claude/` directory if needed):

```json
{
  "dangerouslySkipPermissions": true,
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "echo '\\n⚠ Doc check: if this change affects documented behavior, update CLAUDE.md, README, or ROADMAP.md before finishing.'"
          }
        ]
      }
    ]
  }
}
```

## Step 3 — Write CLAUDE.md

Create `CLAUDE.md` in the project root. Start with exactly:

```
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
```

Then include, using the answers from Step 1:

- **Project purpose** — what it does and who it's for
- **Tech stack** — language, framework, database, key libraries, and any stated rationale
- **External integrations** — APIs and services in use
- **Architecture** — key decisions and constraints (even if just intent at this stage)
- **Dev commands** — populate what's known; use placeholder comments for commands that aren't set up yet
- **Doc discipline rule** — a prominent rule stating: all code changes that affect documented behavior must include a corresponding update to CLAUDE.md, README.md, or ROADMAP.md in the same commit.

## Step 4 — Initialize git

Run the following in order:
1. `git init`
2. Create a `.gitignore` appropriate for the detected stack (include OS files like `.DS_Store` and editor files like `.cursor/` and `.vscode/` unless the user specifically wants those tracked)
3. `git add .`
4. `git commit -m "chore: initial project setup"`

## Step 5 — Write planning docs

Create a `docs/` directory with two files.

**`docs/planning.md`** — the active working doc. Use this structure:

```markdown
# [Project Name] — Planning Doc

Reference before starting any non-trivial work. Update when decisions change.

**Completed milestone details → [docs/history.md](history.md)**

---

## Strategic Principles

[Fill in from Step 1: who is the customer, what is the growth motion, what tension
must be actively managed? 2–5 principles max.]

---

## Master Feature Status

Status: `done` · `planned` · `needs-design` · `needs-decision` · `deferred` · `bug`
Tags: `[mobile]` `[paid-tier]` `[post-launch]` `[needs-design]` `[needs-decision]`

### [Feature Area]

| Feature | Status | Tags | Notes |
|---|---|---|---|
| [First milestone features] | planned | | |

---

## Active Backlog

[Spec for each `planned` / `needs-design` / `needs-decision` item. One section per
feature. Done items move to history.md — don't spec completed work here.]

### [First Milestone Name]

[What to build, data model changes, API shape, UI changes, constraints.]

---

## Needs Discussion

[Items blocked on a decision. One paragraph each — state the question, options,
current leaning, and resolution trigger.]

---

## Decided — Do Not Revisit Without Discussion

[Settled architectural and product decisions with brief rationale.]
```

**`docs/history.md`** — archive of completed milestones:

```markdown
# [Project Name] — Shipped History

Completed milestones, condensed. Full specs live in git history.

---

## [Phase / Milestone Name]

[What shipped and why it mattered. 2–5 sentences max. Not a spec — a record.]
```

Populate `docs/planning.md` with the initial milestones from Step 1 as `planned` items in the status table, and write brief specs for each in the Active Backlog section. Leave `docs/history.md` with just the header and a placeholder — it will fill in as milestones ship.

The full structure reference is at `~/.claude/templates/planning-docs.md`.

## Step 6 — Save memory

Write a project memory file at the correct path for this project's memory directory. The memory entry should capture:
- Project name and purpose
- Stack
- Audience
- Key constraints
- The fact that `dangerouslySkipPermissions` is enabled and doc-update enforcement is configured

Also add a pointer to it in `MEMORY.md`.

## Finish

Summarize what was created in 2–3 sentences and remind the user to move completed milestones from `docs/planning.md` to `docs/history.md` as they ship.
