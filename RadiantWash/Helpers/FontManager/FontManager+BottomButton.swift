//
//  FontManager+BottomButton.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

enum BottomButtonFontType {
  case title
  case subtitle
}

extension FontManager {
  
  struct BottomButton {
    
    static var bottomBarButtonTitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 14, weight: .bold)
      case .medium:
        return .systemFont(ofSize: 15.8, weight: .bold)
      default:
        return .systemFont(ofSize: 16.8, weight: .bold)
      }
    }
  }
}
