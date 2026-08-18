---
name: "Prepare Pull Request"
description: "Prepare a focused pull-request description with traceability, observed quality evidence, security/privacy/AI impact, deployment, and rollback."
argument-hint: "Provide the branch/diff and linked issues."
agent: ".NET Developer"
---

Follow [the pull-request delivery skill](../skills/pull-request-delivery/SKILL.md). Inspect the complete diff, run required checks where feasible, and populate the repository PR template. Never invent links, approvals, or CI results; create/update the PR only with explicit authorization.