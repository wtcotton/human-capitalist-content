# CLAUDE.md — The Human Capitalist Content Pipeline

## What this repo is

This is the content production pipeline for **The Human Capitalist**, hosted by Trent Cotton. It takes a raw episode transcript and produces all downstream content assets: an AEO/EEAC-optimized blog post, YouTube metadata, social content for LinkedIn/Instagram/TikTok, and a thumbnail brief.

This pipeline operates under **Project 2: HC Content Factory** rules. Every output must sound like Trent Cotton, the host — not Trent Cotton, the iCIMS employee. If any output references iCIMS as a product, platform, or solution, that is a firewall violation. The word "iCIMS" should only appear if Trent is disclosing his affiliation as context.

---

## Voice Rules (enforce in every output)

> **Load `knowledge/trents-voice.md` before writing or reviewing any host-facing content.** It is the source of truth for how Trent sounds — built from episode transcripts. Use the **written register** for blog posts and polished published copy; use the **spoken register** for social, video hooks, and TikTok. The rules below are the summary; the file is the detail.

- **Voice:** First person, POV-led, conversational
- **Audience:** HR leaders and recruiters who are tired of conventional wisdom
- **Stance:** Friendly antagonist — challenges the industry, doesn't lecture it
- **Cut always:** hedge words ("perhaps," "it might be argued"), clichés, pseudo-influencer tropes ("game-changer," "unpack," "lean into"), second person ("you should") creeping into what should be first-person takes
- **Never:** Sound like an iCIMS press release. Never position a vendor, platform, or tool as the solution. Never center the technology over the human insight.

---

## How to run the pipeline

When given a task like "run the content pipeline for /episodes/[guest-slug]/transcript.txt", do the following:

### Step 1 — Read and analyze the transcript
Read the transcript file. Extract:
- Guest name and title
- Episode core argument (the ONE thing this episode is really about)
- 3-5 most quotable or provocative moments
- Any data points, research, or frameworks mentioned
- What the guest challenges or pushes back on (this is gold for hooks)

Store this analysis as a working context object you'll pass to all sub-agents.

### Step 2 — Run Blog Writer Agent (SEQUENTIAL — must complete first)
Spawn a Task for the Blog Writer agent. This agent writes the AEO/EEAC-optimized blog post.
The blog post is the source of truth for all downstream content. Do not run other agents until it's complete.

Output: `/episodes/[guest-slug]/outputs/blog-post.md`

### Step 3 — Run parallel agents (after blog post is done)
Spawn three Tasks simultaneously:
- **YouTube Meta Agent** — title + description + tags
- **Social Content Agent** — LinkedIn variants, Instagram carousel, TikTok hook+script
- **Thumbnail Brief Agent** — Midjourney/Flux prompt + design direction

Each agent receives: the transcript analysis + the completed blog post.

Output locations:
- `/episodes/[guest-slug]/outputs/youtube-meta.json`
- `/episodes/[guest-slug]/outputs/social/linkedin-variants.md`
- `/episodes/[guest-slug]/outputs/social/instagram-carousel.md`
- `/episodes/[guest-slug]/outputs/social/tiktok-script.md`
- `/episodes/[guest-slug]/outputs/thumbnail-brief.md`

### Step 4 — Quality Gate (SEQUENTIAL — runs last)
Spawn a Task for the Quality Gate agent. It reviews ALL outputs for:
- HC voice compliance
- Firewall violations
- Generic AI tone
- Any iCIMS drift

Output: `/episodes/[guest-slug]/outputs/quality-report.md`

---

## Episode folder convention

```
episodes/
  [guest-firstname-lastname]/
    transcript.txt        ← drop your transcript here
    outputs/
      blog-post.md
      youtube-meta.json
      thumbnail-brief.md
      quality-report.md
      social/
        linkedin-variants.md
        instagram-carousel.md
        tiktok-script.md
```

---

## Knowledge files (load when relevant)

All agents should reference these files from `/knowledge/`:
- `trents-voice.md` — Trent's voice fingerprint with examples (source of truth; spoken + written registers)
- `eeac-guidelines.md` — EEAC optimization rules
- `aeo-guidelines.md` — AEO/GEO optimization rules
- `youtube-playbook.md` — title and description rules distilled from research
- `linkedin-playbook.md` — LinkedIn post rules distilled from research
- `audience-personas.md` — three core HC audience personas

---

## Hard rules

1. Never output content that sounds like it belongs to iCIMS, not The Human Capitalist
2. Never produce generic "here are 5 things HR leaders should know" listicle content
3. The blog post must be finished before social content begins
4. The quality gate runs last and its flags must be surfaced to the user
5. If the transcript is missing or empty, stop and ask the user for it — do not hallucinate content
