#!/bin/bash

# Test script to verify ChatGPT conversion
echo "Testing Tmux Orchestrator ChatGPT Conversion"
echo "============================================="

echo ""
echo "1. Testing send-chatgpt-message.sh usage display:"
./send-chatgpt-message.sh

echo ""
echo "2. Checking file permissions:"
ls -la send-chatgpt-message.sh


echo ""
echo "3. Testing tmux_utils.py:"
python3 -c "from tmux_utils import TmuxOrchestrator; print('TmuxOrchestrator imported successfully')"

echo ""
echo "4. Verifying CHATGPT.md exists:"
ls -la CHATGPT.md

echo ""
echo "5. Checking schedule script:"
ls -la schedule_with_note.sh

echo ""
echo "✅ Conversion test completed!"
echo ""
echo "Key changes made:"
echo "- send-chatgpt-message.sh is the primary messaging script (legacy shim: send-claude-message.sh)"
echo "- ChatGPT playbook maintained in CHATGPT.md (CLAUDE.md retained only as legacy notice)"
echo "- README updated to reference ChatGPT agents"
echo "- LEARNINGS.md updated with ChatGPT terminology"
echo "- schedule_with_note.sh updated with correct paths"
