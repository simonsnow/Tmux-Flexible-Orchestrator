# Orchestrator Learnings

## 2025-06-18 - Project Management & Agent Oversight

### Discovery: Importance of Web Research
- **Issue**: Developer spent 2+ hours trying to solve JWT multiline environment variable issue in Convex
- **Mistake**: As PM, I didn't suggest web research until prompted by the user
- **Learning**: Should ALWAYS suggest web research after 10 minutes of failed attempts
- **Solution**: Added "Web Research is Your Friend" section to global CHATGPT.md
- **Impact**: Web search immediately revealed the solution (replace newlines with spaces)

### Insight: Reading Error Messages Carefully
- **Issue**: Developer spent time on base64 decoding when the real error was "Missing environment variable JWT_PRIVATE_KEY"
- **Learning**: Always verify the actual error before implementing complex solutions
- **Pattern**: Developers often over-engineer solutions without checking basic assumptions
- **PM Action**: Ask "What's the EXACT error message?" before approving solution approaches

### Project Manager Best Practices
- **Be Firm but Constructive**: When developer was coding without documenting, had to insist on LEARNINGS.md creation
- **Status Reports**: Direct questions get better results than open-ended "how's it going?"
- **Escalation Timing**: If 3 approaches fail, immediately suggest different strategy
- **Documentation First**: Enforce documentation BEFORE continuing to code when stuck

### Communication Patterns That Work
- **Effective**: "STOP. Give me status: 1) X fixed? YES/NO 2) Current error?"
- **Less Effective**: "How's the authentication coming along?"
- **Key**: Specific, numbered questions force clear responses

### Reminder System
- **Discovery**: User reminded me to set check-in reminders before ending conversations
- **Implementation**: Use schedule_with_note.sh with specific action items
- **Best Practice**: Always schedule follow-up with concrete next steps, not vague "check progress"

## 2025-06-17 - Agent System Design

### Multi-Agent Coordination
- **Challenge**: Communication complexity grows exponentially (n²) with more agents
- **Solution**: Hub-and-spoke model with PM as central coordinator
- **Key Insight**: Structured communication templates reduce ambiguity and overhead

### Agent Lifecycle Management
- **Learning**: Need clear distinction between permanent and temporary agents
- **Solution**: Implement proper logging before terminating agents
- **Directory Structure**: agent_logs/permanent/ and agent_logs/temporary/

### Quality Assurance
- **Principle**: PMs must be "meticulous about testing and verification"
- **Implementation**: Verification checklists, no shortcuts, track technical debt
- **Key**: Trust but verify - always check actual implementation

## Common Pitfalls to Avoid

1. **Not Using Available Tools**: Web search, documentation, community resources
2. **Circular Problem Solving**: Trying same approach repeatedly without stepping back
3. **Missing Context**: Not checking other tmux windows for error details
4. **Poor Time Management**: Not setting time limits on debugging attempts
5. **Incomplete Handoffs**: Not documenting solutions for future agents

## Orchestrator-Specific Insights

- **Stay High-Level**: Don't get pulled into implementation details
- **Pattern Recognition**: Similar issues across projects (auth, env vars, etc.)
- **Cross-Project Knowledge**: Use insights from one project to help another
- **Proactive Monitoring**: Check multiple windows to spot issues early

## 2025-06-18 - Later Session - Authentication Success Story

### Effective PM Intervention
- **Situation**: Developer struggling with JWT authentication for 3+ hours
- **Key Action**: Sent direct encouragement when I saw errors were resolved
- **Result**: Motivated developer to document learnings properly
- **Lesson**: Timely positive feedback is as important as corrective guidance

### Cross-Window Intelligence 
- **Discovery**: Can monitor server logs while developer works
- **Application**: Saw JWT_PRIVATE_KEY error was resolved before developer noticed
- **Value**: Proactive encouragement based on real-time monitoring
- **Best Practice**: Always check related windows (servers, logs) for context

### Documentation Enforcement
- **Challenge**: Developers often skip documentation when solution works
- **Solution**: Send specific reminders about what to document
- **Example**: Listed exact items to include in LEARNINGS.md
- **Impact**: Ensures institutional knowledge is captured

### ChatGPT Plan Mode Discovery
- **Feature**: ChatGPT has planning capabilities that can be activated through specific prompts
- **Key Approach**: Request ChatGPT to create a plan before implementing features
- **Critical Step**: MUST verify ChatGPT acknowledges the planning request
- **Tmux Implementation**: Use `send-chatgpt-message.sh` to send planning requests
- **Verification**: Check ChatGPT response includes step-by-step breakdown
- **Troubleshooting**: If no plan provided, rephrase request for explicit planning
- **User Guidance**: Users can help guide ChatGPT into proper planning mode
- **Use Case**: Use planning mode for complex feature implementations
- **Best Practice**: Always request planning before major coding begins
- **Key Learning**: Planning mode forces thoughtful approach before coding begins

## 2025-09-16 - Spec Kit Integration

- **Key Insight**: Vendoring Spec Kit enables offline-first workflows when GitHub releases are unreachable.
- **Workflow Change**: All ChatGPT agents now follow `/specify → /plan → /tasks` before writing code; documentation updated in `CHATGPT.md` and `README.md`.
- **Fallback Strategy**: Copy templates from `spec-kit/templates/` into `specs/<feature>/` to bootstrap artifacts without running the CLI.
- **Verification**: Introduced example artifacts in `specs/001-orchestrator-v2-spec-kit/` to set expectations and validate the pipeline end-to-end.
