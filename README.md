# Equation Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-primitives/swift-equation-primitives/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-primitives/swift-equation-primitives/actions/workflows/ci.yml)

`Equation.Protocol` — equality with `borrowing` parameters, so `~Copyable` types can compare for equality without being copied. Mirrors `Swift.Equatable` and, on Swift 6.4 and later, *is* `Swift.Equatable` via a namespace typealias once [SE-0499](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0499-support-non-copyable-simple-protocols.md) lands at your floor.

Use `Equation.Protocol` for equality-only conformance. For ordering, see [`swift-comparison-primitives`](https://github.com/swift-primitives/swift-comparison-primitives); for hashing, see [`swift-hash-primitives`](https://github.com/swift-primitives/swift-hash-primitives) — both refine `Equation.Protocol`.

---

## Key Features

- **Move-only equality** — `static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool` lets `~Copyable` types compare equal without being consumed.
- **SE-0499 dual-mode** — Under Swift <6.4, the package ships its own protocol fork. Under Swift 6.4+, the protocol is a typealias to `Swift.Equatable`. Conformances written today work on both compiler families.
- **Stdlib bridges included** — Standard Library Integration target re-conforms common stdlib types (`Int`, `String`, `[T]`, `Optional`, `Range`, …) under Swift <6.4, so Swift `Equatable` types are also `Equation.Protocol` types with no per-call-site work.
- **Default `!=`** — Implement `==`; `!=` comes from the protocol's default extension.

---

## Quick Start

A move-only token type conforms in two lines:

```swift
import Equation_Primitives

struct Token: ~Copyable {
    let id: Int
}

extension Token: Equation.`Protocol` {
    static func == (lhs: borrowing Token, rhs: borrowing Token) -> Bool {
        lhs.id == rhs.id
    }
}

let a = Token(id: 1)
let b = Token(id: 1)
let c = Token(id: 2)

let equal: Bool = a == b      // true
let notEqual: Bool = a != c   // true (default impl from the protocol)
```

A `Copyable` type that already conforms to `Swift.Equatable` conforms with an empty extension — the existing `==` satisfies the requirement:

```swift
struct UserID: Equatable, Equation.`Protocol` {
    let value: UInt64
}
// no body required — Swift.Equatable's `==` satisfies the requirement
```

---

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-equation-primitives.git", branch: "main")
]
```

Add the umbrella product to your target (re-exports the protocol and the stdlib bridges):

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Equation Primitives", package: "swift-equation-primitives")
    ]
)
```

For narrower surface, depend on `Equation Primitives Core` alone (protocol only, no stdlib bridges).

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the corresponding Linux / Windows toolchain).

---

## Architecture

Three library products plus a Test Support target:

| Product | Contents | When to import |
|---------|----------|----------------|
| `Equation Primitives` | Umbrella — re-exports Core + Standard Library Integration | Most consumers |
| `Equation Primitives Core` | `Equation` namespace + `Equation.Protocol` | Embedded contexts, or when stdlib bridges are unwanted |
| `Equation Primitives Standard Library Integration` | Re-conformance of stdlib types under Swift <6.4 | Pulled in transitively by the umbrella |
| `Equation Primitives Test Support` | Re-export of `Tagged Primitives Test Support` | Test target only |

The `Standard Library Integration` target's bridges are gated behind `#if swift(<6.4)`. Under Swift 6.4 and later, stdlib types already conform to `Swift.Equatable` (which `Equation.Protocol` typealiases to) and the bridges become no-ops.

---

## Stability

Pre-1.0. The protocol surface is intentionally small: one method (`==`), one default (`!=`), one namespace (`Equation`). The expected long-term shape is full retirement of the namespace once the ecosystem's minimum Swift version reaches 6.4 stable, at which point consumers use `Swift.Equatable` directly. The `0.1.0` tag commits to source compatibility for the dual-mode bridge until that retirement is staged.

---

## Platform Support

| Platform         | CI  | Status       |
|------------------|-----|--------------|
| macOS 26         | Yes | Full support |
| Linux            | Yes | Full support |
| Windows          | Yes | Full support |
| iOS/tvOS/watchOS | —   | Supported    |
| Swift Embedded   | —   | Supported    |

---

## Related Packages

- [`swift-comparison-primitives`](https://github.com/swift-primitives/swift-comparison-primitives) — three-way comparison + `Comparison.Protocol` (refines `Equation.Protocol`).
- [`swift-hash-primitives`](https://github.com/swift-primitives/swift-hash-primitives) — typed hash output + `Hash.Protocol` (refines `Equation.Protocol`).
- [`swift-tagged-primitives`](https://github.com/swift-primitives/swift-tagged-primitives) — phantom-typed value wrappers; `Tagged` conditionally conforms to `Equation.Protocol`.
- [`swift-property-primitives`](https://github.com/swift-primitives/swift-property-primitives) — fluent accessor namespaces.

---

## Community

<!-- BEGIN: discussion -->
Discuss this package: [swift-institute/discussions/17](https://github.com/orgs/swift-institute/discussions/17)
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
