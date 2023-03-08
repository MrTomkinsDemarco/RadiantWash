//
//  PremiumFeutureDataSource.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

class PremiumFeutureDataSource: NSObject {
  
  public var premiumFeaturesViewModel: PremiumFeaturesViewModel
  
  init(premiumFeaturesViewModel: PremiumFeaturesViewModel) {
    self.premiumFeaturesViewModel = premiumFeaturesViewModel
  }
  
  private func setupData(cell: PremiumFeatureCell, at indexPath: IndexPath) {
    let featureModel = premiumFeaturesViewModel.getFeatureModel(at: indexPath)
    cell.setup(model: featureModel)
  }
}

extension PremiumFeutureDataSource: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return premiumFeaturesViewModel.numberOfSection()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return premiumFeaturesViewModel.numbersOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifiers.cells.premiumFeature, for: indexPath) as! PremiumFeatureCell
    self.setupData(cell: cell, at: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return AppDimensions.Subscription.Features.cellSize
  }
}
