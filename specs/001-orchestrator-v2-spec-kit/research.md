# Research: Tmux Orchestrator v2 - Spec Kit Integration

## Offline Usage of Spec Kit
- `spec-kit` exists as a git submodule in `spec-kit/`; the orchestrator must rely on these templates when GitHub downloads are blocked.
- `uvx` can execute the CLI against the local path with `uvx --from ./spec-kit specify ...`, but the CLI currently attempts to fetch release assets. Document manual template copy steps as fallback.
- Templates stored under `spec-kit/templates/` provide `spec-template.md`, `plan-template.md`, and `tasks-template.md` plus command prompts. Copying these files into `specs/<feature>/` satisfies initial artifact creation.

## Tooling Verification
- Ensure `send-chatgpt-message.sh` is executable (`chmod +x send-chatgpt-message.sh`).
- Confirm tmux is available (`tmux -V`) before launching orchestrator or agents.
- Confirm `uvx --help` works so users can attempt CLI-based workflows when network access is restored.

## Git Workflow Considerations
- `spec-kit/scripts/bash/create-new-feature.sh` automates branch creation; we avoid running it automatically because it executes `git checkout -b`. Provide manual alternative flow in documentation.
- Store example artifacts under `specs/001-orchestrator-v2-spec-kit/` without requiring branch switches.

## Outstanding Questions
- Should we bundle a helper script that copies templates without invoking Spec Kit CLI?
- Do we enforce naming conventions for future specs beyond the example directory?

