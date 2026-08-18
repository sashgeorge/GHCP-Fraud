# Government Healthcare AI SDLC

This repository uses gated, evidence-based delivery with traceability from use case through release. Start with `/Run SDLC Workflow` when the current stage is unclear, or invoke a focused prompt below.

| Stage | Prompt | Agent | Skill | Primary artifact | Exit gate |
|---|---|---|---|---|---|
| Use case | `/Create Use Case` | Product Analyst | [Use-case development](../.github/skills/use-case-development/SKILL.md) | `docs/use-cases/UC-###-title.md` | Testable criteria; no hidden blocker; human review identified |
| Issue planning | `/Create Issues From Use Case` | Delivery Planner | [Issue decomposition](../.github/skills/issue-decomposition/SKILL.md) | GitHub issues | Complete criterion/risk ownership and dependency order |
| Implementation | `/Implement Issue` | .NET Developer | [.NET implementation](../.github/skills/dotnet-implementation/SKILL.md) | Code, tests, migrations, docs | Issue criteria traced to observed validation |
| Verification | `/Create Test Plan` or `/Generate Unit Tests` | Test Engineer | [Quality verification](../.github/skills/quality-verification/SKILL.md) | Test plan, cases, automation, results | Required evidence observed; gaps explicitly owned |
| Pull request | `/Prepare Pull Request` | .NET Developer | [Pull-request delivery](../.github/skills/pull-request-delivery/SKILL.md) | Pull request | Complete traceability and quality evidence |
| Independent review | `/Review Pull Request` | Pull Request Reviewer | [Pull-request delivery](../.github/skills/pull-request-delivery/SKILL.md) | Review findings/verdict | Blocking findings resolved and required approvals present |
| Release readiness | `/Assess Release Readiness` | Release Manager | [Release readiness](../.github/skills/release-readiness/SKILL.md) | Release-readiness record | Evidence-based readiness verdict; deployment separately authorized |

## Core Rules

- Follow [project Copilot instructions](../.github/copilot-instructions.md), [.NET application instructions](../.github/instructions/dotnet-app-instructions.md), and [SDLC workflow instructions](../.github/instructions/sdlc-workflow.instructions.md).
- Keep `UC-###` and `AC-###` identifiers stable across issues, tests, pull requests, and release evidence.
- Use only synthetic or approved de-identified data in repository artifacts and automated tests.
- Do not infer approval, passing checks, compliance, or release authority from generated content.
- Do not deploy through this workflow without explicit authorization and the organization's approved deployment process.

## Templates

- [Use case](templates/use-case.md)
- [Test plan](templates/test-plan.md)
- [Test case](templates/test-case.md)
- [Release readiness](templates/release-readiness.md)
- [Pull request](../.github/pull_request_template.md)

## Automation

[SDLC hooks](../.github/hooks/sdlc-policy.json) inject session policy, require confirmation for Copilot policy edits, deny selected destructive Git commands, and validate customization frontmatter, JSON, relative links, and whitespace at session stop. Repository build, test, analyzer, security, accessibility, and AI evaluation commands remain explicit stage gates because they depend on the application being implemented.