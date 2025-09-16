# Quickstart: Running the Spec Kit Workflow with ChatGPT Agents

1. **Start tmux orchestrator session**

   ```bash
   tmux new-session -s orchestrator-v2
   codex
   ```

   Brief the orchestrator with the project description and point it to `specs/001-orchestrator-v2-spec-kit/`.

2. **Launch Project Manager agent**

   ```bash
   tmux new-window -n pm
   codex
   ```

   Use `./send-chatgpt-message.sh orchestrator-v2:1 "You are the Project Manager for the v2 Spec Kit integration. Review the spec artifacts before assigning work."`

3. **Manual template fallback (offline-friendly)**

   ```bash
   mkdir -p specs/new-feature
   cp spec-kit/templates/spec-template.md specs/new-feature/spec.md
   cp spec-kit/templates/plan-template.md specs/new-feature/plan.md
   cp spec-kit/templates/tasks-template.md specs/new-feature/tasks.md
   ```

Edit the copied files to match the new feature context.

### Handling Script Errors & Missing Prerequisites

If Spec Kit commands fail due to missing prerequisites (e.g., uncreated git branch, missing CLI tools), follow these steps:

1. Ensure you're on a feature branch:

   ```bash
   git checkout -b feature/<name>
   ```

2. Confirm required tools are installed:

   ```bash
   tmux -V
   git --version
   uvx --help
   ```

3. If errors persist, notify the Orchestrator and pause the workflow:

   ```bash
   ./send-chatgpt-message.sh orchestrator-v2:0 "Spec Kit script failure: [error details]"
   ```

4. **Encourage Spec Kit command usage**

   - `/specify` → Write or update `spec.md`
   - `/plan` → Produce `plan.md`, `research.md`, supporting docs
   - `/tasks` → Generate task list
     Share the command templates from `spec-kit/templates/commands/*.md` with agents as references.

5. **Run verification checklist**

```bash
./verify_speckit_artifacts.sh specs/001-orchestrator-v2-spec-kit
```

Expected output:

```plain
All artifacts present in specs/001-orchestrator-v2-spec-kit: spec.md plan.md tasks.md
```

- Ensure `CHATGPT.md` and `README.md` instructions align with the Spec Kit-first workflow.
