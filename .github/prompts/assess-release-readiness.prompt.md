---
name: "Assess Release Readiness"
description: "Assess a specific artifact and environment against release gates without deploying it."
argument-hint: "Provide artifact/version, environment, and linked PRs/evidence."
agent: "Release Manager"
---

Follow [the release-readiness skill](../skills/release-readiness/SKILL.md). Produce the release-readiness artifact and an evidence-based verdict. Do not infer approvals or perform deployment.