# ``Equation_Primitives``

@Metadata {
    @DisplayName("Equation Primitives")
    @TitleHeading("Swift Primitives")
}

Equality with `borrowing` parameters, so `~Copyable` types can compare for equality without being copied.

## Overview

`Equation.Protocol` is a one-method protocol that mirrors `Swift.Equatable` with a key difference: the `==` requirement takes its parameters as `borrowing Self`, which lets move-only types satisfy it without being consumed.

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
```

The protocol is the root of a small refinement chain — ``Comparison_Primitives`` and ``Hash_Primitives`` both refine `Equation.Protocol`, encoding the ordering-implies-equality (Swift stdlib) and equals/hashCode (Java) contracts at the type level.

## SE-0499 dual-mode

The package's reason for existing is the `borrowing` requirement that the stdlib's `Swift.Equatable` (until SE-0499 lands at the consumer's floor) does not provide. Under Swift <6.4, `Equation.Protocol` is a separate protocol fork. Under Swift 6.4+, the protocol is a typealias to `Swift.Equatable`:

```swift
#if swift(>=6.4)
    extension Equation {
        public typealias `Protocol` = Swift.Equatable
    }
#else
    extension Equation {
        public protocol `Protocol`: ~Copyable {
            static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool
        }
    }
#endif
```

Conformances written today work on both compiler families. The borrowing signature matches what Swift 6.4's `Swift.Equatable` requires; on Swift 6.3 it matches the fork.

## Topics

### Namespace

- ``Equation``

### Standard Library bridges

Under Swift <6.4, stdlib types are re-conformed to `Equation.Protocol` via the `Equation Primitives Standard Library Integration` target. Under Swift 6.4+, those bridges become no-ops because `Equation.Protocol` IS `Swift.Equatable` and stdlib conformances already satisfy it.
