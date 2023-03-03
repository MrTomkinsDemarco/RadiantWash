//
//  PremiumFeatureCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

class PremiumFeatureCell: UITableViewCell {
  
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  public func setup(model: PremiumFeature) {
    
    titleTextLabel.text = model.title
    thumbnailImageView.layoutIfNeeded()
    thumbnailImageView.tintColor = theme.cellShadowBackgroundColor
    thumbnailImageView.image = model.thumbnail
  }
  
  private func setupUI() {
    
    self.selectionStyle = .none
    titleTextLabel.font = FontManager.subscriptionFont(of: .premiumFeature)
  }
  
  func setupAppearance() {
    
    titleTextLabel.textColor = theme.featureTitleTextColor
  }
}
