# Smart Contract Security — Learning Log & Portfolio

My path to becoming a Web3 security researcher: Solidity fundamentals → security foundations → audit report analysis → live contests. This repo is both my working notebook and a curated record of findings as I go.

**Started:** 2026
**Goal:** First paid finding in a live contest (Sherlock), building toward consistent bounty income.

---

## Structure

```
.
├── 01-solidity-basics/       # CryptoZombies progress, small contracts written from scratch
├── 02-security-foundations/  # Cyfrin Updraft notes, Ethernaut + Damn Vulnerable DeFi solutions
├── 03-audit-reviews/         # My breakdowns of Sherlock/Code4rena reports (see format below)
├── 04-invariants/            # Per-protocol invariant lists — the core habit, see below
├── 05-contest-log/           # Every contest entered: scope, findings submitted, outcome
├── 06-close-calls/           # Findings that were dupes/known issues/invalid — logged anyway
├── 07-real-contracts/        # Weekly cold review of live, deployed (non-curriculum) contracts
├── 08-writeups/              # Public teaching-style writeups of solved challenges (forces real understanding)
├── invariant-testing-template/  # Reusable Foundry invariant-test scaffold, refined per protocol reviewed
└── vuln-notebook.md          # Running master list of vuln classes, one entry per class
```

## Why this structure

- **Invariants first.** Before hunting bugs in any contract, I write down what must always be true (see `04-invariants/`). This is the core discipline — pattern-matching known bug shapes is a floor, not a ceiling.
- **Close calls count.** `06-close-calls/` logs findings that didn't pay out (dupes, known issues, invalid). This is a private calibration record — what I *thought* was a bug and why I was wrong or too slow.
- **Mechanism tags.** Entries in `03-audit-reviews/` and `vuln-notebook.md` are tagged by mechanism (share-price accounting, oracle consumption, access control, reward accounting, etc.), not just by protocol type — so patterns across different protocols stay visible.

## Audit review format (`03-audit-reviews/`)

Each file: `protocol-name-YYYY-MM.md`
```
## Protocol: [name]
## Type: [AMM / lending / LST / bridge / etc.]
## Source: [link]

### My guesses (before reading findings)
...

### Actual findings
| Severity | Mechanism tag | Root cause | Did I catch it? |

### Patterns noticed
...
```

## Contest log format (`05-contest-log/`)

Each file: `contest-name-YYYY-MM.md` — scope, time spent, findings submitted, result, what I'd do differently.

## Code annotation convention

While reviewing, I tag inline:
- `@audit-info` — working notes / reasoning in progress
- `@audit-issue` — candidate finding, not yet confirmed
- `@audit-ok` — reviewed, looks safe, don't re-check

## Tooling

- [Foundry](https://book.getfoundry.sh/) — testing, PoCs
- Solidity Visual Developer (VS Code) — inline annotations, call graphs
- `invariant-testing-template/` — my own reusable Foundry invariant-test scaffold. Refined every time I review a new contract, instead of starting from scratch. Formalizes my mechanism checklist (share-price math, oracle checks, access control) as actual code, not just notes.

## Beyond the curriculum (the 3x layer)

Repetition on curriculum material (CryptoZombies, Ethernaut, DVD) builds fluency but caps out at "very good at material everyone else also studies." These practices are added specifically to go past that:

- **`07-real-contracts/`** — one random verified/deployed contract per week (Etherscan), reviewed cold with no writeup or hints available. Real code is messier than teaching environments — training on it early closes a gap most people don't discover until their first contest.
- **`08-writeups/`** — public, teaching-style writeup after each solved challenge, explaining the bug as if to someone else. Writing to teach exposes fuzzy understanding that passive rebuilding doesn't.
- **Community, not just content** — active in security Discords/Twitter, asking questions and getting corrected in public. Faster signal than blog posts, and builds reputation before a first finding ever lands.
  - Cyfrin Updraft Discord
  - Smart Contract Hacking (SCH) Discord
  - Sherlock Discord
  - Code4rena Discord
- **Peer review** — trading writeups/findings with 1-2 people at a similar stage for critique. Self-review has a ceiling; outside eyes catch blind spots solo review can't.

## Progress checklist

- [ ] CryptoZombies complete
- [ ] Cyfrin Updraft — Beginner
- [ ] Cyfrin Updraft — Intermediate
- [ ] Ethernaut complete
- [ ] Damn Vulnerable DeFi complete
- [ ] 10 audit reports reviewed
- [ ] First live contest entered
- [ ] First valid finding submitted

---

*Notes and opinions here are my own working understanding, not audit advice for third parties.*
