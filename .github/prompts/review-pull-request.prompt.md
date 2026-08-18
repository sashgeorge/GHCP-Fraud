---
name: "Review Pull Request"
description: "Perform an independent risk-focused pull-request review with actionable findings and merge-readiness assessment."
argument-hint: "Provide the PR, branch, diff, or changed files."
agent: "Pull Request Reviewer"
---

Follow [the pull-request delivery skill](../skills/pull-request-delivery/SKILL.md). Review linked requirements, the full diff, tests, migrations, and configuration. Lead with findings ordered by severity and do not edit or approve the pull request.