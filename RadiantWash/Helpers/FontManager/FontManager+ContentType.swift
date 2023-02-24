//
//  FontManager+ContentType.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

enum ContentFontType {
  case title
  case subtitle
}

extension FontManager {
  
  struct ContentTypeCell {
    
    static var titleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .bold).monospacedDigitFont
      case .medium, .plus, .large:
        return .systemFont(ofSize: 16, weight: .bold).monospacedDigitFont
      case .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 18, weight: .bold).monospacedDigitFont
      }
    }
    
    static var subTitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 12, weight: .medium).monospacedDigitFont
      case .medium, .plus, .large:
        return .systemFont(ofSize: 13, weight: .medium).monospacedDigitFont
      case .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 14, weight: .medium).monospacedDigitFont
      }
    }
  }
}
