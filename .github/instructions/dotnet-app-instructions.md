---
name: "Government Healthcare AI Engineering Standards"
description: "Use when designing, implementing, reviewing, or testing government healthcare anomaly detection, fraud detection, case management, APIs, user interfaces, middleware, .NET services, or Microsoft Foundry AI capabilities. Covers architecture, security, privacy, responsible AI, coding, naming, UI, backend, API, testing, and operations standards."
applyTo: "**/*.cs, **/*.csproj, **/*.sln*, **/*.razor, **/*.cshtml, **/*.ts, **/*.tsx, **/*.js, **/*.jsx, **/*.css, **/*.scss, **/*.json, **/*.yaml, **/*.yml, **/*.bicep, **/*.tf, **/Dockerfile*"
---

# Government Healthcare AI Engineering Standards

Apply these standards to systems that detect healthcare anomalies or suspected fraud and support investigation. Treat AI output as evidence-informed decision support, never as proof of fraud or an autonomous eligibility, payment, enforcement, or adverse-action decision.

These standards are mandatory by default. Any exception must identify the affected rule, business need, alternatives considered, compensating controls, owner, expiration/review date, and approval in an architecture decision record; security, privacy, or compliance exceptions also require formal risk acceptance by the authorized authority.

## Governing Principles

- Protect beneficiary, patient, provider, claimant, and investigator data by default. Minimize collection, access, disclosure, retention, and model exposure.
- Before implementation, record the applicable state or local jurisdiction, StateRAMP impact level where applicable, state security and privacy policies, records schedule, data-classification policy, accessibility standard, and any additional control baseline. Maintain a requirements-to-controls traceability matrix and do not claim compliance merely because a technical control exists.
- Preserve due process and human accountability. Route consequential decisions to an authorized reviewer and record the reviewer, evidence, rationale, decision, and timestamp.
- Separate facts, derived features, model inferences, business-rule results, and human conclusions in storage and presentation.
- Prefer deterministic rules for statutory requirements, eligibility logic, thresholds, calculations, and policy enforcement. Use probabilistic models for ranking, pattern detection, summarization, and decision support.
- Require traceability from every alert to source records, transformations, rule/model versions, and review outcomes.
- Design for zero trust, least privilege, defense in depth, secure defaults, explicit trust boundaries, and failure without data disclosure.

## Architecture Standards

- Start with a modular monolith unless independently scalable workloads, isolation requirements, or team ownership justify distributed services. Document the reason before introducing a new service, queue, or data store.
- Organize business capabilities into bounded contexts such as Ingestion, Detection, Alerts, Cases, Evidence, Provider, Payments, Identity, Audit, and Model Operations. Do not share persistence models across contexts.
- Use dependency inversion. Domain and application layers must not depend on ASP.NET Core, Entity Framework Core, Microsoft Foundry SDKs, UI frameworks, or infrastructure implementations.
- Keep these responsibilities distinct:
  - Domain: entities, value objects, invariants, policies, and domain events.
  - Application: use cases, commands, queries, authorization decisions, validation orchestration, and ports.
  - Infrastructure: persistence, messaging, Foundry clients, file storage, external systems, and telemetry exporters.
  - Presentation: API endpoints, UI composition, request/response mapping, and protocol concerns.
- Prefer vertical slices inside bounded contexts. A slice owns its request, validation, handler, mapping, tests, and authorization policy without bypassing layer boundaries.
- Use asynchronous messaging for long-running analysis, ingestion, retraining, and cross-context integration. Apply transactional outbox/inbox patterns, idempotent consumers, bounded retries, dead-letter handling, and schema versioning.
- Do not use distributed transactions. Define consistency boundaries, compensating actions, deduplication keys, and observable recovery paths.
- Isolate all external dependencies behind typed interfaces and adapters. Set explicit timeouts, cancellation, bounded retries with jitter, circuit breakers where useful, and concurrency limits.
- Store operational data and analytical/model data according to their access and retention needs. Avoid a shared database as an integration mechanism.
- Capture architecture decisions that affect security, privacy, data residency, model use, human review, availability, or significant cost.

