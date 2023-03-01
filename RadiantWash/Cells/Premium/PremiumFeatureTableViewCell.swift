//
//  PremiumFeatureTableViewCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

class PremiumFeatureTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
    setupAppearance()
  }
}

extension PremiumFeatureTableViewCell: Themeble {
  
  public func configure(model: PremiumFeature) {
    
    titleTextLabel.text = model.title
    thumbnailImageView.layoutIfNeeded()
    thumbnailImageView.tintColor = theme.cellShadowBackgroundColor
    thumbnailImageView.image = model.thumbnail
  }
  
  private func setup() {
    
    self.selectionStyle = .none
    titleTextLabel.font = FontManager.subscriptionFont(of: .premiumFeature)
  }
  
  func setupAppearance() {
    
    titleTextLabel.textColor = theme.featureTitleTextColor
  }
}
