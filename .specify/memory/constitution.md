<!--
  Sync Impact Report
  ==================
  Version change: (none) → 1.0.0 (initial adoption)
  Principles added:
    - I. Clean Architecture Discipline
    - II. Minimal & Safe Changes
    - III. Performance-Conscious Flutter
    - IV. Security by Default
    - V. Testing Discipline
    - VI. Clean Code & Conventions
    - VII. Principled Dependencies
  Sections added:
    - Technology Stack & Constraints
    - Development Workflow & Quality Gates
    - Governance
  Removed sections: (none)
  Templates requiring updates:
    - .specify/templates/plan-template.md — ✅ compatible (Constitution Check section present)
    - .specify/templates/spec-template.md — ✅ compatible (no principle-specific references)
    - .specify/templates/tasks-template.md — ✅ compatible (phase structure aligns)
    - .specify/templates/checklist-template.md — ✅ compatible (generic structure)
  Follow-up TODOs: none
-->

# Proper Store Constitution

## Core Principles

### I. Clean Architecture Discipline

All code MUST follow strict Clean Architecture layer boundaries:
**presentation → domain → data**.

- Each layer has a single responsibility: presentation renders UI and
  observes state; domain holds business logic and use cases; data
  handles API calls, persistence, and mapping.
- Presentation MUST NOT access repositories or data sources directly.
- Cubits MUST depend only on use cases, never on repositories or data
  sources.
- Domain MUST remain independent of Flutter and UI frameworks.
- Business logic MUST NOT exist in UI widgets.
- Layer-skipping or responsibility mixing is forbidden.

### II. Minimal & Safe Changes

Every change MUST target the root cause, use the smallest possible
diff, and preserve existing behavior.

- Identify and fix the root cause — superficial patches are forbidden.
- Make the smallest change that solves the problem.
- Do not refactor unrelated code unless explicitly requested.
- Do not break existing functionality, APIs, flows, or UX unless
  explicitly instructed.
- Errors MUST propagate cleanly: data → domain → presentation, never
  skipping layers.

### III. Performance-Conscious Flutter

All Flutter code MUST follow performance best practices to maintain
a responsive UI.

- Prefer `const` constructors wherever possible.
- Avoid unnecessary widget rebuilds and heavy work inside `build()`.
- Do not create controllers, focus nodes, or expensive objects inside
  `build()` — use `StatefulWidget` with proper `dispose()`.
- Use `setState` only for local UI state; feature state MUST use
  Cubit/BLoC.
- Prefer efficient widget composition to minimize rebuild scope.
- Use `MediaQuery.sizeOf` over `MediaQuery.of` when only size is
  needed.

### IV. Security by Default

Security MUST be considered in every change.

- Never hardcode secrets, tokens, or credentials.
- Do not log sensitive information.
- Validate and sanitize all external and API data at system
  boundaries.
- Proactively flag potential security risks during implementation
  and review.

### V. Testing Discipline

Tests MUST cover domain logic, data layer operations, and critical
UI flows.

- Write unit tests for domain and data layer logic.
- Write widget tests for critical UI flows.
- Bug fixes MUST include a test that reproduces the issue.
- Tests MUST be deterministic — no flaky or timing-dependent tests.
- One behavior per test case.
- Follow existing test structure and naming conventions.

### VI. Clean Code & Conventions

Code MUST be clean, readable, and follow Dart/Flutter conventions.

- Keep files and functions small and focused.
- Add comments only when the intent is non-obvious.
- Apply SOLID and DRY when beneficial; do not force patterns.
- Follow official Dart naming: `snake_case` files, `PascalCase`
  classes, `camelCase` variables, `_` prefix for private members.
- Import order: dart SDK → Flutter SDK → third-party → project
  packages. Relative imports within a feature, package imports
  across features.
- Reuse existing logic — duplication across features is forbidden.
  Shared code goes in `core/`.
- Never manually edit auto-generated files (`.g.dart`,
  `.freezed.dart`, generated l10n). Modify source files only.

### VII. Principled Dependencies

New packages MUST be justified, latest-stable, well-maintained, and
production-grade.

- Do not add packages unless necessary and justified.
- Every added package MUST be latest stable, actively maintained,
  and trusted.
- Prefer platform/SDK capabilities over third-party alternatives
  when equivalent.

## Technology Stack & Constraints

- **Framework**: Flutter (primary target: Flutter Web)
- **Language**: Dart (modern, null-safe)
- **State Management**: Cubit/BLoC (via `flutter_bloc`)
- **Architecture**: Clean Architecture monorepo —
  `packages/store_app/`, `packages/admin_app/`, `packages/shared/`
- **Backend**: Firebase (Auth, Firestore)
- **DI**: `get_it` + `injectable`
- **Routing**: `go_router`
- **Code Generation**: `freezed`, `json_serializable`,
  `build_runner`, Flutter Intl (l10n)
- **Localization**: Arabic (primary) + English via Flutter Intl
  plugin; ARB source files only
- **Branching**: `main` (production), `develop` (working branch)

## Development Workflow & Quality Gates

- Feature work follows conventional branch naming:
  `feat/`, `fix/`, `refactor/`, `perf/`, `chore/`
- Commits follow conventional commit format with clear, concise
  messages.
- Every PR MUST include a self-review checklist verifying:
  root cause addressed, solution is safe and minimal, no broken
  functionality, architecture respected, no business logic in UI,
  no performance regressions, no security risks.
- Generated files (`.g.dart`, `.freezed.dart`, l10n) MUST be
  regenerated via `build_runner` or Flutter Intl — never hand-edited.
- All changes MUST pass static analysis with zero warnings and zero
  errors before merge.

## Governance

This constitution is the authoritative source of engineering
principles for the Proper Store project. It supersedes ad-hoc
practices and MUST be consulted during planning, implementation,
and review.

- **Amendments**: Any principle change MUST be documented with
  rationale, versioned, and propagated to dependent templates.
- **Versioning**: MAJOR for principle removals/redefinitions, MINOR
  for additions/expansions, PATCH for clarifications/typos.
- **Compliance**: All PRs and reviews MUST verify adherence to these
  principles. Violations MUST be justified in writing or resolved
  before merge.
- **Runtime guidance**: See `CLAUDE.md` at the project root for
  detailed implementation rules that operationalize these principles.

**Version**: 1.0.0 | **Ratified**: 2026-05-19 | **Last Amended**: 2026-05-19
