// Equation.Protocol+Swift.Array.swift
// Conditional conformance for Array.

extension Array: Equation.`Protocol` where Element: Equation.`Protocol` {
    /// Returns whether two arrays are equal.
    ///
    /// Two arrays are equal if they have the same count and all corresponding
    /// elements are equal.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for (l, r) in zip(lhs, rhs) {
            if !(l == r) { return false }
        }
        return true
    }
}
