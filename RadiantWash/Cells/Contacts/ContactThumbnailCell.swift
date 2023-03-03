//
//  ContactThumbnailCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit

class ContactThumbnailCell: UITableViewCell {
  
  @IBOutlet weak var reuseRoundedImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  func setupUI() {
    
    self.selectionStyle = .none
  }
  
  public func setup(model: ContactModel) {
    
    if case .thumbnailImageData(let image) = model {
      reuseRoundedImageView.image = image
    }
  }
}
