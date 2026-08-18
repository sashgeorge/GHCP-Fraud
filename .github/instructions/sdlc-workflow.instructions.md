---
name: "Government Healthcare SDLC Workflow"
description: "Use when creating use cases, requirements, GitHub issues, implementation plans, test cases, unit tests, pull requests, reviews, releases, or traceability evidence for the government healthcare fraud-detection SDLC."
applyTo: "docs/**/*.md, .github/ISSUE_TEMPLATE/**, .github/PULL_REQUEST_TEMPLATE*, .github/pull_request_template.md, **/*Tests/**/*.cs, **/*.Tests/**/*.cs, **/*.test.ts, **/*.test.tsx, **/*.spec.ts, **/*.spec.tsx"
---

# SDLC Workflow Standards

## Traceability

- Assign use cases stable `UC-###` identifiers and acceptance criteria stable `AC-###` identifiers.
- Every implementation, defect, test, and technical-debt issue must link to its originating use case or explicitly state why no use case applies.
- Every test case must reference one or more acceptance criteria or identified risks.
- Every pull request must link its issues and include a requirement-to-test traceability table.
- Do not silently renumber identifiers after downstream artifacts reference them.

## Use Case Gate

- Define problem, actors, trigger, preconditions, main flow, alternate/error flows, postconditions, business rules, data classification, authorization, audit, accessibility, AI/human-review behavior, measurable acceptance criteria, and out-of-scope behavior.
- Separate confirmed requirements from assumptions and open questions. An assumption is not approval.
- Use neutral terms such as anomaly, indicator, alert, and review recommendation; do not presume fraud.
- A use case is ready only when each acceptance criterion is observable and testable and the accountable product owner has no unresolved blocking question.

## Issue Planning Gate

- Decompose work into cohesive, independently reviewable issues that can be validated without relying on hidden follow-up work.
- Include scope, acceptance-criterion references, technical notes, security/privacy implications, AI implications, test expectations, dependencies, exclusions, and definition of done.
- Create explicit issues for data migrations, model/prompt evaluation, accessibility, operational readiness, and documentation when they are material deliverables.
- Do not use an issue title or label as a substitute for acceptance criteria.

## Implementation Gate

- Read the linked use case, issue, nearby code, and [.NET application instructions](./dotnet-app-instructions.md) before editing.
- State the local behavior hypothesis and cheapest falsifying check before the first code edit.
- After the first substantive edit, run the narrowest relevant executable validation before widening scope.
- Keep domain facts, deterministic policy, model inference, and human decisions distinct in code and data.
- Update contracts, migrations, configuration, telemetry, documentation, and rollback behavior when the change requires them.

## Verification Gate

- Derive tests from acceptance criteria, trust boundaries, failure modes, and risk, not from implementation lines alone.
- Cover expected, boundary, invalid, unauthorized, concurrency, cancellation, dependency-failure, redaction, audit, and recovery behavior where applicable.
- Unit tests must be deterministic, isolated, readable, and free of live cloud/model dependencies.
- Integration and contract tests must use approved non-production resources or controlled substitutes and must clean up created data.
- AI changes require representative evaluations, regression thresholds, safety/adversarial checks, and recorded model/prompt/retrieval versions.
- Never claim a test passed unless it was executed and its result observed.

## Pull Request Gate

- Keep each pull request focused on linked issues. Explain deviations and follow-up work explicitly.
- Include evidence for build, tests, analyzers, security/privacy review, accessibility, AI evaluation, migration/deployment, observability, and rollback as applicable.
- Require additional authorized review for changes involving sensitive data, authorization, audit, prompts/tools, models, thresholds, financial effects, referrals, holds, or other consequential actions.
- Block merge for unresolved critical/high security findings, failed required checks, missing human-review controls, or unapproved compliance exceptions.

## Release Gate

- Confirm immutable artifact identity, approved configuration, environment separation, migration ordering, feature flags, monitoring, alert ownership, rollback criteria, backup/recovery, runbooks, and support ownership.
- Verify that approvals and evidence belong to the exact artifact and configuration being released.
- Record known limitations and residual risks. Do not convert a conditional approval into an unconditional release claim.