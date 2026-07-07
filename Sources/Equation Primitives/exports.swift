// exports.swift
// Umbrella re-export of the full Equation surface: Namespace + Protocol
// + Tagged + SLI. Per [MOD-005] this target's sole content is `@_exported
// public import` re-exports of the sub-namespace targets. Consumers
// importing Equation_Primitives get the union plus Property_Primitives
// (preserved as a convenience re-export from the pre-migration shape).

@_exported public import Equation_Primitive
@_exported public import Equation_Primitives_Standard_Library_Integration
@_exported public import Equation_Protocol_Primitives
@_exported public import Equation_Tagged_Primitives
@_exported public import Property_Primitives
