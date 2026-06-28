# Global Working Rules

Cross-project defaults that apply in every repo.
A project's own CLAUDE.md adds to or overrides these.

## Writing and formatting

- Never use em dashes (the long dash). Use a plain hyphen "-" instead.
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure; only avoid wrapping multiple sentences onto one physical line.

## Commits and generated files

- Do not add an agent or co-author trailer to commit messages.
  This is enforced via `attribution.commit` in settings.json; do not reintroduce it by hand.
- Never hand-edit CHANGELOG.md, lockfiles (package-lock.json, yarn.lock, etc.), or any file marked auto-generated.
  Regenerate them with their tool instead.

## Technical decisions

- Do not over-weight short-term development cost.
  Prefer quality, simplicity, robustness, scalability, and long-term maintainability.
  Still surface the trade-off when one option is dramatically more expensive than another, and let the user decide.

## Bug fixes

- Start by reproducing the bug end-to-end, as close as possible to how a real user hits it.
  Reproducing first ensures the fix targets the real cause, not a symptom.

## Quality bar (UI and engineering)

- Hold a high standard for both the UI and the codebase.
  For UI: be picky and aim for pixel-level polish.
  For engineering: zero tolerance for lint errors, test failures, and flaky tests.
- When you spot a defect that is out of scope for the current task:
  - Fix it inline when it is small, safe, and directly adjacent to what you are already touching.
  - Otherwise surface it, or open a GitHub issue where the project tracks work there, instead of silently expanding the change.
