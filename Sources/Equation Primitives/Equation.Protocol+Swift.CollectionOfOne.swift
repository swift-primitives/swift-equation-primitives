// Equation.Protocol+Swift.CollectionOfOne.swift
// Conditional conformance for CollectionOfOne.

extension CollectionOfOne: Equation.`Protocol` where Element: Equation.`Protocol` {
    /// Returns whether two single-element collections are equal.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs[lhs.startIndex] == rhs[rhs.startIndex]
    }
}
