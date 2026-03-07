---
description: Trigger claude-review workflow — a Claude subagent reviews uncommitted changes, main Claude fixes, loop until clean.
---

# Claude Code Review

触发 Claude Cross-Review 多模型代码审查工作流。

由独立的 Claude subagent 审查当前未提交的代码变更，找出边界条件、逻辑漏洞和类型安全问题，主 Claude 逐项修复，循环直到无新问题。无需 Codex / GPT，纯 Claude 实现"写的不审，审的不写"原则。

请使用 `claude-review` 技能执行完整的写-审-修工作流。
