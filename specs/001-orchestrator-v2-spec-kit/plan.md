---
description: "Implementation plan template for feature development"
scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---

# Implementation Plan: Tmux Orchestrator v2 - Spec Kit Integration

**Branch**: `001-orchestrator-v2-spec-kit` | **Date**: 2025-09-16 | **Spec**: specs/001-orchestrator-v2-spec-kit/spec.md
**Input**: Feature specification from `/specs/001-orchestrator-v2-spec-kit/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file.
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Leverage the vendored Spec Kit toolkit to make the orchestrator default to spec-first development. Deliver a demonstrable v2 workflow that generates spec, plan, and task artifacts from templates, updates agent instructions, and documents verification steps so ChatGPT agents consistently complete the Spec Kit phases before coding.

## Technical Context
**Language/Version**: Python 3.11 (tmux utilities), Bash/zsh for orchestration scripts  
**Primary Dependencies**: tmux, uvx, Git, local `spec-kit` submodule  
**Storage**: File system (spec artifacts under `specs/`)  
**Testing**: Shell + python scripts (`test_conversion.sh`, manual verification flows)  
**Target Platform**: macOS / Unix shell running tmux  
**Project Type**: single  
**Performance Goals**: Spec and plan generation completes in <1 minute locally  
**Constraints**: Must run offline using vendored templates; preserve existing orchestrator behavior  
**Scale/Scope**: Single orchestrator workflow and documentation update

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Uphold automation safety: do not auto-run destructive git commands without confirmation.
- Maintain documentation-first approach: spec artifacts must be committed before code tasks begin.
- Preserve ChatGPT-first tooling: no reintroduction of Claude-specific instructions.

## Project Structure

### Documentation (this feature)
```
specs/001-orchestrator-v2-spec-kit/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
src/                     # Existing orchestration utilities (no restructure required)
├── tmux_utils.py
└── ...

scripts/
├── send-chatgpt-message.sh
├── schedule_with_note.sh
└── spec-kit/            # vendored tooling

specs/
└── 001-orchestrator-v2-spec-kit/
```

**Structure Decision**: Option 1 retained (single project CLI utilities)

## Phase 0: Outline & Research
1. Audit Spec Kit scripts to confirm offline usage; document required environment variables or fallbacks.
2. Determine how orchestrator should call Spec Kit flows (manual instructions vs. automation scripts).
3. Capture findings in `research.md`, including notes on uvx availability, tmux agent interactions, and git workflow expectations.

**Output**: research.md with offline strategy and tool prerequisites.

## Phase 1: Design & Contracts
1. Define expected contents of Spec Kit artifacts (spec, plan, tasks) for the v2 example; record in `data-model.md`.
2. Document orchestrator-to-agent communication protocol updates in `quickstart.md` so new PM/developer agents follow the Spec Kit-first flow.
3. If automation scripts require external inputs, outline command contracts within `contracts/` (e.g., JSON structure produced by helper scripts).
4. Update ChatGPT knowledge base references via the agent context update script to ensure new instructions propagate.

**Output**: Updated plan, data-model, quickstart, and contract documents ready for /tasks.

## Phase 2: Task Planning (for /tasks command)
- Generate granular tasks to implement documentation updates, script enhancements, verification additions, and example artifacts.
- Ensure tasks include validation steps (e.g., run `./test_conversion.sh`, execute Spec Kit example workflow).

## Phase 3+: Implementation Guidance
- Update scripts to reference Spec Kit where necessary (e.g., helper script to copy templates).
- Refresh README/CHATGPT.md with v2 workflow instructions.
- Create automated or manual checklist verifying spec, plan, tasks exist before coding.
- Record learnings in `LEARNINGS.md` post-implementation.

## Risks & Mitigations
- **Risk**: Spec Kit CLI requires network to fetch templates.  
  **Mitigation**: Document fallback to local `spec-kit/templates` with copy instructions.
- **Risk**: ChatGPT agents bypass new workflow due to legacy instructions.  
  **Mitigation**: Update knowledge base and PM briefing scripts; add verification checklist.
- **Risk**: Git branch automation conflicts with existing workflows.  
  **Mitigation**: Provide manual alternative path and highlight safe usage guidelines.

## Ready for /tasks?
- [x] Spec reviewed and linked
- [x] Technical context captured
- [x] Constitution check performed
- [ ] Phase 0 complete (requires research.md)
- [ ] Phase 1 design artifacts drafted
- [ ] Risk mitigations validated

