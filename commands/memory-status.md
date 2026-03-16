---
name: memory-status
description: Quick health check on your Claude Code memory — capacity, file count, token usage, headroom.
---

# Memory Status

Check the health of the user's Claude Code memory system. This is a read-only diagnostic — no changes made.

## Steps

1. Find the memory directory (look for `**/memory/MEMORY.md` or `**/.claude/**/MEMORY.md`)
2. Read MEMORY.md and count lines
3. List all `.md` files in the directory (excluding MEMORY.md)
4. Calculate total bytes and estimated tokens (bytes / 4)
5. Check if `memory-full-reference.md` exists (three-tier system active?)

## Report format

```
Memory Health Check
═══════════════════
MEMORY.md:     XX / 200 lines (XX% capacity)
Headroom:      XX lines free
Memory files:  XX files (XX KB, ~XXK tokens)
Context usage: X.X% of 1M context
Reference:     ✓ memory-full-reference.md exists / ✗ not found
Architecture:  Three-tier active / Standard (single file)

Status: ✓ HEALTHY / ⚠ NEAR CAPACITY (>80%) / ✗ CRITICAL (>95%)
```

If near capacity (>80%), suggest running `/memory-optimize`.
If a reference file exists but MEMORY.md doesn't point to it, flag the disconnect.
