//
//  SequenceExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

extension Sequence  {
  func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}

extension Sequence where Element: AdditiveArithmetic {
  func sum() -> Element { reduce(.zero, +) }
}
