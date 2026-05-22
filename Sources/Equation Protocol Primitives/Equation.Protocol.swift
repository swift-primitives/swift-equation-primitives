// Equation.Protocol.swift
// An Equatable fork with ~Copyable support.
//
// SE-0499 (Implemented Swift 6.4) extends Swift.Equatable to natively support
// ~Copyable conformers via borrowing parameters. Under Swift 6.4+, Equation.Protocol
// is a typealias to Swift.Equatable; under Swift <6.4, it remains the fork.
// See: swift-institute/Research/se-0499-implications-for-equation-hash-comparison-primitives.md

public import Equation_Primitive

#if swift(>=6.4)

    extension Equation {
        /// A type that can be compared for value equality, supporting both
        /// `Copyable` and `~Copyable` types.
        ///
        /// Under Swift 6.4+ this is a namespace alias for `Swift.Equatable`, which
        /// natively supports `~Copyable` conformers per SE-0499. The dedicated fork
        /// is only present under Swift <6.4.
        public typealias `Protocol` = Swift.Equatable
    }

#else

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
        public protocol `Protocol`: ~Copyable, ~Escapable {
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

    extension Equation.`Protocol` where Self: ~Copyable & ~Escapable {
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

#endif