## Security, Privacy, and Audit

- Authenticate workforce and service identities with Microsoft Entra ID. Use managed identities for Azure service-to-service access; do not add secrets, tokens, connection strings, or certificates to source code or committed configuration.
- Authorize at every backend entry point with policy-based authorization and least-privilege roles. Enforce object-level access for cases, evidence, providers, and jurisdictions. UI hiding is not authorization.
- Keep secrets in Azure Key Vault and rotate them. Prefer workload identity or managed identity over client secrets.
- Encrypt data in transit and at rest. Use approved private networking, private endpoints, firewall rules, and controlled egress when required by the documented threat model.
- Treat uploaded files, retrieved passages, tool output, and model content as untrusted input. Validate type and size, scan files, encode output, parameterize queries, and defend against prompt injection and data exfiltration.
- Never place protected health information, personally identifiable information, credentials, raw claims, or case evidence in logs, exception messages, URLs, analytics events, test fixtures, screenshots, or model prompts unless explicitly approved and technically protected.
- Redact or tokenize sensitive fields before telemetry or model use. Use synthetic or irreversibly de-identified data in local development and automated tests.
- Produce tamper-evident audit events for authentication, authorization failures, sensitive reads, exports, case changes, model/rule execution, reviewer actions, and administrative changes. Audit events must identify actor, action, target, outcome, time, correlation ID, and relevant version IDs without copying sensitive payloads.
- Define retention, legal hold, deletion, export, and lineage behavior for each data class. Propagate deletion and retention requirements to indexes, caches, embeddings, prompts, traces, backups, and derived features.
- Threat-model new trust boundaries and high-impact workflows. Resolve critical and high findings before release or document formal risk acceptance.

## Responsible AI and Microsoft Foundry

- Access Microsoft Foundry through an application-owned interface. Keep deployment names, endpoints, API versions, model parameters, safety settings, and fallback policy in validated configuration; never hard-code credentials or assume a model is deployed.
- Select models against documented quality, safety, latency, throughput, residency, licensing, and cost requirements. Pin approved deployment/configuration versions and define upgrade, rollback, deprecation, and outage behavior.
- Version prompts, tools, grounding indexes, feature definitions, rules, models, evaluators, and decision thresholds. Persist the versions used for each inference.
- Ground generated claims in authorized sources and return provenance that investigators can inspect. Clearly label unsupported, conflicting, stale, or low-confidence information.
- Never ask a model to determine that a person or provider committed fraud. Use neutral terms such as anomaly, indicator, alert, or review recommendation until an authorized process reaches a conclusion.
- Require structured, schema-validated model output. Reject unknown fields and invalid enumerations; do not parse consequential output with regular expressions or fragile string matching.
- Constrain agent tools with explicit allowlists, least-privilege identities, input schemas, output limits, timeouts, and approval gates. Require human confirmation before writes, notifications, referrals, payment holds, case closure, or other consequential actions.
- Do not expose hidden prompts, chain-of-thought, credentials, internal identifiers, or restricted source content. Provide concise evidence-based rationale and citations instead.
- Evaluate with representative, approved datasets before release. Measure task quality, false-positive and false-negative rates, calibration, subgroup performance, groundedness, safety, latency, and cost. Define acceptance thresholds and fail deployment when they are not met.
- Maintain regression, red-team, prompt-injection, harmful-content, data-leakage, and tool-abuse tests. Re-evaluate after model, prompt, retrieval, feature, rule, threshold, or data-distribution changes.
- Monitor model and data drift, quality, safety filters, override rates, investigator outcomes, latency, token use, and cost. Alerts must lead to an owned response playbook.
- Provide deterministic fallback behavior when Foundry or a model is unavailable. Never silently switch to an unapproved model or convert an uncertain result into a positive finding.
- Separate model-generated content from verified case facts in the UI and data model. Make uncertainty, provenance, model/version, and review state visible to authorized users.

