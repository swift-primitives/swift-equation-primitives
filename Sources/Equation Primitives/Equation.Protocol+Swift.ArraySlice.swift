// Equation.Protocol+Swift.ArraySlice.swift
// Conditional conformance for ArraySlice.

extension ArraySlice: Equation.`Protocol` where Element: Equation.`Protocol` {
    /// Returns whether two array slices are equal.
    ///
    /// Two slices are equal if they have the same count and all corresponding
    /// elements are equal.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for (l, r) in zip(lhs, rhs) {
            if !(l == r) { return false }
        }
        return true
    }
}
