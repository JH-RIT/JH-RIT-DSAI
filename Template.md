# Project Template Guidelines

## Project File Standards

At the top of each source file where language conventions support comments, include a short file header. Do not force headers into generated files, JSON/YAML configuration files, lockfiles, notebooks, or files where headers violate common project or language conventions.

Use the following header format when appropriate:

**Title of File**  
**Created by ptaft1 on YYYY-MM-DD**  
**Project Purpose:** Insert a short summary of the project requirements.  
**File Purpose:** Insert an extremely short summary of this file's responsibility.

## Required Planning Documents

Every project must include the following planning documents at the project root:

- `architecture.md`
- `tasks.md`
- `tests.md`

These files are living project documents. They must be kept current as the project changes.

Any material change to architecture, task scope, dependencies, public interfaces, data models, deployment assumptions, runtime behavior, security posture, or testing strategy must update `architecture.md`, `tasks.md`, and/or `tests.md` in the same change set.

## `architecture.md` Requirements

At the start of every project, create an `architecture.md`. There may or may not be a sample file pasted in, but regardless, every project must have one.

The `architecture.md` must be updated to match the actual implemented components of the project. It is the source of truth for project goals, technical decisions, constraints, and coding guardrails.

Required sections:

1. **Project Purpose**
   - Summarize what the project is intended to accomplish.

2. **Functional Requirements**
   - Describe the user-visible capabilities the system must provide.

3. **Non-Functional Requirements**
   - Capture performance, reliability, scalability, maintainability, accessibility, compatibility, and operational requirements.

4. **Tech Stack**
   - List languages, frameworks, libraries, runtimes, infrastructure, databases, APIs, and major tools.

5. **Architecture Overview**
   - Explain the major components and how they interact.

6. **Data Flow**
   - Describe how data enters, moves through, is transformed by, and exits the system.

7. **API and Interface Contracts**
   - Define public APIs, internal interfaces, event contracts, data schemas, request/response shapes, and integration boundaries.

8. **Security Considerations**
   - Address authentication, authorization, input validation, output encoding, secret handling, dependency risk, least-privilege access, sensitive data handling, and secure logging.

9. **Error Handling Strategy**
   - Define how failures are detected, reported, logged, retried, surfaced to users, and recovered from.

10. **Logging and Observability Strategy**
    - Define logging expectations, metrics, traces, diagnostics, correlation IDs, and rules against logging secrets or sensitive user data.

11. **Testing Strategy**
    - Describe expected unit, integration, end-to-end, regression, security, performance, and edge-case testing where applicable.

12. **Coding Guardrails**
    - Define coding conventions, commenting expectations, naming rules, dependency rules, architectural boundaries, and forbidden patterns.

13. **Project Structure**
    - Document the directory layout and the purpose of important files and folders.

14. **Deployment and Runtime Assumptions**
    - Capture hosting model, environment variables, configuration, deployment process, runtime dependencies, and operational assumptions.

15. **Known Constraints and Tradeoffs**
    - Document intentional limitations, rejected alternatives, unresolved risks, and design tradeoffs.

## `tasks.md` Requirements

The `tasks.md` file must be generated from `architecture.md` at the start of every project.

Each task should be traceable to one or more architectural requirements. Tasks should be small enough to implement and review independently.

Recommended task fields:

- Task ID
- Task title
- Requirement source
- Description
- Acceptance criteria
- Dependencies
- Test coverage required
- Status

## `tests.md` Requirements

The `tests.md` file must be generated from both `architecture.md` and `tasks.md` at the start of every project and must be kept current as the project is updated.

Tests should be derived from `architecture.md` and `tasks.md` before implementation begins. Test cases should describe expected behavior, edge cases, failure modes, and security-relevant scenarios. Implementation should then be written to satisfy those tests.

Recommended test fields:

- Test ID
- Related task ID
- Requirement source
- Test type
- Scenario
- Expected result
- Edge cases covered
- Failure modes covered
- Automation status

## Universal Coding Philosophy

Use specification-driven and test-driven development practices.

Comments should be concise yet descriptive. Comments go at the top of each logical subsection, not inline, unless specifically requested. If an inline comment appears necessary, ask for approval before adding it.

Prefer simple, maintainable code over clever code. Minimize lines of code without sacrificing readability, correctness, security, or testability.

## Security and Reliability Requirements

Security must be considered during design and implementation, not only during final review.

At minimum, review:

- Authentication
- Authorization
- Input validation
- Output encoding
- Secret handling
- Dependency and supply-chain risk
- Logging of sensitive data
- Least-privilege access
- Safe error messages
- Secure defaults

Reliability must be considered during design and implementation.

At minimum, define:

- Expected failure modes
- Retry behavior
- Timeout behavior
- Fallback behavior
- Data consistency expectations
- Recovery expectations
- Operational diagnostics

## Dependency and Supply-Chain Guidelines

External dependencies should be minimized, actively maintained, and justified.

Avoid adding packages for trivial functionality. Prefer standard library or existing project dependencies when they are sufficient.

When dependencies are added or changed:

- Update the relevant project files.
- Commit lockfiles where appropriate.
- Verify license compatibility when relevant.
- Check for known vulnerabilities.
- Document any major dependency-driven architectural decision in `architecture.md`.

Known vulnerable dependencies should be remediated before final review unless explicitly accepted as a documented risk.

## Documentation Synchronization Rules

The planning documents must remain synchronized with the implementation.

Update documentation in the same change set when any of the following changes:

- Requirements
- Features
- Task scope
- Architecture
- Project structure
- Public interfaces
- Data models
- Dependencies
- Environment variables
- Deployment process
- Security assumptions
- Logging or error-handling behavior
- Testing strategy

## Definition of Done

A task is complete only when all applicable items are satisfied:

- The implementation matches the requirement.
- Acceptance criteria are met.
- Required tests are written or updated.
- Tests pass where they can be executed.
- Error handling is appropriate.
- Logging is useful and does not expose secrets or sensitive data.
- Security implications have been reviewed.
- Documentation is updated.
- `architecture.md`, `tasks.md`, and `tests.md` remain consistent.
- Unnecessary code, comments, dependencies, and files are removed.

## AI Code Review Prompts

These prompts can be called at any time by a user prompt.

### Intermediate AI Code Review

Prompt:

You are a deeply experienced, highly critical software engineer. Please conduct a deep and thoughtful code review of the code base you find here. Only the completed tasks listed in `tasks.md` should be reviewed. Ignore future or incomplete tasks unless their design negatively affects completed work. Root the review in `architecture.md` for project goals, tech stack, architecture, requirements, and coding guardrails. Review for correctness, maintainability, testability, security, error handling, logging, dependency quality, specification compliance, and minimal unnecessary code. Call out anything that is not well done or not up to standard. Provide clear recommendations for anything that should be improved, removed, simplified, or cleaned up.

### Final AI Code Review

Prompt:

Please complete a final code review of this project. Be very diligent about software quality, testability, security, specification compliance, good REST practices where applicable, reliability, observability, dependency quality, and minimal lines of code. Call out anything that is not well done or not up to standards. Make sure all `architecture.md` features are implemented and that the documented coding practices were followed. Verify that `architecture.md`, `tasks.md`, and `tests.md` are consistent with the implementation. Provide recommendations for anything that should be improved, removed, simplified, or cleaned up. Ensure there is appropriate logging and error handling throughout, and ensure logs do not expose secrets or sensitive user data. Think long and deeply about this review.