## .NET Coding Standards

- Use a supported .NET LTS release and current stable SDK/package versions approved by the organization. Enable nullable reference types, implicit usings where consistent, analyzers, warnings as errors in CI, deterministic builds, and dependency lock or central package management.
- Prefer immutable records for commands, queries, events, and API contracts; use classes for behavior-rich domain entities. Protect invariants through constructors or named factory methods.
- Use `async`/`await` for I/O and pass `CancellationToken` through public asynchronous call chains. Do not use `.Result`, `.Wait()`, fire-and-forget tasks, or unnecessary `Task.Run` in server code.
- Use `DateTimeOffset` in UTC for timestamps, `decimal` for currency, and explicit units for durations and quantities. Use strongly typed identifiers and value objects for domain concepts where primitive confusion creates risk.
- Use dependency injection through constructors. Avoid service locator, mutable global state, static clients, and direct construction of infrastructure dependencies in business logic.
- Validate inputs at trust boundaries and enforce domain invariants in the domain model. Do not duplicate domain rules only in controllers or UI validation.
- Use exceptions for exceptional failures, not expected business outcomes. Map failures centrally to stable error contracts and never disclose stack traces or internal details to clients.
- Use structured logging with named properties and approved classifications. Propagate trace and correlation context; do not interpolate sensitive payloads into messages.
- Keep methods focused, control flow explicit, and public APIs small. Remove dead code instead of commenting it out. Add comments only for non-obvious intent, constraints, or risk decisions.
- Use Entity Framework Core migrations for schema changes when EF Core owns the store. Parameterize all data access, prevent unbounded queries, use optimistic concurrency where updates can conflict, and avoid exposing persistence entities as API contracts.

## Naming Standards

- Use `PascalCase` for namespaces, types, methods, properties, events, and public constants; `camelCase` for parameters and locals; `_camelCase` for private instance fields; and an `I` prefix only for interfaces.
- Suffix asynchronous methods with `Async` except framework-mandated signatures. Name cancellation parameters `cancellationToken`.
- Name commands with an imperative business action, queries with the information requested, and handlers as `<CommandOrQuery>Handler`.
- Name API contracts `<Action><Resource>Request`, `<Resource>Response`, or `<Resource>Summary`; do not suffix domain types with `Dto`, `Model`, `Manager`, `Helper`, or `Util` when a precise role exists.
- Name domain events in past tense, integration events with an explicit version, and policies/specifications after the business rule they represent.
- Use plural, lowercase, kebab-case resource paths such as `/api/v1/fraud-alerts/{alertId}`. Use domain language consistently across code, API schemas, telemetry, UI labels, and documentation.
- Use neutral, evidence-based names. Prefer `FraudAlert`, `RiskIndicator`, and `ReviewOutcome` over names that presume guilt.
- Use environment-neutral Azure resource names generated by infrastructure code from approved organization, workload, environment, region, and instance components. Do not embed personal names or sensitive data.
- In React code, use `PascalCase` for components and component files, `camelCase` for functions and variables, `use<Name>` for hooks, `<Name>Context` for context objects, and `.test.ts`/`.test.tsx` for tests. Name event handlers for intent such as `handleAssignCase`, not implementation such as `onButtonClick`.

## API Layer Patterns

