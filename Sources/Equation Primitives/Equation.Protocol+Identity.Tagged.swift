// Equation.Protocol+Identity.Tagged.swift
// Equation.Protocol conformance for Tagged types.

public import Identity_Primitives

extension Tagged: Equation.`Protocol` where Tag: ~Copyable, RawValue: ~Copyable & Equation.`Protocol` {
    /// Returns whether the left-hand side tagged value equals the right-hand side.
    ///
    /// Compares the underlying raw values using `Equation.Protocol` semantics,
    /// enabling equality comparison for `~Copyable` raw values without consuming them.
    ///
    /// - Note: Uses `@_disfavoredOverload` to prefer `Swift.Equatable` when RawValue
    ///   conforms to both. This ensures Copyable types use the standard library operator.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Tagged, rhs: borrowing Tagged) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
