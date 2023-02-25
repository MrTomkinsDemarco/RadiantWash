//
//  FontManager+ModalSettings.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

enum ModalSettingsFontType {
  case mainTitle
  case title
  case subTitle
  case butttons
  case switchButtons
}

extension FontManager {
  
  struct ModalSettings {
    
    static var mainTitleFont: UIFont {
      return DefaultFonts.navigationTitleFont
    }
    
    static var titleFont: UIFont {
      switch Screen.size {
      case .small:
        return .systemFont(ofSize: 10, weight: .semibold)
      default:
        return .systemFont(ofSize: 12, weight: .semibold)
      }
    }
    
    static var subTitleFont: UIFont {
      switch Screen.size {
      case .small:
        return .systemFont(ofSize: 8, weight: .medium)
      default:
        return .systemFont(ofSize: 10, weight: .medium)
      }
    }
    
    static var buttonsFont: UIFont {
      switch Screen.size {
      case .small:
        return .systemFont(ofSize: 10, weight: .semibold)
      default:
        return .systemFont(ofSize: 12, weight: .semibold)
      }
    }
    
    static var switchButtonsFont: UIFont {
      switch Screen.size {
      case .small:
        return .systemFont(ofSize: 9, weight: .medium)
      default:
        return .systemFont(ofSize: 10, weight: .medium)
      }
    }
  }
}
