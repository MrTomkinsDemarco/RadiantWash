//
//  FontManager+DefaultFonts.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

extension FontManager {
  
  struct DefaultFonts {
    
    static var navigationTitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .bold).monospacedDigitFont
      case .medium:
        return .systemFont(ofSize: 16, weight: .bold).monospacedDigitFont
      default:
        return .systemFont(ofSize: 17, weight: .bold).monospacedDigitFont
      }
    }
    
    static var navigationBarButtonItemFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .medium).monospacedDigitFont
      case .medium:
        return .systemFont(ofSize: 16, weight: .medium).monospacedDigitFont
      default:
        return .systemFont(ofSize: 17, weight: .medium).monospacedDigitFont
      }
    }
  }
}
