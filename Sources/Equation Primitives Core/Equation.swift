// Equation.swift
// Namespace for equality primitives.

/// Namespace for equality-related types and protocols.
///
/// `Equation` provides protocols and utilities for comparing values for equality,
/// with full support for `~Copyable` types through `borrowing` semantics.
///
/// ## Key Types
///
/// - ``Equation/Protocol``: An equality protocol supporting `~Copyable` types.
///
/// ## Example
///
/// ```swift
/// struct Token: ~Copyable, Equation.Protocol {
///     let id: Int
///
///     static func == (lhs: borrowing Token, rhs: borrowing Token) -> Bool {
///         lhs.id == rhs.id
///     }
/// }
/// ```
///
/// ## Relationship to Swift.Equatable
///
/// `Equation.Protocol` mirrors `Swift.Equatable` but uses `borrowing` parameters
/// to enable equality comparison of move-only types without consuming them.
/// Types conforming to `Swift.Equatable` can conform to `Equation.Protocol`
/// with empty conformance bodies.
public enum Equation: Sendable {}