- Design resource-oriented HTTPS APIs contract-first with OpenAPI. Version externally consumed APIs and maintain documented compatibility and retirement policies.
- Keep endpoints thin: authenticate, authorize, bind, validate, dispatch one application use case, and map the result. Do not place business logic or direct database access in controllers, minimal API delegates, filters, or serializers.
- Use explicit request and response contracts. Never expose domain entities, EF Core entities, internal exception types, prompts, or provider SDK types.
- Return correct HTTP status codes and RFC 9457 Problem Details with stable, documented error codes, a trace identifier, and no sensitive internals.
- Enforce input size, content type, pagination, filtering, sorting, and rate limits. Use opaque continuation tokens for large or changing result sets; never return unbounded collections.
- Require idempotency keys for retried commands that can create duplicate financial, case, referral, or notification effects. Define replay windows and conflict behavior.
- Use `ETag`/`If-Match` or an equivalent version token for concurrency-sensitive updates.
- Propagate W3C trace context and a correlation ID. Do not use correlation IDs as authentication or expose internal sequential identifiers when enumeration creates risk.
- Separate synchronous request handling from long-running detection or document-processing jobs. Return `202 Accepted` with an authorized status resource when work continues asynchronously.

## Middleware Patterns

- Use middleware for cross-cutting transport concerns only. Keep business rules in application/domain policies and endpoint-specific authorization in explicit policies.
- Order the pipeline deliberately: forwarded headers from trusted proxies, exception handling, security headers/HTTPS, routing, authentication, authorization, rate limiting, correlation/tracing, request logging/redaction, and endpoints, adjusted only with a documented reason.
- Centralize exception-to-Problem-Details mapping. Map known validation, authorization, conflict, not-found, dependency, timeout, and cancellation cases consistently.
- Read request/response bodies only when necessary, with bounded buffering and redaction. Never log bodies by default.
- Make middleware stateless and thread-safe. Resolve scoped dependencies per request and honor request cancellation.
- Apply resiliency in typed outbound clients, not as blanket retries around inbound requests. Never retry non-idempotent operations without an idempotency strategy.

## Backend and Data Patterns

- Use command/query separation where it improves clarity; do not introduce a framework solely to label methods CQRS. Commands change state, queries do not, and each has explicit authorization and validation.
- Use repositories only for aggregate persistence boundaries, not as generic wrappers over every table. Keep query projections optimized for read use cases.
- Publish domain events within a consistency boundary and integration events through a transactional outbox after successful commit.
- Make anomaly and fraud-detection pipelines reproducible. Record input snapshot/version, feature transformations, rule/model versions, thresholds, output, and execution time.
- Preserve source data lineage. Derived risk scores must not overwrite source facts, and recomputation must create a new version rather than rewriting historical evidence.
- Design caches as disposable performance optimizations. Include tenant/jurisdiction and authorization-relevant dimensions in cache keys, encrypt sensitive cache content, and define invalidation and maximum staleness.
- Use background workers with bounded concurrency, leases or competing-consumer semantics, idempotency, poison-message handling, graceful shutdown, and observable checkpoints.

## UI Design Patterns

