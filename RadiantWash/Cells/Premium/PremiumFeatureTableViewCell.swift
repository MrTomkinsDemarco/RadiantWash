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
//  @IBOutlet weak var thumbnailView: GradientShadowView!
//  @IBOutlet var thumbnailViewLeadingConstraint: NSLayoutConstraint!
//  @IBOutlet var thumbnailViewHeightConstraint: NSLayoutConstraint!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    setup()
    updateColors()
    }
}

extension PremiumFeatureTableViewCell: Themeble {
  
  public func configure(model: PremiumFeature) {
    
    titleTextLabel.text = model.title
    thumbnailImageView.layoutIfNeeded()
    thumbnailImageView.tintColor = theme.cellShadowBackgroundColor
    thumbnailImageView.image = model.thumbnail
//    thumbnailView.setImageWithCustomBackground(image: model.thumbnail, tintColor: .white, size: CGSize(width: thumbnailView.frame.height / 2, height: thumbnailView.frame.height / 2), colors: model.thumbnailColors)
  }
  
  private func setup() {
    self.selectionStyle = .none
    
//    thumbnailViewLeadingConstraint.constant = AppDimensions.Subscription.Features.leadingInset
//    thumbnailViewHeightConstraint.constant = AppDimensions.Subscription.Features.thumbnailSize
    titleTextLabel.font = FontManager.subscriptionFont(of: .premiumFeature)
  }
  
  func updateColors() {
    
    titleTextLabel.textColor = theme.featureTitleTextColor
//    thumbnailView.setShadowColor(for: theme.topShadowColor, and: theme.bottomShadowColor)
  }
}
