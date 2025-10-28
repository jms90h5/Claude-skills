#!/bin/bash
# Install IBM Streams Claude Skills Locally
# Run this script on your local machine where Claude Code CLI runs

set -e

echo "IBM Streams Claude Skills - Local Installation"
echo "=============================================="
echo ""

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SKILLS_DIR="$SCRIPT_DIR/skills"

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "Error: Skills directory not found at $SKILLS_DIR"
    echo "Please run this script from the Claude-skills repository root"
    exit 1
fi

# Create Claude Code skills directory
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
echo "Creating skills directory: $CLAUDE_SKILLS_DIR"
mkdir -p "$CLAUDE_SKILLS_DIR"

# Copy or link skills
echo ""
echo "Choose installation method:"
echo "1) Symlink (recommended - stays updated with git pull)"
echo "2) Copy (standalone - doesn't update automatically)"
read -p "Enter choice [1]: " choice
choice=${choice:-1}

if [ "$choice" = "1" ]; then
    echo ""
    echo "Creating symlinks..."
    for skill in "$SKILLS_DIR"/*.md; do
        skill_name=$(basename "$skill")
        target="$CLAUDE_SKILLS_DIR/$skill_name"

        # Remove existing link/file
        [ -e "$target" ] && rm -f "$target"

        # Create symlink
        ln -s "$skill" "$target"
        echo "  ✓ Linked: $skill_name"
    done
else
    echo ""
    echo "Copying skills..."
    cp "$SKILLS_DIR"/*.md "$CLAUDE_SKILLS_DIR/"
    echo "  ✓ Copied all skills"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Skills installed to: $CLAUDE_SKILLS_DIR"
echo ""
echo "Installed skills:"
ls -1 "$CLAUDE_SKILLS_DIR"/*.md 2>/dev/null | xargs -n1 basename

echo ""
echo "Next steps:"
echo "1. Open Claude Code on your local machine"
echo "2. Reference skills in your prompts:"
echo "   'Using the streams-spl-app skill, create an application...'"
echo ""
echo "To update skills (if using symlinks):"
echo "   cd $SCRIPT_DIR && git pull"
echo ""
echo "To uninstall:"
echo "   rm -rf $CLAUDE_SKILLS_DIR"
echo ""
