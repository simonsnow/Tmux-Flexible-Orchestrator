# ChatGPT.md - Tmux Orchestrator Project Knowledge Base

## Project Overview
The Tmux Orchestrator is an AI-powered session management system where ChatGPT acts as the orchestrator for multiple ChatGPT agents across tmux sessions, managing codebases and keeping development moving forward 24/7.

## Agent System Architecture

### Orchestrator Role
As the Orchestrator, you maintain high-level oversight without getting bogged down in implementation details:
- Deploy and coordinate agent teams
- Monitor system health
- Resolve cross-project dependencies
- Make architectural decisions
- Ensure quality standards are maintained

### Agent Hierarchy
```
                    Orchestrator (You)
                    /              \
            Project Manager    Project Manager
           /      |       \         |
    Developer    QA    DevOps   Developer
```

### Agent Types
1. **Project Manager**: Quality-focused team coordination
2. **Developer**: Implementation and technical decisions
3. **QA Engineer**: Testing and verification
4. **DevOps**: Infrastructure and deployment
5. **Code Reviewer**: Security and best practices
6. **Researcher**: Technology evaluation
7. **Documentation Writer**: Technical documentation

## 🔐 Git Discipline - MANDATORY FOR ALL AGENTS

### Core Git Safety Rules

**CRITICAL**: Every agent MUST follow these git practices to prevent work loss:

1. **Auto-Commit Every 30 Minutes**
   ```bash
   # Set a timer/reminder to commit regularly
   git add -A
   git commit -m "Progress: [specific description of what was done]"
   ```

2. **Commit Before Task Switches**
   - ALWAYS commit current work before starting a new task
   - Never leave uncommitted changes when switching context
   - Tag working versions before major changes

3. **Feature Branch Workflow**
   ```bash
   # Before starting any new feature/task
   git checkout -b feature/[descriptive-name]
   
   # After completing feature
   git add -A
   git commit -m "Complete: [feature description]"
   git tag stable-[feature]-$(date +%Y%m%d-%H%M%S)
   ```

4. **Meaningful Commit Messages**
   - Bad: "fixes", "updates", "changes"
   - Good: "Add user authentication endpoints with JWT tokens"
   - Good: "Fix null pointer in payment processing module"
   - Good: "Refactor database queries for 40% performance gain"

5. **Never Work >1 Hour Without Committing**
   - If you've been working for an hour, stop and commit
   - Even if the feature isn't complete, commit as "WIP: [description]"
   - This ensures work is never lost due to crashes or errors

### Git Emergency Recovery

If something goes wrong:
```bash
# Check recent commits
git log --oneline -10

# Recover from last commit if needed
git stash  # Save any uncommitted changes
git reset --hard HEAD  # Return to last commit

# Check stashed changes
git stash list
git stash pop  # Restore stashed changes if needed
```

### Project Manager Git Responsibilities

Project Managers must enforce git discipline:
- Remind engineers to commit every 30 minutes
- Verify feature branches are created for new work
- Ensure meaningful commit messages
- Check that stable tags are created

### Why This Matters

- **Work Loss Prevention**: Hours of work can vanish without commits
- **Team Coordination**: Clear history helps team understand progress
- **Emergency Recovery**: Stable checkpoints allow quick rollbacks
- **Quality Control**: Incremental commits make code review easier

## 🎯 Communication Protocols

### Inter-Agent Communication

All agents communicate through tmux using the `send-chatgpt-message.sh` script:

```bash
# Send message to any ChatGPT agent
./send-chatgpt-message.sh session:window "Your message here"

# Examples:
./send-chatgpt-message.sh frontend:0 "What's your progress on the login form?"
./send-chatgpt-message.sh backend:1 "The API endpoint /api/users is returning 404"
./send-chatgpt-message.sh project-manager:0 "Please coordinate with the QA team"
```

### Status Reporting

Agents should provide regular status updates including:
- Current task and progress percentage
- Blockers or dependencies
- Expected completion time
- Request for help or coordination

