// Equation.Protocol+Swift.UnsafeMutableRawPointer.swift
// Conformance for UnsafeMutableRawPointer.

extension UnsafeMutableRawPointer: Equation.`Protocol` {
    /// Returns whether two mutable raw pointers point to the same address.
    ///
    /// - Note: Uses `copy` to copy the borrowed pointer values, then compares
    ///   via `Int(bitPattern:)` to avoid infinite recursion.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` points to the same address as `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = unsafe copy lhs
        let rhsCopy = unsafe copy rhs
        return Int(bitPattern: lhsCopy) == Int(bitPattern: rhsCopy)
    }
}
