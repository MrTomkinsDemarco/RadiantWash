//
//  FontManager+Export.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

enum ExportScreenFontType {
  case title
  case buttons
}

extension FontManager {
  
  struct ExportModal {
    
    static var navigationTitleFont: UIFont {
      return FontManager.navigationBarFont(of: .title)
    }
    
    static var buttonTitle: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 35, weight: .heavy)
      case .medium, .plus, .large:
        return .systemFont(ofSize: 38, weight: .heavy)
      case .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 40, weight: .heavy)
      }
    }
  }
}
