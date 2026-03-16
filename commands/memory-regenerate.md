---
name: memory-regenerate
description: Regenerate the full memory reference file after adding or updating memory files.
---

# Memory Regenerate

Regenerate `memory-full-reference.md` by concatenating all memory files. Run this after adding or modifying any memory file to keep the reference current.

## Steps

1. Find the memory directory
2. Read all `.md` files except `MEMORY.md` and `memory-full-reference.md`
3. Concatenate them with headers into a new `memory-full-reference.md`:

```
# Claude Memory — Full Reference
> Auto-generated. All memory files concatenated for on-demand reading.
> Regenerated: (today's date)
> Files: (count) | Size: ~(tokens)K tokens

---
## FILE: filename.md

(contents)

```

4. Report what was generated:

```
Regenerated memory-full-reference.md
  Files: XX
  Lines: XXXX
  Size:  XX KB (~XXK tokens)
  Date:  YYYY-MM-DD
```

This is safe to run repeatedly — it overwrites the reference file with current content.
