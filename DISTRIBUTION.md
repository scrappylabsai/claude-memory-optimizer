# Distribution Drafts

Ready to post. Copy-paste when ready.

---

## 1. Claude Code GitHub Discussions

**Title:** Three-Tier Memory — breaking the 200-line MEMORY.md limit

**Body:**

I hit 182/200 lines on MEMORY.md and almost ran out of room. Instead of deleting memories, I built a three-tier system:

- **Tier 1**: Slim MEMORY.md (~80 lines) — routing table with just the essentials
- **Tier 2**: `memory-full-reference.md` — all memory files concatenated into one file Claude reads on demand
- **Tier 3**: Optional RAG integration for semantic search

Key insight: the 200-line limit is on the index file, not on the knowledge. All my memory files combined are ~25K tokens — 2.5% of the 1M context window. The index just needs to route, not contain.

Results: 182 → 83 lines, 117 lines of headroom, zero information lost.

Built it into a plugin with three commands:
- `/memory-optimize` — full optimization flow
- `/memory-status` — quick health check
- `/memory-regenerate` — rebuild the reference file

Repo: https://github.com/scrappylabsai/claude-memory-optimizer
Writeup: https://scrappylabs.ai/three-tier-memory

We also tried rendering memory into a JPG for multimodal reading. ~60-70% accuracy — text wins. Honest results in the writeup.

---

## 2. Reddit — r/ClaudeAI

**Title:** I broke Claude Code's 200-line memory limit with a three-tier architecture (open source plugin)

**Body:**

Claude Code's MEMORY.md has a hard 200-line limit. I hit 91% capacity managing an 11-node fleet and decided to fix it instead of deleting memories.

The trick: MEMORY.md is an index, not a database. It gets auto-loaded, but it can point to other files that Claude reads on demand. So I split it into three tiers:

1. **MEMORY.md** (~80 lines) — slim routing table, core essentials only
2. **memory-full-reference.md** — everything concatenated, read when needed (~25K tokens = 2.5% of context)
3. **RAG search** (optional) — semantic retrieval for "what did I decide about X?"

Went from 182/200 lines to 83/200. Zero info lost.

Made it a plugin: https://github.com/scrappylabsai/claude-memory-optimizer

Three commands: `/memory-optimize`, `/memory-status`, `/memory-regenerate`

Full writeup with the math and a failed JPG experiment (we tried multimodal vision on a memory infographic — 60-70% accuracy, text wins): https://scrappylabs.ai/three-tier-memory

---

## 3. Reddit — r/LocalLLaMA

**Title:** Built a three-tier memory system for Claude Code — broke the 200-line MEMORY.md limit

**Body:**

For the Claude Code users here — MEMORY.md caps at 200 lines. I was at 182 managing a fleet of GPU nodes and AI services. Instead of deleting old memories, I restructured the system:

- Slim index (always loaded, 83 lines) → dense reference file (all 28 files concatenated, 25K tokens) → optional RAG tier

The 200-line limit only applies to the auto-loaded index. Referenced files can be any size. 25K tokens is 2.5% of the 1M context window. We were treating a routing table like a database.

Also tried the multimodal angle — rendered everything into a dense JPG and had Claude read it with vision. ~60-70% accuracy. Fun experiment, text wins.

Open source plugin: https://github.com/scrappylabsai/claude-memory-optimizer

---

## 4. X / Twitter

**Post:**

I hit Claude Code's 200-line memory limit and refused to delete anything.

So I built a three-tier memory system:
→ Slim routing table (83 lines, always loaded)
→ Dense reference file (25K tokens, read on demand)
→ RAG search (semantic retrieval)

182 lines → 83 lines. Zero info lost.

Also tried rendering memory into a JPG for multimodal reading. 60% accuracy. Text wins.

Open source plugin: github.com/scrappylabsai/claude-memory-optimizer

Writeup: scrappylabs.ai/three-tier-memory

---

## 5. Hacker News — Show HN

**Title:** Show HN: Three-tier memory for Claude Code – breaking the 200-line limit

**Body:**

Claude Code (Anthropic's CLI agent) stores persistent memory in MEMORY.md, which is loaded into every conversation. It has a hard 200-line limit — lines after 200 are silently truncated.

I hit 182/200 managing a multi-node GPU fleet and built a workaround:

Tier 1: MEMORY.md becomes a slim routing table (~80 lines) with only the essentials needed in most sessions.

Tier 2: A single memory-full-reference.md file concatenates all 28 memory files (~100KB, ~25K tokens). Claude reads this on demand via its Read tool. With a 1M token context, this is 2.5% of the window.

Tier 3: Memory files synced to an Obsidian vault with four RAG backends for semantic search.

The insight: the 200-line limit constrains the index, not the knowledge. The index just needs to route.

Results: 182→83 lines, 6.5x more headroom, zero information lost.

We also tried rendering all memory into a dense JPG for multimodal vision reading. ~60-70% retrieval accuracy — headers readable but specific values (IPs, config strings) too blurry. Dense text wins.

Shipped as an open source Claude Code plugin with three commands.

Repo: https://github.com/scrappylabsai/claude-memory-optimizer

Writeup with architecture diagrams: https://scrappylabs.ai/three-tier-memory

---

## 6. dev.to

Use the writeup HTML as-is — convert to markdown, post with tags: `claudecode`, `ai`, `agents`, `developer-tools`, `open-source`

The scrappylabs.ai/three-tier-memory page is basically the article already.
