# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository serves as a central reference for Claude Code skill-building guidelines, templates, and checklists. It is designed to be referenced by multiple projects that need to create skills for Claude Code.

## Key Architecture

### Documentation Structure

The repository follows a centralized documentation pattern:

```
docs/skills/
├── The-Complete-Guide-to-Building-Skill-for-Claude.pdf  # Official Anthropic guide
├── README.md          # Comprehensive skill creation guide
├── checklist.md       # Step-by-step validation checklist
├── quick-reference.md # Quick lookup for common patterns
└── templates/
    └── skill-template/
        └── SKILL.md   # Base template for new skills
```

### Cross-Project Reference Pattern

This repository is meant to be cloned or referenced from other projects. When users ask to create skills in other projects, they should:

1. Copy templates from `docs/skills/templates/skill-template/` to their project
2. Reference `docs/skills/checklist.md` for validation steps
3. Consult `docs/skills/quick-reference.md` for immediate lookups

## Skill Creation Workflow

### Essential Commands

```bash
# View the checklist before starting
cat docs/skills/checklist.md

# Copy template to a project
cp -r docs/skills/templates/skill-template /path/to/project/skills/new-skill-name/

# Quick reference lookup
cat docs/skills/quick-reference.md

# Open complete guide
open docs/skills/The-Complete-Guide-to-Building-Skill-for-Claude.pdf
```

### Critical Skill Requirements

When creating or validating skills, always enforce these rules:

1. **File naming**: Must be exactly `SKILL.md` (case-sensitive)
2. **Folder naming**: Must use kebab-case (e.g., `notion-project-setup`)
3. **YAML frontmatter**:
   - Required fields: `name` (kebab-case), `description` (with both "what" and "when")
   - `description` must include specific trigger phrases
   - No XML tags (`< >`) anywhere
   - Character limit: 1024 for description
4. **Forbidden**:
   - README.md inside skill folders
   - Skill names containing "claude" or "anthropic"

### Skill Structure Pattern

Every valid skill follows this pattern:

```markdown
---
name: kebab-case-name
description: What it does. Use when [specific trigger phrases].
---

# Skill Name

## 指示
[Step-by-step instructions]

## 使用例
[Concrete examples with user input and expected output]

## トラブルシューティング
[Common errors and solutions]
```

## Working with This Repository

### When Asked to Create New Skills

1. **Never create skills directly in this repository** - this is a reference repository
2. Guide users to copy the template to their target project
3. Reference the checklist for validation
4. Use quick-reference.md for immediate syntax/rules lookup

### When Asked to Improve Documentation

The documentation follows this hierarchy:
- `README.md`: High-level overview and usage guide
- `docs/skills/README.md`: Comprehensive skill creation guide
- `docs/skills/quick-reference.md`: Fast lookups and examples
- `docs/skills/checklist.md`: Validation workflow

Updates should maintain consistency across all four files.

### When Asked About Skill Troubleshooting

Common issues are documented in `docs/skills/quick-reference.md` section "🔧 よくあるエラーと解決". Always reference the specific error patterns:

- "Could not find SKILL.md" → Check exact filename
- "Invalid frontmatter" → Verify YAML delimiters
- "Invalid skill name" → Must be kebab-case
- Under-triggering → Improve description specificity
- Over-triggering → Add negative triggers

## Repository Maintenance

### File Organization

- Documentation is centralized in `docs/skills/`
- Templates are versioned in `docs/skills/templates/`
- The PDF guide is kept as the authoritative reference
- All markdown documentation provides practical, actionable guidance

### Bilingual Content

Documentation is primarily in Japanese, matching the user's preference. When creating or updating documentation, maintain the Japanese language for primary content while keeping code examples, YAML fields, and technical terms in English.

## Integration with Other Projects

When users reference this repository from other projects, they typically:

1. Reference documentation: `cat ~/repository/claude-code-settings/docs/skills/checklist.md`
2. Copy templates: `cp -r ~/repository/claude-code-settings/docs/skills/templates/skill-template project-path/skills/new-skill/`
3. Validate against quick-reference rules

This repository should remain a read-only reference for other projects, with templates copied out rather than modified in place.
