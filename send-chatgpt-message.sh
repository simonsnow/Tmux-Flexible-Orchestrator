#!/bin/bash

# Send message to ChatGPT agent in tmux window
# Usage: send-chatgpt-message.sh <session:window> <message>

if [ $# -lt 2 ]; then
    echo "Usage: $0 <session:window> <message>"
    echo "Example: $0 agentic-seek:3 'Hello ChatGPT!'"
    echo "Example: $0 orchestrator-v2:1 '/specify Describe the new feature to generate spec.md'"
    echo "Example: $0 orchestrator-v2:1 '/plan Provide technical plan for the specified feature'"
    echo "Example: $0 orchestrator-v2:1 '/tasks Generate actionable tasks for the feature'"
    exit 1
fi

WINDOW="$1"
shift  # Remove first argument, rest is the message
MESSAGE="$*"

# Send the message
tmux send-keys -t "$WINDOW" "$MESSAGE"

# Wait 0.5 seconds for UI to register
sleep 0.5

# Send Enter to submit
tmux send-keys -t "$WINDOW" Enter

echo "Message sent to $WINDOW: $MESSAGE"