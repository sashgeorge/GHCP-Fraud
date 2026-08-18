# Government Healthcare AI SDLC

This repository contains a GitHub Copilot customization suite for building government healthcare anomaly and fraud-detection applications with .NET, React, and Microsoft Foundry.

The workflow preserves traceability from use case through release:

```text
UC-### use case -> AC-### acceptance criteria -> GitHub issue -> code and tests -> pull request -> release evidence
```

AI output is decision support. It must not autonomously determine fraud or execute eligibility, payment, enforcement, referral, hold, case-closure, or other consequential actions.

## Start Here

1. Open GitHub Copilot Chat in this workspace.
2. Type `/` to view the workspace prompts.
3. Run `/Run SDLC Workflow` when starting from an idea or when the current lifecycle stage is unclear.
4. Use the focused commands below when the stage and artifact are already known.

See the detailed [SDLC stage guide](docs/SDLC.md) and [project Copilot instructions](.github/copilot-instructions.md).

## Copilot Commands

| Command | Purpose | Expected input |
|---|---|---|
| `/Run SDLC Workflow` | Determine the current stage and coordinate the next eligible action | Outcome plus any existing use case, issue, branch, or PR |
| `/Create Use Case` | Create or refine a traceable use case | Problem, actors, outcome, jurisdiction, and constraints |
| `/Create Issues From Use Case` | Decompose an approved use case into issue-ready work | Use-case path or `UC-###` |
| `/Implement Issue` | Implement and validate one traced issue | Issue plus `UC-###` and `AC-###` references |
| `/Create Test Plan` | Produce risk-based test strategy, cases, and traceability | Use case, issue/PR, criteria, and risks |
| `/Generate Unit Tests` | Add focused deterministic .NET or React tests | Code/behavior plus criterion references |
| `/Prepare Pull Request` | Prepare a PR description and quality evidence | Branch/diff and linked issues |
| `/Review Pull Request` | Perform an independent risk-focused review | PR, branch, diff, or changed files |
| `/Assess Release Readiness` | Assess a specific artifact without deploying it | Artifact/version, environment, and evidence |

Example chat requests:

```text
/Create Use Case Detect duplicate billing patterns while preserving authorized human review.

/Create Issues From Use Case docs/use-cases/UC-001-duplicate-billing-alerts.md

/Implement Issue Implement issue #42 for UC-001 and AC-003.

/Generate Unit Tests Verify AC-003 authorization denial and audit behavior.

/Review Pull Request Review PR #57 against UC-001 and its linked acceptance criteria.
```

The prompt display names come from the files under [.github/prompts](.github/prompts). If a command does not appear immediately, reload the VS Code window and type `/` in Copilot Chat again.

## Specialist Agents

| Agent | Responsibility | Write access |
|---|---|---|
| SDLC Orchestrator | Coordinates lifecycle stages and gates | No application edits |
| Product Analyst | Authors and reviews use cases | Requirements artifacts only |
| Delivery Planner | Produces issue decomposition and coverage | Planning artifacts only |
| .NET Developer | Implements one approved issue and validates it | Yes |
| Test Engineer | Creates test artifacts/code and executes checks | Yes |
| Pull Request Reviewer | Independent code and PR review | No |
| Release Manager | Evidence-based release assessment | No deployment |

Select an agent from the Copilot Chat agent picker when direct role interaction is preferable to a slash command.

## Repository Layout

```text
.github/
  copilot-instructions.md            Project-wide behavior and safety rules
  instructions/                      .NET/Foundry and SDLC standards
  prompts/                           Slash-command entry points
  agents/                            Role-focused Copilot agents
  skills/                            Repeatable lifecycle procedures
  hooks/                             Policy guards and customization validation
  ISSUE_TEMPLATE/                    Use-case work-item and defect forms
  pull_request_template.md           Traceable PR evidence template
docs/
  SDLC.md                            Lifecycle map and exit gates
  templates/                         Use-case, test, and release templates
  use-cases/                         Approved/draft UC-### artifacts when created
```

## Templates

- [Use case](docs/templates/use-case.md)
- [Test plan](docs/templates/test-plan.md)
- [Test case](docs/templates/test-case.md)
- [Release readiness](docs/templates/release-readiness.md)
- [Pull request](.github/pull_request_template.md)
- [Use-case work-item form](.github/ISSUE_TEMPLATE/use-case-work-item.yml)
- [Defect form](.github/ISSUE_TEMPLATE/defect.yml)

Do not put protected health information, personally identifiable information, credentials, raw claims, or case evidence in these artifacts. Use synthetic or approved de-identified examples.

## Validation Commands

Run the customization validator from the repository root:

```powershell
'{}' | pwsh -NoProfile -File .github/hooks/validate-customizations.ps1
```

Expected result:

```json
{"continue":true,"systemMessage":"Workspace customization frontmatter, JSON, relative links, and whitespace checks passed."}
```

Validate the hook configuration JSON directly:

```powershell
Get-Content .github/hooks/sdlc-policy.json -Raw | ConvertFrom-Json | Out-Null
```

List the installed prompts, agents, and skills:

```powershell
Get-ChildItem .github/prompts -Filter *.prompt.md
Get-ChildItem .github/agents -Filter *.agent.md
Get-ChildItem .github/skills -Filter SKILL.md -Recurse
```

Exercise the pre-tool guard with a non-destructive read payload:

```powershell
'{"toolName":"read_file","toolInput":{"filePath":"README.md"}}' |
  pwsh -NoProfile -File .github/hooks/guard-tool-use.ps1
```

The expected permission decision is `allow`. Policy-file writes return `ask`, while selected destructive Git commands such as `git reset --hard` return `deny`.

## Application Build and Test Commands

The repository currently defines the SDLC customization layer rather than an application solution. Once application projects are added, use the commands documented by that solution. Typical .NET commands are:

```powershell
dotnet restore
dotnet build --no-restore
dotnet test --no-build
```

Do not treat these examples as the complete quality gate. The implementation must also define and run its formatting, analyzer, security, dependency, accessibility, integration, and Microsoft Foundry evaluation commands as applicable.

## Hooks and Safeguards

The [SDLC hook configuration](.github/hooks/sdlc-policy.json) provides:

- Session policy injection for traceability and safe data use
- Confirmation before changing Copilot policy and automation files
- Denial of selected destructive or history-rewriting Git commands
- Stop-time validation of customization frontmatter, skill names, JSON, relative links, and whitespace

Hooks supplement normal GitHub permissions, branch protection, code owners, CI, security scanning, and human approval. They do not replace those controls.

## Delivery Rules

- Keep `UC-###` and `AC-###` identifiers stable.
- Implement one independently reviewable issue at a time.
- Run the narrowest relevant executable check immediately after the first substantive code edit.
- Never invent approvals, compliance claims, issue numbers, test results, or release evidence.
- Do not weaken analyzers, tests, security controls, coverage, or human-review requirements to make a gate pass.
- Do not commit, push, merge, deploy, or alter production resources without explicit authorization.
- For Foundry changes, version model, prompt, retrieval, tool, evaluator, threshold, monitoring, fallback, and rollback configuration.