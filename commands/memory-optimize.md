---
name: memory-optimize
description: Analyze and optimize your Claude Code memory. Tiers files by usage, generates a dense reference, and slims MEMORY.md to a routing table. Zero information lost.
---

# Memory Optimizer

You are optimizing the user's Claude Code memory system. Follow these steps exactly.

## Step 1: Find the memory directory

Look for the memory directory. It's typically at one of:
- `.claude/projects/*/memory/` (project-level)
- The directory containing `MEMORY.md`

Use Glob to find `**/memory/MEMORY.md` or `**/.claude/**/MEMORY.md`.

If you can't find it, ask the user where their Claude Code memory directory is.

## Step 2: Audit current state

Read `MEMORY.md` and count the lines. Read all other `.md` files in the same directory. Report:

| Metric | Value |
|--------|-------|
| MEMORY.md lines | (count) / 200 max |
| Headroom | (200 - count) lines free |
| Capacity used | (count/200 * 100)% |
| Memory files | (count) files |
| Total size | (sum bytes) → estimated tokens (bytes / 4) |
| Context usage | (tokens / context_window * 100)% |

## Step 3: Tier analysis

Read every memory file and classify into tiers based on content type and likely usage frequency:

**Tier 1 — CORE (inline in MEMORY.md)**
These are needed in 80%+ of sessions. Look for:
- Infrastructure / connection info (IPs, hosts, SSH)
- User preferences and behavior rules
- Feedback corrections (things the user told you NOT to do)
- Cost guardrails and safety rules
- Critical gotchas that bite every time
- Active project paths

**Tier 2 — FREQUENT (one-line mention in MEMORY.md, detail in reference)**
Needed 30-60% of sessions:
- Specific project architecture details
- Service configurations
- Deployment procedures
- Tool-specific documentation

**Tier 3 — OCCASIONAL (reference file only)**
Needed <20% of sessions:
- Historical project notes
- One-time setup procedures
- Hardware-specific edge cases
- Completed project documentation

Present the tier analysis as a table and ask the user to confirm or adjust before proceeding.

## Step 4: Generate memory-full-reference.md

Concatenate ALL memory files (except MEMORY.md itself and the reference file) into a single `memory-full-reference.md`:

```
# Claude Memory — Full Reference
> All memory files concatenated into one dense reference.
> Read this file when MEMORY.md's slim index isn't enough.
> Generated: (today's date)

---
## FILE: filename.md

(file contents)


---
## FILE: next-filename.md

(file contents)

...
```

Write this file to the same directory as MEMORY.md.

## Step 5: Restructure MEMORY.md

Rewrite MEMORY.md with this structure:

```markdown
# Project Memory — Routing Table

> **Three-tier memory system.** This file is the slim index (always loaded).
> - **Tier 1 (this file)**: Core essentials needed most sessions (~XX lines)
> - **Tier 2 (on-demand)**: [memory-full-reference.md](memory-full-reference.md) — ALL files concatenated (~XXK tokens). **Read this when you need details.**
> - **Tier 3 (semantic search)**: Individual memory files available via Read tool

## (Tier 1 sections — condensed, essential info only)
...

## Memory Files Index (Tier 2 + 3)
(one-line descriptions of all files for discoverability)
```

Guidelines for the slim MEMORY.md:
- Target 60-100 lines (leave plenty of headroom)
- Tier 1 content goes inline with key details preserved
- Tier 2 content gets a one-line summary pointing to the full reference
- Tier 3 content gets listed by filename only
- Use compact formatting: tables, pipes for multiple values per line, no blank lines between list items
- Preserve ALL critical values (IPs, passwords, rules) — just organize them tightly
- Keep feedback rules inline — they prevent repeated mistakes

## Step 6: Report results

Show before/after comparison:

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| MEMORY.md lines | X | Y | Z% reduction |
| Free headroom | X lines | Y lines | Nx more room |
| Capacity used | X% | Y% | — |
| Information retained | 100% | 100% | Zero loss |
| On-demand reference | None | memory-full-reference.md | New |

## Important rules

- **NEVER delete memory files.** This tool reorganizes, it doesn't destroy.
- **NEVER remove information from the system.** Everything must exist in at least one tier.
- **Ask before overwriting MEMORY.md.** Show the proposed new version and get approval.
- **Back up MEMORY.md first.** Copy to `MEMORY.md.backup` before any changes.
- **Preserve frontmatter** in individual memory files — don't touch them.
