---
name: release-readiness
description: "Assess and document release readiness after pull-request approval. Use for deployment gates, artifact/configuration identity, migrations, feature flags, monitoring, runbooks, backup/recovery, rollback, approvals, and residual risk."
argument-hint: "Provide the release version/artifact, target environment, and linked pull requests."
---

# Release Readiness

## Procedure

1. Start from [the release-readiness template](../../../docs/templates/release-readiness.md).
2. Identify the immutable artifact, exact configuration, environment, change window, owner, and included pull requests/issues.
3. Verify requirement traceability and observed build, test, analyzer, security/privacy, accessibility, and AI evaluation evidence for that exact artifact.
4. Review infrastructure/configuration diffs, identity/RBAC, secrets, network controls, migrations, compatibility order, feature flags, data retention, and environment separation.
5. Confirm telemetry, dashboards, alert thresholds, alert owners, runbooks, support handoff, smoke checks, monitoring window, and incident/escalation paths.
6. Define automated/manual rollback criteria, procedure, data/schema recovery, and recovery objectives. Test rollback or record why a controlled rehearsal is not possible.
7. Record known limitations, residual risks, conditional approvals, and expiration dates. Never infer approval from a successful build.

## Constraints

- Assessment does not authorize deployment. Deploy only after explicit authorization through the approved process.
- Do not expose credentials, sensitive data, internal security details, or case evidence in the artifact.

## Exit Gate

Return `Ready`, `Conditionally Ready`, or `Not Ready` with evidence, unmet gates, owners, and conditions. Only authorized people may provide formal approval.