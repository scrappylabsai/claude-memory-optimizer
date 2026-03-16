# claude-memory-optimizer

Break the 200-line `MEMORY.md` limit in Claude Code.

Claude Code stores agent memory in a file called `MEMORY.md` that's loaded into every conversation. It has a hard limit of 200 lines — everything after line 200 is silently truncated. As your project grows, you hit capacity.

This plugin implements a **three-tier memory architecture** that retains 100% of your knowledge while keeping the index slim.

## The Three Tiers

| Tier | File | When loaded | What it holds |
|------|------|-------------|---------------|
| **1** | `MEMORY.md` | Every conversation (auto) | Slim routing table — core essentials only (~60-100 lines) |
| **2** | `memory-full-reference.md` | On demand (Read tool) | ALL memory files concatenated — complete detail |
| **3** | Individual `.md` files | On demand / RAG search | Original source files — unchanged |

### Why it works

The 200-line limit is on the **index file**, not on the **knowledge**. `MEMORY.md` is loaded automatically, but referenced files are read on demand. With a 200K+ context window, loading all your memory files (~25K tokens for a large project) uses roughly 2-3% of context.

The index doesn't need to *contain* everything — it just needs to *know where everything is*.

## Commands

| Command | What it does |
|---------|-------------|
| `/memory-optimize` | Full optimization: audit → tier → generate reference → restructure MEMORY.md |
| `/memory-status` | Quick health check: capacity, headroom, token usage |
| `/memory-regenerate` | Regenerate the full reference file after adding/editing memories |

## Install

```bash
# Via Claude Code CLI
claude plugin add scrappylabsai/claude-memory-optimizer

# Or manually — clone into your plugins directory
cd ~/.claude/plugins/
git clone https://github.com/scrappylabsai/claude-memory-optimizer.git
```

## Usage

```
# Check your current memory health
/memory-status

# Full optimization (interactive — confirms before changes)
/memory-optimize

# After adding new memories, regenerate the reference
/memory-regenerate
```

## What `/memory-optimize` does

1. **Finds** your memory directory automatically
2. **Audits** current state (lines, capacity, token usage)
3. **Tiers** each file by usage frequency (asks you to confirm)
4. **Generates** `memory-full-reference.md` — all files concatenated
5. **Restructures** `MEMORY.md` as a slim routing table
6. **Reports** before/after metrics

**It never deletes memory files.** It reorganizes the index, not the knowledge.

## Real-world results

From the project where this was developed (11-node GPU fleet, 28 memory files):

| Metric | Before | After |
|--------|--------|-------|
| MEMORY.md lines | 182 / 200 | 83 / 200 |
| Free headroom | 18 lines | 117 lines |
| Capacity | 91% | 42% |
| Info retained | 100% | 100% |

## How it's structured

```
claude-memory-optimizer/
├── plugin.json              # Plugin manifest
├── README.md                # This file
├── commands/
│   ├── memory-optimize.md   # Full optimization flow
│   ├── memory-status.md     # Quick health check
│   └── memory-regenerate.md # Regenerate reference file
└── scripts/
    └── regenerate-reference.sh  # Standalone shell script
```

## Optional: RAG integration

If you have a RAG system (vector search, knowledge graph, etc.), sync your memory files into it. This gives you semantic search over your own knowledge — ask "what did I decide about X?" instead of remembering which file it's in.

The plugin doesn't set up RAG for you (too many possible backends), but it structures your memory files to be RAG-friendly.

## The failed image experiment

We also tried rendering all memory into a JPG for multimodal vision reading. Results: ~60-70% retrieval accuracy. Section headers readable, but specific values (IPs, config strings) too blurry. Dense text via the Read tool gives 100% accuracy. Images are a nice supplement but not a reliable primary store.

Full writeup: [scrappylabs.ai/three-tier-memory](https://scrappylabs.ai/three-tier-memory)

## License

MIT

## Author

[Brian Connelly](https://github.com/scrappylabsai) / [ScrappyLabs](https://scrappylabs.ai)

Built with Claude Code (Opus 4.6).
