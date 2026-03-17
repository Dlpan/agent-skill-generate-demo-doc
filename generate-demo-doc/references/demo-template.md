# Demo Doc Template

Use this structure as the default output shape. Adapt section wording to the feature, but do not remove sections unless the source material is truly missing.

## 标题

`<JIRA_KEY> Demo 稿：<business-facing feature title>`

Fallback:

`PR-<number> Demo 稿：<business-facing feature title>`

## 一句话总结

用 1 到 2 句说明这次需求的业务价值。强调用户工作流改变，不强调实现细节。

## 1. User Story

**Jira Story**

保留 Jira 中原始英文 user story；如果没有，就根据 Jira summary 和描述补一版简洁英文 user story。

**中文表述**

用自然中文重述 user story，站在 frontdesk / store manager / staff / user 的角度讲清楚目标和收益。

## 2. 这次需求解决了什么问题

说明原来的使用方式、信息缺失、决策成本或操作阻力。

优先写：

- 用户以前是怎么做的
- 为什么会慢、会绕、会有误判
- 这个问题为什么是高频且有业务影响的

## 3. Solution / Outcome

说明上线后用户现在能做什么、看见什么、少做什么。

优先写：

- 信息是否被前置
- 判断是否更直接
- 操作路径是否缩短
- 哪个高频场景因此变顺

## 4. 适用场景

列出本次变更覆盖的典型入口或业务场景。用用户能理解的产品语言，不要写成代码文件清单。

## 5. Before & After

用一个简洁表格对比：

- 信息可见性
- 判断方式
- 操作路径
- 高频场景体验
- 一致性或信心

然后加两句口头讲法：

- `Before`：一句话
- `After`：一句话

## 6. Demo 时建议怎么讲

按这四段组织：

- 开场
- 问题陈述
- 展示变化
- 强调价值

每段 1 到 3 句，口语化，可直接念。

## 7. 你可以直接使用的 Demo Script

必须包含：

- 30 秒版本
- 90 秒版本

脚本要像口头表达，不要像书面报告。

## 8. Demo 时可以强调的 Outcome

列 4 到 6 个 flat bullets，聚焦业务价值、效率提升、判断更清晰、路径更短、一致性更好。

## 9. 推荐的现场 Demo 路径

给出 4 到 6 步的 live demo 顺序，优先让观众先看到变化点，再看到后续操作。

最后补一条“最适合现场记忆的 before/after 一句话”。

## 10. 非核心但可以备用的一句话

只保留一句技术兜底话术，用于现场有人追问技术实现时再补充。

要求：

- 不展开技术细节
- 只说明这次在产品层变化背后的实现方向
- 明确“这不是这次 demo 的重点”
