#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🔍 Checking prerequisites..."

# 1. Check codex CLI
if ! command -v codex &>/dev/null; then
  echo "❌ Error: 'codex' CLI not found."
  echo "   Install it first: https://github.com/openai/codex"
  exit 1
fi
echo "✅ codex CLI found: $(command -v codex)"

# 2. Install skill
SKILL_SRC="$SCRIPT_DIR/plugins/claude-code-cross-review/skills/cross-review/SKILL.md"
SKILL_DST="$CLAUDE_DIR/skills/cross-review/SKILL.md"
mkdir -p "$(dirname "$SKILL_DST")"
cp "$SKILL_SRC" "$SKILL_DST"
echo "✅ Skill installed: $SKILL_DST"

# 3. Install command
CMD_SRC="$SCRIPT_DIR/plugins/claude-code-cross-review/commands/codex-review.md"
CMD_DST="$CLAUDE_DIR/commands/codex-review.md"
mkdir -p "$(dirname "$CMD_DST")"
cp "$CMD_SRC" "$CMD_DST"
echo "✅ Command installed: $CMD_DST"

# 4. Register Codex MCP server in ~/.claude/.mcp.json
MCP_PATH="$CLAUDE_DIR/.mcp.json"
python3 - <<EOF
import json, os

mcp_path = os.path.expanduser("~/.claude/.mcp.json")
config = {}
if os.path.exists(mcp_path):
    with open(mcp_path) as f:
        config = json.load(f)

config.setdefault("mcpServers", {})["codex"] = {
    "command": "codex",
    "args": ["mcp-server"]
}

with open(mcp_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")
print("✅ Codex MCP server registered in ~/.claude/.mcp.json")
EOF

echo ""
echo "🎉 claude-code-cross-review installed successfully!"
echo ""
echo "Usage:"
echo "  • Trigger skill:   tell Claude to use the 'cross-review' skill"
echo "  • Run command:     type /codex-review in Claude Code"
echo ""
echo "Restart Claude Code to activate."
