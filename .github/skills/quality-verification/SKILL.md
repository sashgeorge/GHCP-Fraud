---
name: quality-verification
description: "Design test plans and test cases, generate or review unit tests, execute quality gates, and report evidence for .NET, React, API, integration, accessibility, security/privacy, and Microsoft Foundry AI changes."
argument-hint: "Provide a use case, issue, pull request, code path, or acceptance criteria to verify."
---

# Quality Verification

## Procedure

1. Read the use case, acceptance criteria, issue, changed code, and relevant instructions. Identify trust boundaries, failure modes, consequential actions, and regression risks.
2. Draft or update [the test plan](../../../docs/templates/test-plan.md) and individual cases using [the test-case template](../../../docs/templates/test-case.md).
3. Build a traceability matrix from `AC-###` and risk IDs to test cases and automated test locations.
4. Prefer deterministic unit tests for domain/application behavior; use component/contract/integration/end-to-end tests only where the boundary adds meaningful confidence.
5. Cover authorization allow/deny, data isolation, validation boundaries, redaction, audit, idempotency, concurrency, cancellation, timeout, retries, dependency failure, and recovery as applicable.
6. For React, cover user-observable behavior, keyboard interaction, accessible names/states, asynchronous states, and server rejection; avoid tests coupled to implementation details.
7. For Foundry/AI, use fixed controlled responses in unit tests and representative approved datasets for evaluation. Record model, prompt, retrieval, tool, evaluator, and threshold versions.
8. Discover and run repository-defined commands. Run the narrowest relevant checks first, then all gates required by the issue/PR.
9. Record actual commands, results, environment/artifact identity, failures, skipped checks, and residual risk. Never change production logic merely to satisfy an incorrect test without reconciling the requirement.

## Unit Test Naming

- .NET: `<MethodOrBehavior>_<Condition>_<ExpectedOutcome>` unless the repository has a stricter established convention.
- React/TypeScript: name tests as user-observable sentences and keep files beside the feature or in the repository's established test location.

## Exit Gate

All acceptance criteria and material risks have evidence, or the report marks them failed, blocked, or not run with an owner and reason.