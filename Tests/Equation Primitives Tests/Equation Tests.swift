// Equation Tests.swift
// Tests for Equation.Protocol conformance and round-trip behavior.

import Equation_Primitives_Test_Support
import Testing

@Suite("Equation")
struct Test {

    // MARK: - Copyable conformance

    @Suite("Unit")
    struct Unit {
        @Test
        func `Int conforms to Equation.Protocol via Swift.Equatable bridge`() {
            #expect(equationEquals(1, 1))
            #expect(!equationEquals(1, 2))
        }

        @Test
        func `String conforms via Swift.Equatable bridge`() {
            #expect(equationEquals("hello", "hello"))
            #expect(!equationEquals("hello", "world"))
        }

        @Test
        func `default != is the negation of ==`() {
            // The fork branch and the typealias branch both expose !=
            // either via Equation.Protocol's default impl or via Swift.Equatable.
            #expect(notEquals(1, 2))
            #expect(!notEquals(1, 1))
        }
    }

    // MARK: - ~Copyable conformance

    @Suite("Edge Case")
    struct EdgeCase {
        struct Token: ~Copyable, Equation.`Protocol` {
            let id: Int

            static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
                lhs.id == rhs.id
            }
        }

        @Test
        func `~Copyable type conforms with borrowing ==`() {
            let a = Token(id: 1)
            let b = Token(id: 1)
            let equal: Bool = a == b
            #expect(equal == true)
        }

        @Test
        func `~Copyable type produces inequality correctly`() {
            let a = Token(id: 1)
            let b = Token(id: 2)
            let notEqual: Bool = a != b
            #expect(notEqual == true)
        }
    }

    // MARK: - Tagged conformance

    @Suite("Integration")
    struct Integration {
        enum UserTag {}
        typealias UserID = Tagged<UserTag, Int>

        @Test
        func `Tagged values compare via Equation.Protocol`() {
            let a: UserID = 42
            let b: UserID = 42
            let c: UserID = 99
            #expect(a == b)
            #expect(a != c)
        }
    }
}

// MARK: - Helpers

/// Generic helper that exercises Equation.Protocol's `==` requirement.
private func equationEquals<T: Equation.`Protocol`>(_ lhs: T, _ rhs: T) -> Bool {
    lhs == rhs
}

/// Generic helper that exercises Equation.Protocol's `!=` (default or stdlib-provided).
private func notEquals<T: Equation.`Protocol`>(_ lhs: T, _ rhs: T) -> Bool {
    lhs != rhs
}
