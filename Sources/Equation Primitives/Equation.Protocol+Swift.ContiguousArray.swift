// Equation.Protocol+Swift.ContiguousArray.swift
// Conditional conformance for ContiguousArray.

extension ContiguousArray: Equation.`Protocol` where Element: Equation.`Protocol` {
    /// Returns whether two contiguous arrays are equal.
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
