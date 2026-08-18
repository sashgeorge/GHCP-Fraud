---
name: dotnet-implementation
description: "Implement a traced GitHub issue in the government healthcare .NET and React application. Use for coding, refactoring, APIs, middleware, backend, UI, Microsoft Foundry adapters, migrations, and issue-level validation."
argument-hint: "Provide the issue link/number and related UC-### and AC-### identifiers."
---

# .NET Issue Implementation

## Preconditions

- The issue has testable acceptance criteria and links to its use case.
- Required architecture, security/privacy, and AI decisions are approved or explicitly identified as blockers.

## Procedure

1. Read the issue, linked use case, [.NET application instructions](../../instructions/dotnet-app-instructions.md), and [SDLC workflow instructions](../../instructions/sdlc-workflow.instructions.md).
2. Inspect the nearest owning code, tests, contracts, and repository-provided build commands. Do not begin with a broad refactor.
3. State one falsifiable local behavior hypothesis, the controlling code path, and the cheapest check that could disprove it.
4. Add or adjust the narrowest test that expresses the intended behavior when practical, then make the smallest production edit.
5. Immediately run the narrow check. Repair the same slice or reassess the controlling code path before widening scope.
6. Complete required contracts, validation, authorization, audit, telemetry, redaction, migrations, documentation, feature flags, and fallback/rollback behavior.
7. For Foundry changes, use an application-owned adapter and versioned configuration; add controlled tests and required evaluation artifacts without calling live models from unit tests.
8. Run formatting, build, analyzers, unit tests, and scoped integration/evaluation checks defined by the repository and issue.
9. Report changed behavior, traceability, commands/results, skipped checks, and residual risks. Never claim unexecuted validation.

## Constraints

- Do not commit, push, merge, deploy, weaken a gate, or change production resources without explicit authorization.
- Do not include sensitive healthcare data in code, prompts, fixtures, logs, screenshots, or reports.
- Do not mix unrelated cleanup into the issue.

## Exit Gate

The issue acceptance criteria are implemented and traced to observed tests, or the report names the exact blocker and unfinished criteria.