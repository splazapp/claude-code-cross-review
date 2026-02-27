# claude-code-cross-review

## 项目说明

此项目将"写的不审，审的不写"多模型代码审查工作流打包为可安装工具。

## 文件职责

| 文件 | 说明 |
|------|------|
| `skill/cross-review/SKILL.md` | 技能源文件，安装到 `~/.claude/skills/cross-review/` |
| `commands/codex-review.md` | 命令源文件，安装到 `~/.claude/commands/codex-review.md` |
| `install.sh` | 安装脚本 |
| `uninstall.sh` | 卸载脚本 |

## 修改流程

1. 修改 `skill/cross-review/SKILL.md` 或 `commands/codex-review.md`
2. 重新运行 `bash install.sh` 覆盖已安装版本
3. 重启 Claude Code 生效

## 注意

- 不要直接修改 `~/.claude/skills/cross-review/SKILL.md`，应修改此项目内的源文件
- `install.sh` 中的 MCP 注册采用 upsert 逻辑，可重复执行
