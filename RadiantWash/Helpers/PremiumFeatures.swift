//
//  PremiumFeatures.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

enum PremiumFeature: CaseIterable {
  
  case deepClean
  case multiselect
  case compression
  case location
  
  var title: String {
    return LocalizationService.Subscription.getPremiumFeaturesTitle(of: self)
  }
  
  var thumbnail: UIImage {
    return Images.subsctiption.getFeaturesImages(for: self)
  }
  
  var thumbnailColors: [UIColor] {
    return Theme.getSubscriptionFeatureColorGradient(for: self)
  }
  
  var helperBackroundNeeded: Bool {
    switch self {
    case .deepClean:
      return false
    case .multiselect:
      return true
    case .compression:
      return true
    case .location:
      return false
    }
  }
}
