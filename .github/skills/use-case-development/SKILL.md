---
name: use-case-development
description: "Create, refine, review, or approve government healthcare anomaly and fraud-detection use cases. Use for requirements discovery, user scenarios, acceptance criteria, data classification, responsible AI, human review, accessibility, and use-case readiness."
argument-hint: "Describe the business problem, actors, desired outcome, and known constraints."
---

# Use Case Development

## Inputs

- Business problem and measurable outcome
- Actors, jurisdictions, policies, source systems, and known constraints
- Existing requirements, decisions, research, and related use cases

## Procedure

1. Search for related use cases and choose the next stable `UC-###` without renumbering existing identifiers.
2. Separate confirmed facts from assumptions and open questions. Ask the accountable owner about unresolved decisions that change scope, controls, or outcomes.
3. Draft from [the use-case template](../../../docs/templates/use-case.md).
4. Define actors, authorization, trigger, preconditions, main flow, alternate/error flows, postconditions, and deterministic business rules.
5. Document minimum necessary data, classification, jurisdiction/control baseline, lineage, retention, audit, privacy, accessibility, and operational needs.
6. For AI behavior, define purpose, grounding, prohibited inputs/actions, uncertainty/provenance, human review, evaluation thresholds, safety, fallback, monitoring, and rollback.
7. Write stable `AC-###` criteria as observable outcomes. Cover success, denial, invalid input, unavailable dependencies, stale/partial data, and consequential-action safeguards where relevant.
8. Review for neutral language, testability, internal consistency, feasibility, and absence of sensitive example data.

## Exit Gate

- The product owner and required domain/control reviewers are identified.
- No blocking question is hidden as an assumption.
- Every acceptance criterion is observable and testable.
- Out-of-scope behavior and consequential actions are explicit.
- The artifact status remains `Draft` or `In Review` until an authorized person approves it; never fabricate approval.

## Output

Save the use case under `docs/use-cases/UC-###-short-title.md` and summarize open decisions and readiness.