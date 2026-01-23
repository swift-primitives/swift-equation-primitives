// Equation.Protocol+Swift.Dictionary.swift
// Conditional conformance for Dictionary when Key and Value are Copyable.

extension Dictionary: Equation.`Protocol` where Key: Equation.`Protocol` & Copyable, Value: Equation.`Protocol` & Copyable {
    /// Returns whether two dictionaries are equal.
    ///
    /// Two dictionaries are equal if they have the same keys and each key
    /// maps to equal values in both dictionaries.
    ///
    /// - Note: Uses `copy` to enable iteration on borrowed values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        guard lhsCopy.count == rhsCopy.count else { return false }
        for (key, lValue) in lhsCopy {
            guard let rValue = rhsCopy[key] else { return false }
            if !(lValue == rValue) { return false }
        }
        return true
    }
}
