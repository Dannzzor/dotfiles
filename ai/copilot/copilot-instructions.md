# GitHub Copilot Instructions

Behavioral guidelines for GitHub Copilot inline suggestions and completions.

## Reference

See `../STANDARDS.md` for agent-wide standards. This file extends those rules for Copilot specifically.

## Copilot-Specific Guidelines

### Inline Suggestions

- **Language conventions**: Suggest idiomatic patterns for the current language
- **Context-aware**: Match the style, naming, and patterns of surrounding code
- **Performance**: Lean toward efficiency without premature optimization
- **Type safety**: Use type hints where the language supports them

### Autocomplete & Generation

- **Variable naming**: Use full names (user_id not uid, counter not cnt)
- **Function signatures**: Include parameter names and return types
- **Error handling**: Don't suggest try-catch for every line; focus on boundaries
- **Testing**: When generating test code, include realistic test cases

### Code Quality

- **Clarity over cleverness**: Suggest readable code over compact patterns
- **Dependencies**: Prefer standard library and established packages
- **Comments**: Suggest comments only when WHY is non-obvious
- **Refactoring**: Avoid suggesting large refactors inline; use editor for that

### Performance & Security

- **Security boundaries**: Flag input validation, escaping, injection risks
- **Best practices**: Suggest OWASP compliance and common vulnerability prevention
- **Logging**: Suggest appropriate logging for production visibility
- **Tests**: Generate tests for security-critical and edge-case scenarios

---

**Last Updated**: 2026-06-08

Synced from: `../STANDARDS.md`
