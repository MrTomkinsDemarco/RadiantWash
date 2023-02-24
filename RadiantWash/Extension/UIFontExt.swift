//
//  UIFontExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UIFont {
  
  var monospacedDigitFont: UIFont {
    
    let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
    let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
    let oldFontDescriptor = fontDescriptor
    let newFontDescriptor = oldFontDescriptor.addingAttributes(fontDescriptorAttributes)

    return UIFont(descriptor: newFontDescriptor, size: 0)
  }
  
  class func italicSystemFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular)-> UIFont {
    
      let font = UIFont.systemFont(ofSize: size, weight: weight)
      switch weight {
      case .ultraLight, .light, .thin, .regular:
          return font.withTraits(.traitItalic, ofSize: size)
      case .medium, .semibold, .bold, .heavy, .black:
          return font.withTraits(.traitBold, .traitItalic, ofSize: size)
      default:
          return UIFont.italicSystemFont(ofSize: size)
      }
   }
  
   func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., ofSize size: CGFloat) -> UIFont {
     
      let descriptor = self.fontDescriptor
          .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
      return UIFont(descriptor: descriptor!, size: size)
   }
}
