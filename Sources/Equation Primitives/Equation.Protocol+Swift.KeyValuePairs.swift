// Equation.Protocol+Swift.KeyValuePairs.swift
// Conditional conformance for KeyValuePairs.

extension KeyValuePairs: Equation.`Protocol` where Key: Equation.`Protocol` & Copyable, Value: Equation.`Protocol` & Copyable {
    /// Returns whether two key-value pairs collections are equal.
    ///
    /// Two KeyValuePairs are equal if they have the same count and all
    /// corresponding key-value pairs are equal in order.
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
            if !(l.key == r.key) || !(l.value == r.value) { return false }
        }
        return true
    }
}
