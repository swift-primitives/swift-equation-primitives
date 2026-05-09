#if swift(<6.4)
    // Equation.Protocol+Swift.PartialRange.swift
    // Conditional conformances for partial range types.

    extension PartialRangeFrom: Equation.`Protocol` where Bound: Equation.`Protocol` & Copyable {
        /// Returns whether two partial ranges are equal.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true` if `lhs` is equal to `rhs`.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            lhs.lowerBound == rhs.lowerBound
        }
    }

    extension PartialRangeThrough: Equation.`Protocol` where Bound: Equation.`Protocol` & Copyable {
        /// Returns whether two partial ranges are equal.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true` if `lhs` is equal to `rhs`.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            lhs.upperBound == rhs.upperBound
        }
    }

    extension PartialRangeUpTo: Equation.`Protocol` where Bound: Equation.`Protocol` & Copyable {
        /// Returns whether two partial ranges are equal.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true` if `lhs` is equal to `rhs`.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            lhs.upperBound == rhs.upperBound
        }
    }

#endif
