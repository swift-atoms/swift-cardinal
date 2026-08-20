// Cardinal+Comparison.Protocol.swift
// Conformance of Cardinal to Comparison.Protocol — unconditional.
//
// `Comparison.Protocol` aliases `Swift.Comparable`; this conformance therefore
// supplies the standard-library conformance directly.

public import Cardinal_Primitive
public import Comparison_Primitives

extension Cardinal: Comparison.`Protocol` {}
