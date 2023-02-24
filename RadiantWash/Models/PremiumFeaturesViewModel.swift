//
//  PremiumFeaturesViewModel.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import Foundation

class PremiumFeaturesViewModel {
  
  let features: [PremiumFeature]
  
  init(features: [PremiumFeature]) {
    self.features = features
  }
  
  public func numberOfSection() -> Int {
    return 1
  }
  
  public func numbersOfRows(in section: Int) -> Int {
    return self.features.count
  }
  
  public func getFeatureModel(at indexPath: IndexPath) -> PremiumFeature {
    return self.features[indexPath.row]
  }
}