### Escalation Protocol

1. **Technical Issues**: Escalate to senior developer or DevOps
2. **Requirements Clarification**: Escalate to Project Manager
3. **Cross-Team Dependencies**: Escalate to Orchestrator
4. **System-Wide Issues**: Alert all relevant agents

## 🔧 Tmux Session Management

### Session Naming Convention
- Format: `[project]-[role]`
- Examples: `ecommerce-pm`, `auth-dev`, `deployment-ops`

### Window Organization
- Window 0: Main work area
- Window 1: Monitoring/logs
- Window 2: Testing
- Window 3+: Specialized tasks

### Monitoring Commands

```bash
# Get all tmux sessions
tmux list-sessions

# Attach to specific session
tmux attach-session -t session-name

# Create new session
tmux new-session -d -s session-name

# Send commands to window
tmux send-keys -t session:window "command" Enter
```

## 📊 Orchestrator Monitoring

As the Orchestrator, use the Python monitoring utilities:

```python
from tmux_utils import TmuxOrchestrator

orchestrator = TmuxOrchestrator()

# Get comprehensive status
status = orchestrator.get_all_windows_status()

# Create monitoring snapshot
snapshot = orchestrator.create_monitoring_snapshot()

# Find specific agent windows
windows = orchestrator.find_window_by_name("project-manager")
```

## 🚀 Agent Deployment

### Creating New Agents

1. **Create tmux session**:
   ```bash
   tmux new-session -d -s project-name-role
   ```

2. **Brief the agent** using send-chatgpt-message.sh:
   ```bash
   ./send-chatgpt-message.sh project-name-role:0 "You are a [ROLE] for [PROJECT]. Your responsibilities include [LIST]. Follow git discipline and report status every 30 minutes."
   ```

3. **Set up workspace**:
   ```bash
   ./send-chatgpt-message.sh project-name-role:0 "cd /path/to/project && git status && ls -la"
   ```

## 🧩 Spec Kit Workflow (v2)

The orchestrator now defaults to a Spec-Driven Development flow using the bundled `spec-kit` submodule. Every new initiative must progress through these phases **before any coding begins**:

1. **/specify** – capture the feature specification using `spec-kit/templates/spec-template.md` as the structure. Store output in `specs/<feature>/spec.md`.
2. **/plan** – generate implementation planning artifacts (`plan.md`, `research.md`, `data-model.md`, `quickstart.md`, `contracts/`). Align decisions with the repository constitution and tmux-based workflows.
3. **/tasks** – produce a numbered task list in `specs/<feature>/tasks.md` that maps directly to functional requirements. Tasks must include verification steps and call out parallelizable work.

### What Agents Must Do
- Project Managers enforce the `/specify → /plan → /tasks` order and reject work that skips steps.
- Developers request the latest spec artifacts before implementing anything.
- QA verifies that `spec.md`, `plan.md`, and `tasks.md` exist and match the active feature prior to testing.

### Offline Fallback
- If the `specify` CLI cannot download templates, copy the bundled files:
  ```bash
  mkdir -p specs/new-feature
  cp spec-kit/templates/spec-template.md specs/new-feature/spec.md
  cp spec-kit/templates/plan-template.md specs/new-feature/plan.md
  cp spec-kit/templates/tasks-template.md specs/new-feature/tasks.md
  ```
- Update the copied files manually, keeping section order intact.

### Handling Script Errors & Missing Prerequisites

If Spec Kit commands (`/specify`, `/plan`, `/tasks`) fail due to missing prerequisites (e.g., uncreated git branch, missing CLI tools), do the following:

1. Ensure a feature branch exists:

   ```bash
   git checkout -b feature/<name>
   ```

2. Verify required tools are available:

   ```bash
   tmux -V
   git --version
   uvx --help
   ```

3. If errors persist, notify the Orchestrator and halt further steps:

   ```bash
   ./send-chatgpt-message.sh orchestrator-v2:0 "Spec Kit script failure: [error details]"
   ```

