#if swift(<6.4)
    // Equation.Protocol+Identity.Tagged.swift
    // Equation.Protocol conformance for Tagged types.

    public import Tagged_Primitives

    extension Tagged: Equation.`Protocol` where Tag: ~Copyable & ~Escapable, Underlying: ~Copyable & Equation.`Protocol` {
        /// Returns whether the left-hand side tagged value equals the right-hand side.
        ///
        /// Compares the underlying values using `Equation.Protocol` semantics,
        /// enabling equality comparison for `~Copyable` underlying values without consuming them.
        ///
        /// - Note: Uses `@_disfavoredOverload` to prefer `Swift.Equatable` when Underlying
        ///   conforms to both. This ensures Copyable types use the standard library operator.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Tagged, rhs: borrowing Tagged) -> Bool {
            lhs.underlying == rhs.underlying
        }
    }

#endif
