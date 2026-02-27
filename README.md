# claude-code-cross-review

> **The writer doesn't review. The reviewer doesn't write.**

A multi-model code review workflow for Claude Code. Claude (Opus) writes the code, Codex (GPT) reviews it, Claude fixes what Codex finds — looping until clean, then commits.

> **写的不审，审的不写。**
>
> Claude Code 的多模型代码审查工作流。Claude (Opus) 写代码，Codex (GPT) 审代码，Claude 修复 Codex 发现的问题，循环直到干净，再提交。

---

## How It Works / 工作原理

```
Code written / 代码写完
        ↓
[Codex] Review uncommitted changes / 审查未提交改动
        ↓
Issues found? / 有问题？
  Yes ──→ [Claude] Fix each issue / 逐项修复 ──→ Back to review / 回到审查
  No  ↓
lint / build / test
        ↓
git commit
```

| Role / 角色 | Model / 模型 | Responsibility / 职责 |
|---|---|---|
| Write / 写代码 | Claude Opus 4.6 | Feature dev, bug fixes, refactoring / 功能开发、Bug 修复、重构 |
| Review / 审代码 | Codex (GPT-5.3) | Edge cases, logic bugs, type safety / 边界条件、逻辑漏洞、类型安全 |

Codex is integrated via MCP protocol — no window switching required. Falls back to `codex` CLI if MCP is unavailable.

Codex 通过 MCP 协议集成，Claude 无需切换窗口即可调用审查。若 MCP 不可用，自动回退到 `codex` CLI。

---

## Requirements / 前置要求

Install [OpenAI Codex CLI](https://github.com/openai/codex) / 安装 Codex CLI：

```bash
npm install -g @openai/codex
# or / 或
brew install codex
```

Verify / 验证：

```bash
codex --version
```

---

## Installation / 安装

```bash
git clone https://github.com/splazapp/claude-code-cross-review.git
cd claude-code-cross-review
bash install.sh
```

This installs / 安装内容：

- `~/.claude/skills/cross-review/SKILL.md` — workflow skill / 工作流技能
- `~/.claude/commands/codex-review.md` — `/codex-review` slash command / 快捷命令
- `~/.claude/.mcp.json` — registers Codex as an MCP server / 注册 Codex 为 MCP 服务器

**Restart Claude Code after installation. / 安装完成后重启 Claude Code。**

---

## Usage / 使用方式

**Option 1 — Trigger the skill / 触发技能：**

Tell Claude in Claude Code / 在 Claude Code 中告诉 Claude：

```
Use the cross-review skill to review current changes.
使用 cross-review 技能审查当前改动
```

**Option 2 — Slash command / 使用命令：**

```
/codex-review
```

---

## Uninstall / 卸载

```bash
bash uninstall.sh
```

---

## Why This Works / 为什么这样有效

Claude is great at writing code but tends to miss its own blind spots. Codex, as an independent model, reviews without bias toward the original implementation. The result: fewer bugs reach `git commit`.

Claude 擅长写代码，但容易对自己的盲点视而不见。Codex 作为独立模型，审查时不带对原实现的偏见。结果是：更少的 bug 进入 `git commit`。

---

## Version / 版本

v1.0.0
