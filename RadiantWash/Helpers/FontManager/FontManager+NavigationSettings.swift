//
//  FontManager+NavigationSettings.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

enum NavigationBarFontType {
  case title
  case barButtonTitle
}

extension FontManager {
  
  struct NavigationSettings {
    
    static var navigationTitleFont: UIFont {
      return DefaultFonts.navigationTitleFont
    }
    
    static var navigationBarButtonTitle: UIFont {
      return DefaultFonts.navigationBarButtonItemFont
    }
  }
}
