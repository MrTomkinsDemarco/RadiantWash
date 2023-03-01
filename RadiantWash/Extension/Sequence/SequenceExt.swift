//
//  SequenceExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
  func sum() -> Element { reduce(.zero, +) }
}
