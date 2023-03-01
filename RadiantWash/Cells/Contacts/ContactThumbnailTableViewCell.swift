//
//  ContactThumbnailTableViewCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit

class ContactThumbnailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var reuseRoundedImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
}

extension ContactThumbnailTableViewCell {
  
  public func configureCell(with model: ContactModel) {
    
    if case .thumbnailImageData(let image) = model {
      reuseRoundedImageView.image = image
    }
  }
}

extension ContactThumbnailTableViewCell: Themeble {
  
  func setupUI() {
    
    self.selectionStyle = .none
  }
  
  func setupAppearance() {}
}
