//
//  FontManager+Onboarding.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

enum OnboardingFontType {
  case title
  case subtitle
}

extension FontManager {
  
  struct OnboardingFontSize {
    
    static var titleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 20, weight: .semibold)
      case .medium:
        return .systemFont(ofSize: 22, weight: .semibold)
      default:
        return .systemFont(ofSize: 24, weight: .semibold)
      }
    }
    
    static var subtitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .medium)
      case .medium:
        return .systemFont(ofSize: 15, weight: .medium)
      default:
        return .systemFont(ofSize: 16, weight: .medium)
      }
    }
  }
}
