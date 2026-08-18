# Project Copilot Instructions

## Mission

Build government healthcare anomaly and fraud-detection software that protects sensitive data, supports authorized human decisions, and preserves evidence and auditability.

## Authoritative Standards

- For application code, architecture, APIs, UI, middleware, Microsoft Foundry, security, privacy, naming, and testing, follow [.NET application instructions](./instructions/dotnet-app-instructions.md).
- For lifecycle artifacts and delivery gates, follow [SDLC workflow instructions](./instructions/sdlc-workflow.instructions.md).
- When standards conflict, apply the stricter security, privacy, accessibility, testing, or human-review requirement and document the decision.

## Required Workflow

1. Start from an approved use case with stable `UC-###` and `AC-###` identifiers.
2. Create independently deliverable GitHub issues that reference the use case and acceptance criteria.
3. Implement one issue at a time with the smallest justified change and no unrelated refactoring.
4. Add or update automated tests and trace them to acceptance criteria and material risks.
5. Run the narrowest relevant validation after the first code edit, then the required build, test, analyzer, security, and AI evaluation gates before completion.
6. Open a pull request that links issues and reports requirement, test, security/privacy, AI, accessibility, deployment, and rollback evidence.
7. Do not mark work complete while required evidence is missing or a quality gate is failing.

## Working Rules

- Never invent requirements, approvals, compliance claims, test results, issue numbers, or operational evidence. Mark unknowns explicitly and ask the accountable owner.
- Use synthetic or approved de-identified data in examples, fixtures, prompts, screenshots, and generated artifacts.
- Keep traceability: `use case -> acceptance criterion -> issue -> code/test -> pull request -> release evidence`.
- Preserve existing repository conventions when they are stricter than these instructions.
- Do not commit, push, merge, deploy, or alter production resources without explicit user authorization.
- Do not bypass failed tests, weaken analyzers, disable security controls, or reduce coverage merely to make a gate pass.

## Validation

- Discover repository-provided build and test commands before running them. Do not guess commands when project files or documentation define them.
- Report commands run, relevant results, skipped checks, and residual risks.
- For Microsoft Foundry changes, require versioned configuration, representative evaluation evidence, safety testing, human-review behavior, monitoring, and rollback.