# Sample Requests

Use these examples to test the skill in different agent runtimes.

## PR Input

```text
用这个 PR 生成 demo 文档：https://github.com/acme/product/pull/1234
```

## Jira Input

```text
基于这个 Jira 生成 demo 文档：APP-2048
```

## Explicit Skill Invocation

```text
使用 $generate-demo-doc，把这个需求整理成方便 team demo 的飞书文档：APP-2048
```

## Expected Runtime Behavior

- Resolve Jira context when a key is available.
- Use PR context for shipped scope.
- Use repo docs for terminology when available.
- Produce a business-facing markdown document.
- Publish to Feishu only when the runtime has the required tools.
