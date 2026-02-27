# claude-code-cross-review

> **写的不审，审的不写** — 多模型代码审查工作流

Claude (Opus) 写代码，Codex (GPT) 审代码，循环修复直到无新问题，再提交。两个模型各司其职，互不越界。

---

## 工作流程

```
代码写完
    ↓
[Codex] 审查未提交改动
    ↓
有问题？ ──是──→ [Claude] 逐项修复 ──→ 回到审查
    ↓ 否
lint / build / test
    ↓
git commit
```

---

## 前置要求

需要安装 [OpenAI Codex CLI](https://github.com/openai/codex)：

```bash
npm install -g @openai/codex
# 或
brew install codex
```

验证安装：

```bash
codex --version
```

---

## 安装

**本地安装**（克隆后运行）：

```bash
git clone https://github.com/splat/claude-code-cross-review.git
cd claude-code-cross-review
bash install.sh
```

安装内容：
- `~/.claude/skills/cross-review/SKILL.md` — 工作流技能
- `~/.claude/commands/codex-review.md` — `/codex-review` 快捷命令
- `~/.claude/.mcp.json` 中注册 Codex 为 MCP 服务器

安装完成后**重启 Claude Code** 生效。

---

## 使用方式

**方式一：触发技能**

在 Claude Code 中告诉 Claude：

```
使用 cross-review 技能审查当前改动
```

**方式二：使用命令**

```
/codex-review
```

---

## 卸载

```bash
bash uninstall.sh
```

---

## 工作原理

| 角色 | 模型 | 职责 |
|------|------|------|
| 写代码 | Claude Opus 4.6 | 功能开发、Bug 修复、重构 |
| 审代码 | Codex (GPT-5.3) | 边界条件、逻辑漏洞、类型安全 |

Codex 通过 MCP 协议集成，Claude 无需切换窗口即可调用审查。若 MCP 不可用，自动回退到 `codex` CLI。

---

## 版本

v1.0.0