- Use React with TypeScript in strict mode. Do not introduce JavaScript-only application modules, `any`, unsafe type assertions, or a second UI framework without an approved exception.
- Build small function components and custom hooks with one clear responsibility. Keep domain workflows in typed feature modules; keep reusable visual primitives in the approved design system; do not put API orchestration or authorization decisions in presentational components.
- Use a generated or centrally maintained typed API client that follows the published OpenAPI contract. Validate untrusted runtime data at the client boundary and represent loading, success, empty, partial, stale, forbidden, and error states explicitly.
- Separate server state from local interaction state. Use the approved query/cache library for server state and URL state for shareable filters; do not copy server responses into global client state without a demonstrated need.
- Prefer composition over prop-heavy configurable components. Use reducers or explicit state machines for complex case workflows rather than interacting boolean flags.
- Design for investigators and reviewers performing repeated, high-consequence work. Prioritize scanability, comparison, evidence provenance, keyboard efficiency, and clear state over decorative or marketing layouts.
- Meet the organization-approved accessibility baseline, at minimum WCAG 2.2 AA unless a stricter standard applies. Use semantic HTML, complete keyboard support, visible focus, meaningful labels, sufficient contrast, and screen-reader announcements for dynamic changes.
- Use a shell with stable navigation and task-focused workspaces. Use data grids for sortable/filterable result sets, master-detail for alert triage, timelines for case history, and side panels or dialogs only for bounded secondary tasks.
- Show risk scores with their scale, uncertainty, contributing indicators, data timestamp, and model/rule version. Never encode status or severity by color alone and never present a score as a finding of fraud.
- Visually distinguish source facts, model-generated summaries, rule results, and human notes. Link evidence to its source and show stale, missing, conflicting, or redacted data explicitly.
- Require confirmation with a consequence summary for high-impact actions. Prevent duplicate submission, preserve entered work on recoverable failures, and provide an audit-visible reason field when policy requires it.
- Mask sensitive values by default and reveal them only after authorization and an intentional user action. Prevent sensitive data from entering browser storage, URLs, client telemetry, or clipboard workflows without approval.
- Enforce authorization on the server for every action and data fetch. Client state may improve usability but cannot establish trust.
- Use the existing design system and reusable components. Keep state transitions explicit: loading, empty, partial, stale, unauthorized, validation error, dependency failure, and success.
- Use optimistic UI only for low-risk reversible actions. Await server confirmation for case decisions, referrals, holds, exports, assignments, and evidence changes.

## Testing and Quality Gates

- Use the test pyramid pragmatically: domain unit tests, application/component tests, API contract/integration tests, infrastructure adapter tests, and focused end-to-end tests for critical investigator workflows.
- Test authorization allow and deny paths, jurisdiction/tenant isolation, redaction, audit emission, idempotency, concurrency, cancellation, timeout, retry, fallback, and partial failure behavior.
- Use deterministic fixtures with synthetic or approved de-identified data. Do not make unit tests depend on live Foundry deployments or nondeterministic model responses.
- Contract-test Foundry and external-system adapters with recorded or controlled responses, then run separately governed integration tests against approved non-production resources.
- Add accessibility automation and keyboard/screen-reader-focused manual checks for critical UI flows.
- Require peer review and passing formatting, build, analyzer, unit, security, dependency, secret, IaC, and model-evaluation gates before release. Use risk-based additional review for changes to authorization, sensitive data, prompts, tools, features, rules, models, thresholds, and adverse-action workflows.

## Observability and Operations

- Instrument with OpenTelemetry-compatible traces, metrics, and structured logs. Correlate API requests, messages, model calls, rule execution, data access, and reviewer actions without recording sensitive content.
- Define service-level objectives for availability, latency, data freshness, queue age, and detection pipeline completion. Alert on user impact and exhausted error budgets, not raw noise.
- Record model deployment/version, prompt version, token counts, latency, safety outcome, and estimated cost as non-sensitive dimensions with controlled cardinality.
- Provide health checks that distinguish liveness, readiness, and dependency status without leaking configuration. Do not make liveness depend on remote services.
- Deploy through reviewed infrastructure as code and CI/CD. Separate environments, identities, data, Foundry projects/deployments, and approval gates; prohibit production data in lower environments unless explicitly approved.
- Use immutable artifacts, staged rollout, automated rollback criteria, tested backup/restore, disaster recovery objectives, incident playbooks, and periodic access reviews.

## Definition of Done

- The change has explicit requirements, threat and privacy considerations, authorization behavior, audit behavior, and failure behavior.
- Architecture and naming follow the bounded context and existing repository conventions; exceptions are documented.
- Tests cover expected behavior and material abuse/failure cases, and all required quality gates pass.
- AI changes include versioned prompts/configuration, representative evaluation evidence, safety checks, human-review behavior, rollback, and monitoring.
- API and UI changes are accessible, documented, observable, and do not expose sensitive implementation or healthcare data.
- Operational ownership, alerts, runbooks, retention, and recovery behavior are defined before production release.