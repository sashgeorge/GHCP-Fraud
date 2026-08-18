---
name: issue-decomposition
description: "Create GitHub issues from an approved use case. Use for backlog decomposition, implementation planning, acceptance-criteria mapping, dependencies, security/privacy work, AI evaluation work, test work, and definition of done."
argument-hint: "Provide a use-case path or UC-### identifier to decompose."
---

# Issue Decomposition

## Inputs

- Approved or explicitly authorized use case
- Repository architecture and existing issue conventions
- Known dependencies, delivery constraints, and team ownership

## Procedure

1. Read the complete use case and map all `AC-###`, business rules, risks, open conditions, and nonfunctional requirements.
2. Inspect the nearest existing implementation surfaces before proposing component boundaries.
3. Split work by independently testable outcomes, not by generic technical layers. Keep a vertical slice together when one team can deliver it safely.
4. Create separate issues when migrations, shared contracts, accessibility, AI evaluations, security/privacy controls, operational readiness, or documentation have distinct owners or sequencing.
5. For every issue, use the fields in [the use-case work-item form](../../ISSUE_TEMPLATE/use-case-work-item.yml): outcome, criterion IDs, scope/exclusions, technical approach, sensitive-data and AI impact, dependencies, verification, and definition of done.
6. Build a dependency order and acceptance-criterion coverage matrix. An acceptance criterion may map to multiple issues, but each must have a clear integration owner.
7. Identify assumptions and unresolved decisions. Do not create implementation details that contradict the use case or invent issue numbers before GitHub assigns them.

## Exit Gate

- Every acceptance criterion and material risk maps to owned work and planned verification.
- Each issue is cohesive, reviewable, and independently meaningful.
- Dependencies have no unexplained cycles.
- Cross-cutting security, privacy, accessibility, AI, data, and operations work is not hidden inside a generic issue.

## Output

Create issues only when authorized and GitHub tooling is available. Otherwise return issue-ready Markdown plus the dependency and coverage tables.