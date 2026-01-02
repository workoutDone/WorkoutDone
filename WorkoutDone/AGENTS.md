0. Overview
This document defines the mandatory development rules for all human and AI agents working on this project.
The goal is to maintain:
Test-protected code
Domain-Driven Design (DDD)
Clear architectural boundaries
Stability across Xcode project regeneration
All agents must treat this document as a contract, not a guideline.

1. Mandatory Development Cycle
All changes must follow this exact workflow:
Define -> Test -> Implement -> Test -> Generate -> Verify
Any deviation invalidates the change.

2. Step 1 -- Define (Problem Definition)
Before implementation, clearly define:
The domain problem being solved
The target layer:
Domain / Application / Presentation
The owner of state changes (Entity / Domain Service / UseCase)
Prohibited
"Implement first, refactor later"
UI-driven domain decisions
Business rules inside ViewModels

3. Step 2 -- Test First (Required)
Core Principles
No feature without tests
Domain behavior must be expressed in tests first
Tests validate behavior, not implementation details
Test Naming
func test_whenCondition_thenExpectedOutcome()
Example:
func test_whenOrderIsCancelled_thenPaymentIsNotCaptured()
Test Rules
Tests must read in domain language
UI / Network / Storage dependencies must be mocked
Domain tests must not depend on Apple frameworks

4. Step 3 -- Implement
Implementation Rules
Write the minimum code required to pass tests
One type, one responsibility
Prefer state and types over conditional branching
Forbidden
No Boolean parameters without semantic meaning
No "helper", "manager", "util" naming
No external mutation of internal state

5. Step 4 -- Run Tests (Mandatory)
All tests must pass.
Cmd + U
or CI:
xcodebuild test
No progression with failing tests
Never comment out tests to proceed

6. Step 5 -- Generate Xcode Project
Xcode project generation is allowed only after tests pass.
Example (Tuist):
tuist generate
After generation:
Clean build
Full test run

7. Architecture Principles (DDD)
Layering
Presentation
  - View / ViewModel

Application
  - UseCase / ApplicationService

Domain
  - Entity
  - ValueObject
  - DomainService
  - Repository (Protocol)

Infrastructure
  - Repository Implementations
Dependency Direction
Presentation -> Application -> Domain

8. Domain Layer Rules (Strict)
The Domain layer is the core asset of this project.
Rules
No UIKit / SwiftUI / Combine / Alamofire imports
No singletons
No persistence or networking knowledge
Fully understandable through tests alone
Entity Rules
Has a unique identity
State changes only via methods
Invalid states are unrepresentable
order.cancel(by: user)
Value Object Rules
Immutable
Validated at creation
Equality by value
Repository Rules
Domain defines protocols only
Implementations live in Infrastructure
Async APIs use async/await

9. Application Layer Rules
Orchestrates domain objects
Defines transaction boundaries
Contains no business rules itself

10. Test Quality Bar
A test is considered good if:
The domain rule is clear by reading the test
It survives refactoring of internals
Failure messages explain the cause

11. Code Review Checklist (Mandatory)
Agents must verify:
Tests were written first
No domain logic in ViewModels
Domain language is used in names
No boolean flags without meaning
Dependency direction is respected

12. AI Agent Rules
AI agents must:
Never write implementation before tests
Explain layer placement decisions
Preserve external behavior during refactors
Explicitly state assumptions when required

13. Definition of Done
A feature is complete only if:
Tests exist and pass
Xcode generation succeeds
Domain boundaries are intact
Intent is clear from tests alone

14. Guiding Principle
UI can be replaced.
Domain endures.
Tests prove it.