### Example Project
- Reference `specs/001-orchestrator-v2-spec-kit/` for a complete v2 walkthrough that demonstrates the required artifacts, plan structure, and task breakdown.
- When briefing agents, point them to this directory as the canonical example of the expected output.

### Agent Termination

When shutting down agents:
1. Ensure all work is committed
2. Create final status report
3. Transfer any ongoing tasks to other agents
4. Clean up tmux session

## 📈 Performance Metrics

Track agent performance using:
- Commits per hour
- Task completion rate
- Bug introduction rate
- Communication responsiveness
- Code quality scores

## 🎨 Best Practices for ChatGPT Agents

### Communication Style
- Be concise but informative
- Use clear action items
- Timestamp important updates
- Tag urgent messages with "URGENT:"

### Task Management
- Break large tasks into smaller chunks
- Set realistic time estimates
- Ask for help when stuck >30 minutes
- Document decisions and rationale

### Code Quality
- Follow project coding standards
- Write meaningful commit messages
- Test changes before committing
- Review code for security issues

### Coordination
- Announce when starting new features
- Share progress updates proactively
- Identify and communicate dependencies
- Resolve conflicts quickly

## 🔍 Troubleshooting

### Common Issues

1. **Agent Not Responding**
   ```bash
   # Check if session exists
   tmux list-sessions | grep agent-name
   
   # Attach to session to debug
   tmux attach-session -t agent-name
   ```

2. **Git Conflicts**
   ```bash
   # View conflict status
   git status
   
   # Resolve conflicts and commit
   git add -A
   git commit -m "Resolve merge conflicts"
   ```

3. **Communication Failures**
   ```bash
   # Test message sending
   ./send-chatgpt-message.sh test:0 "Test message"
   
   # Check tmux window exists
   tmux list-windows -t session-name
   ```

### Emergency Procedures

1. **System-wide restart**:
   - Save all work (commit everything)
   - Create snapshot of current state
   - Restart agents one by one
   - Verify communication restored

2. **Agent replacement**:
   - Brief new agent with current context
   - Transfer active tasks
   - Update team on the change

## 📚 Web Research is Your Friend

When facing technical challenges:
- Search for similar issues and solutions
- Check official documentation
- Review best practices and patterns
- Learn from community discussions

Remember: The web contains vast knowledge that can help solve problems faster than trial and error.

## 🎯 Scheduling and Automation

Use the scheduling system for regular check-ins:

```bash
# Schedule next check
./schedule_with_note.sh 15 "Check build status and agent progress"

# View scheduled checks
cat next_check_note.txt
```

### Automation Guidelines
- Schedule checks every 15-30 minutes during active development
- Use longer intervals (1-2 hours) during maintenance phases
- Always include meaningful notes for context
- Monitor system health continuously

## 📝 Documentation Standards

All agents should maintain:
- Clear README files for new features
- Inline code comments for complex logic
- Architecture decision records (ADRs)
- API documentation for public interfaces

## 🔒 Security Considerations

- Never commit secrets or API keys
- Use environment variables for configuration
- Validate all inputs and sanitize outputs
- Follow principle of least privilege
- Regular security audits and updates

## 💡 Innovation and Improvement

Encourage agents to:
- Suggest process improvements
- Share useful tools and techniques
- Propose architectural enhancements
- Document lessons learned

## 🎨 Agent Personality Guidelines for ChatGPT

### Professional Demeanor
- Maintain a helpful, collaborative tone
- Be proactive in identifying issues
- Take ownership of assigned tasks
- Communicate clearly and concisely

### Problem-Solving Approach
- Break complex problems into manageable parts
- Research thoroughly before implementing
- Consider multiple solutions and trade-offs
- Document reasoning behind decisions

### Team Collaboration
- Respect other agents' expertise
- Offer assistance when appropriate
- Share knowledge and insights
- Maintain professional boundaries

---

*This knowledge base should be regularly updated as the project evolves and new patterns emerge.*
