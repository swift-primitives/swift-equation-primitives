#if swift(<6.4)
    // Equation.Protocol+Swift.Span.swift
    // Conditional conformance for Span — element-wise equality.

    extension Span: Equation.`Protocol` where Element: Equation.`Protocol` & ~Copyable {
        /// Returns whether two spans are equal.
        ///
        /// Two spans are equal if they have the same count and all corresponding
        /// elements compare equal — element-wise, like `Array`. Each pair is compared
        /// via the `borrowing` `==`, so this supports `~Copyable` elements and never
        /// copies an element out of the span.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true` if `lhs` is element-wise equal to `rhs`.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            guard lhs.count == rhs.count else { return false }
            var index = 0
            while index < lhs.count {
                if !(lhs[index] == rhs[index]) { return false }
                index += 1
            }
            return true
        }
    }

#else
    // Swift 6.4+: `Equation.Protocol` is a typealias to `Swift.Equatable`. `Swift.Span`
    // is `~Escapable` and is NOT stdlib-`Equatable`, so the institute supplies the
    // conformance — a `@retroactive Swift.Equatable` conformance (the pre-6.4 fork
    // branch above guarded this out, which dropped Span equality on 6.4+).
    extension Span: @retroactive Swift.Equatable where Element: Equation.`Protocol` & ~Copyable {
        /// Returns whether two spans are element-wise equal (same count, all elements equal).
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            guard lhs.count == rhs.count else { return false }
            var index = 0
            while index < lhs.count {
                if !(lhs[index] == rhs[index]) { return false }
                index += 1
            }
            return true
        }
    }

#endif
