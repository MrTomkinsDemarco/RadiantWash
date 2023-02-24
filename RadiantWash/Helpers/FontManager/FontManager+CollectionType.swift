//
//  FontManager+CollectionType.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

enum CollectionElementsFontType {
  case title
  case buttons
  case sutitle
}

extension FontManager {
  
  struct CollectionElements {
    
    static var grouppedHeaderTitleFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 10, weight: .bold)
      case .medium, .plus, .large:
        return .systemFont(ofSize: 12, weight: .bold)
      case .modern, .pro, .max, .madMax, .proMax:
        return .systemFont(ofSize: 14, weight: .bold)
      }
    }
    
    static var grouppedHeaderButtonFont: UIFont {
      switch screenSize {
      case .small:
        return .systemFont(ofSize: 10, weight: .bold)
      default:
        return .systemFont(ofSize: 12, weight: .bold)
      }
    }
    
    static func getVideoDurationFontSize(of collectionType: CollectionType) -> UIFont {
      switch collectionType {
      case .grouped:
        return .systemFont(ofSize: 10, weight: .bold)
      case .single:
        return .systemFont(ofSize: 9, weight: .bold)
      case .carousel:
        return .systemFont(ofSize: 8, weight: .bold)
      case .none:
        return .systemFont(ofSize: 10, weight: .bold)
      }
    }
  }
}
