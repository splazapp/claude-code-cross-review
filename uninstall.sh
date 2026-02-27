#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"

echo "⚠️  This will remove claude-code-cross-review from your Claude Code installation."
read -rp "Continue? [y/N] " confirm
if [[ "${confirm,,}" != "y" ]]; then
  echo "Cancelled."
  exit 0
fi

# 1. Remove skill
SKILL_DST="$CLAUDE_DIR/skills/cross-review"
if [ -d "$SKILL_DST" ]; then
  rm -rf "$SKILL_DST"
  echo "✅ Removed skill: $SKILL_DST"
else
  echo "⏭️  Skill not found, skipping: $SKILL_DST"
fi

# 2. Remove command
CMD_DST="$CLAUDE_DIR/commands/codex-review.md"
if [ -f "$CMD_DST" ]; then
  rm "$CMD_DST"
  echo "✅ Removed command: $CMD_DST"
else
  echo "⏭️  Command not found, skipping: $CMD_DST"
fi

# 3. Remove Codex MCP entry from ~/.claude/.mcp.json
MCP_PATH="$CLAUDE_DIR/.mcp.json"
python3 - <<EOF
import json, os

mcp_path = os.path.expanduser("~/.claude/.mcp.json")
if not os.path.exists(mcp_path):
    print("⏭️  ~/.claude/.mcp.json not found, skipping MCP cleanup")
    exit(0)

with open(mcp_path) as f:
    config = json.load(f)

servers = config.get("mcpServers", {})
if "codex" in servers:
    del servers["codex"]
    config["mcpServers"] = servers
    with open(mcp_path, "w") as f:
        json.dump(config, f, indent=2)
        f.write("\n")
    print("✅ Removed codex MCP server from ~/.claude/.mcp.json")
else:
    print("⏭️  codex MCP server not found in config, skipping")
EOF

echo ""
echo "✅ Uninstalled. Please restart Claude Code to apply changes."
