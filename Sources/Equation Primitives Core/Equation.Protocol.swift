// Equation.Protocol.swift
// An Equatable fork with ~Copyable support.

extension Equation {
    /// A protocol for types that can be compared for equality, supporting both
    /// `Copyable` and `~Copyable` types.
    ///
    /// This protocol mirrors `Swift.Equatable` but uses `borrowing` parameters
    /// to enable equality comparison of move-only types without consuming them.
    ///
    /// ## Conforming to Protocol
    ///
    /// Types conforming to `Equation.Protocol` must implement `==`:
    ///
    /// ```swift
    /// struct Token: ~Copyable {
    ///     let id: Int
    /// }
    ///
    /// extension Token: Equation.Protocol {
    ///     static func == (lhs: borrowing Token, rhs: borrowing Token) -> Bool {
    ///         lhs.id == rhs.id
    ///     }
    /// }
    /// ```
    ///
    /// ## Semantic Requirements
    ///
    /// Conforming types must satisfy the equivalence relation properties:
    ///
    /// - **Reflexive**: `a == a` is always `true`
    /// - **Symmetric**: `a == b` implies `b == a`
    /// - **Transitive**: `a == b` and `b == c` implies `a == c`
    ///
    /// Two values that compare equal should be substitutable in most contexts.
    ///
    /// ## Relationship to Swift.Equatable
    ///
    /// Types conforming to `Swift.Equatable` can also conform to `Equation.Protocol`
    /// with minimal additional implementation. The key difference is that
    /// `Equation.Protocol` supports move-only types through `borrowing` semantics.
    public protocol `Protocol`: ~Copyable {
        /// Returns whether the left-hand side is equal to the right-hand side.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true` if `lhs` is equal to `rhs`.
        static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool
    }
}

// MARK: - Default Implementations

extension Equation.`Protocol` where Self: ~Copyable {
    /// Returns whether the left-hand side is not equal to the right-hand side.
    ///
    /// Default implementation returns `!(lhs == rhs)`.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is not equal to `rhs`.
    @_disfavoredOverload
    @inlinable
    public static func != (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        !(lhs == rhs)
    }
}
