# Tasks: Tmux Orchestrator v2 - Spec Kit Integration

**Input**: Design documents from `/specs/001-orchestrator-v2-spec-kit/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tooling updates, documentation targets, verification requirements
2. Load optional design documents:
   → research.md: Capture offline fallback strategy
   → data-model.md: Identify artifact expectations
   → contracts/: Define any helper script inputs/outputs
3. Generate tasks by category:
   → Setup: ensure scripts + templates accessible offline
   → Tests: verification scripts/checklists
   → Core: documentation + workflow updates
   → Integration: agent instruction refresh
   → Polish: final validation + learnings entry
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Verification tasks precede documentation sign-off
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All functional requirements mapped to tasks
   → Verification checklist present
   → Offline fallback documented
9. Return: SUCCESS (tasks ready for execution)
```

## Phase 3.1: Setup
- [ ] T001 Audit `spec-kit/scripts` to document offline usage steps in `research.md`.
- [ ] T002 [P] Add helper script or README snippet showing how to copy templates without network access.

## Phase 3.2: Tests & Verification First
- [ ] T003 Create verification checklist (shell script or markdown) ensuring `spec.md`, `plan.md`, `tasks.md` exist for active feature.

## Phase 3.3: Core Implementation
- [ ] T004 Update `CHATGPT.md` orchestrator + PM briefings with Spec Kit-first workflow.
- [ ] T005 Update `README.md` Quick Start to describe v2 Spec Kit example.
- [ ] T006 Create example v2 artifacts under `specs/001-orchestrator-v2-spec-kit/` (spec, plan, tasks, supporting docs).
- [ ] T007 [P] Provide tmux command snippets guiding users through `/specify`, `/plan`, `/tasks` phases using ChatGPT agents.

## Phase 3.4: Integration & Agent Updates
- [ ] T008 Refresh any automation scripts (e.g., `send-chatgpt-message.sh` usage notes) to reference Spec Kit workflow.
- [ ] T009 Document fallback steps in `LEARNINGS.md` for running Spec Kit offline.

## Phase 3.5: Polish
- [ ] T010 Validate checklist by running it against the v2 example and capturing results in `research.md` or `quickstart.md`.
- [ ] T011 [P] Log final summary + pointers in `next_check_note.txt` template or similar orchestrator reminder files.

## Dependencies
- `T001` precedes `T002` (needs documented steps before publishing instructions).
- `T003` depends on `T001` (verification requires understanding artifact expectations).
- `T004`-`T007` depend on `T003` (documentation references checklist).
- `T008` and `T009` depend on updated documentation from `T004`-`T007`.
- `T010` requires checklist + docs complete (depends on `T003`, `T004`, `T005`, `T006`).
- `T011` depends on successful validation (`T010`).

## Parallel Example
```
# After completing T003:
Run T004 (CHATGPT.md update) alongside T005 (README update) while another agent handles T007 (tmux guidance), since they touch separate files.
```

## Validation Checklist
*GATE: Checked by main() before returning*

- [ ] All functional requirements mapped to at least one task
- [ ] Verification checklist created before documentation updates
- [ ] Offline fallback instructions documented
- [ ] Agent knowledge base updates completed
- [ ] Example artifacts stored in `specs/001-orchestrator-v2-spec-kit/`

