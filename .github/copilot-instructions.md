# Copilot instructions for ModularArchitectureWithServerDriverUI

Short purpose
- Help Copilot sessions quickly understand how to build, test, and navigate this iOS / SwiftPM modular app.

1) Build, test, and lint commands
- Build all Swift packages (from repository root):
  - swift build
- Run all package tests (from a package directory or repository root when packages are present):
  - swift test
- Run a single Swift package test (from the package directory):
  - swift test --filter "<TestCase or testMethodRegex>"
- Xcode (app project) quick checks:
  - List schemes: xcodebuild -project ServerDrivenUI/ServerDrivenUI.xcodeproj -list
  - Build app for simulator: xcodebuild -project ServerDrivenUI/ServerDrivenUI.xcodeproj -scheme <scheme> -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 14' build
  - Run tests (all): xcodebuild test -project ServerDrivenUI/ServerDrivenUI.xcodeproj -scheme <scheme> -destination 'platform=iOS Simulator,name=iPhone 14,OS=17.0'
  - Run a single XCTest: add -only-testing:'<Target>/<TestCase>/<testMethod>' to xcodebuild test (or -only-testing:'<Target>/<TestCase>' for a class)
- Lint: no project-wide SwiftLint or formatter config detected. If making style/format changes, prefer adding a .swiftlint.yml and documenting it in repo.

2) High-level architecture (big picture)
- Purpose: demo of a modular iOS app that composes Server-Driven UI components and a Payment SDK.
- Top-level layout:
  - PaymentSDKModule/ — Swift Package for payment SDK (Package.swift present).
  - ServerDrivenUI/ — Xcode app + multiple Swift packages under ServerDrivenUI/ServerDrivenUI:
    - AppModule/ — App coordinator, dependency wiring, root UI.
    - Core/ — multiple SPM modules: ServerDrivenEngine, ServerDrivenModelsKit, CoreModule (engine + model types used across features).
    - Features/ — feature modules: FeatureHome, FeatureProducts, FeatureVoiceOver. Each feature isolates UI and feature-level logic.
    - SDK/ — local SDK consumers and example integrations (PaymentSDKModule, PaymentSDKWithUIForPaymentSelection).
- Runtime flow: AppModule wires dependencies and uses ServerDrivenEngine to parse ServerDriverResponse.json-like payloads into component trees. Feature modules register or request data via the engine.
- Sample payloads: ProductListSampleResponse.json and ServerDriverResponse.json at repository root are canonical sample inputs for the Server Driven UI.

3) Key conventions and patterns (repo-specific)
- Modularity via Swift Package Manager: internal libraries are implemented as SPM packages (see Package.swift files under Core and PaymentSDKModule). Prefer making cross-module changes by editing the relevant Package target.
- Naming:
  - Modules that implement app features use the prefix `Feature` (e.g., FeatureProducts).
  - Core server-driven artifacts use `ServerDriven*` (ServerDrivenEngine, ServerDrivenModelsKit).
  - SDKs use `PaymentSDK*`.
- Tests:
  - Package tests live under Tests/ or in Xcode test targets. Run package tests with `swift test` inside package folders or use xcodebuild for app tests.
- Schema & compatibility:
  - Server-driven payloads are JSON files at repo root; changes to model structures must update ServerDrivenModelsKit first, then ServerDrivenEngine and features.
- App wiring:
  - AppModule contains coordinator/FeatureNavigator patterns. Avoid changing global wiring without updating AppDependency and AppFeatureNavigator.

4) Files and entry points to inspect when editing
- ServerDrivenUI/ServerDrivenUI/AppModule — start here for app-level navigation and dependency injection.
- Core packages under ServerDrivenUI/ServerDrivenUI/Core — change models/engine here for parsing or component changes.
- PaymentSDKModule/Package.swift and Sources/ — payment SDK code and tests.
- ServerDriverResponse.json and ProductListSampleResponse.json — canonical sample payloads used by the engine and features.

5) Copilot behavior guidance (how to produce helpful edits)
- Prefer minimal, modular changes: update the smallest package that implements the behavior.
- When suggesting code that adjusts model types, also suggest corresponding Package.swift or import updates and tests to validate payload parsing.
- For build/test commands, prefer SPM commands inside package folders and xcodebuild for project-level integration tests; always include the scheme name when producing xcodebuild commands.

If this file already exists, merge additional project-specific notes into the appropriate sections (build commands, architecture, conventions).

---

Would you like configuration suggestions for any MCP servers (e.g., Playwright, device farms) relevant to this project?