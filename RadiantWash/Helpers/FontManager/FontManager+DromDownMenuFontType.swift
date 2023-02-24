//
//  FontManager+DromDownMenuFontType.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

enum DromDownMenuFontType {
  case title
  case subtitle
}

extension FontManager {
  
  struct DropDownMenu {
    
    static var titleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .regular)
      case .medium:
        return .systemFont(ofSize: 14, weight: .regular)
      case .plus, .large, .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 14, weight: .regular)
      }
    }
    
    static var subtitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 8, weight: .regular)
      case .medium:
        return .systemFont(ofSize: 10, weight: .regular)
      case .plus, .large, .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 12, weight: .regular)
      }
    }
  }
}
