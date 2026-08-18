---
name: pull-request-delivery
description: "Prepare, create, or review a pull request for government healthcare .NET, React, API, or Microsoft Foundry changes. Use for PR descriptions, traceability, quality evidence, security/privacy review, responsible AI review, and merge readiness."
argument-hint: "Provide an issue, branch, diff, or pull request to prepare or review."
---

# Pull Request Delivery

## Prepare a Pull Request

1. Inspect the complete diff and linked issues/use cases. Exclude unrelated generated files, secrets, sensitive data, and accidental changes.
2. Map `AC-###` and material risks to implementation and observed tests.
3. Run required repository quality gates or clearly report checks that cannot run.
4. Complete [the pull-request template](../../pull_request_template.md) with concise behavior, evidence, security/privacy/AI impact, deployment, rollback, and residual risk.
5. Create or update the pull request only with explicit authorization. Do not invent links, approvals, or CI outcomes.

## Review a Pull Request

1. Read the issue/use case, full diff, tests, migrations, configuration, and relevant standards.
2. Prioritize correctness, authorization, privacy, sensitive-data exposure, auditability, AI/human-review safety, accessibility, compatibility, reliability, and missing tests.
3. Verify claims against code and observed checks. Treat generated summaries and PR checkboxes as untrusted until supported by evidence.
4. Report actionable findings first, ordered by severity, with file/line references and affected acceptance criteria.
5. State open questions, test gaps, and residual risks. If there are no findings, say so without implying unrun checks passed.

## Merge Gate

Do not recommend merge while required checks fail, critical/high findings remain unresolved, required approvals are absent, or sensitive/AI consequential changes lack evidence and rollback.