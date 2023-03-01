//
//  HelperBannerTableViewCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 24.02.2023.
//

import UIKit

class HelperBannerTableViewCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var bannerImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
}

extension HelperBannerTableViewCell {
  
  public func cellConfigure(with image: UIImage) {
    bannerImageView.image = image
  }
}

extension HelperBannerTableViewCell {
  
  func setupUI() {
    
    selectionStyle = .none
    baseView.setCorner(14)
    bannerImageView.contentMode = .scaleAspectFill
  }
}
