//
//  CustomButton.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import UIKit

class CustomButton: UIButton {
  
  let buttonImageView = UIImageView()
  
  public var imageViewSize: CGSize = CGSize(width: 22, height: 22)
  public var contentType: MediaContentType = .none
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.layer.removeCornersSublayers()
    initialize()
  }
  
  public func initialize() {
    
    self.addSubview(buttonImageView)
    buttonImageView.translatesAutoresizingMaskIntoConstraints = false
    
    buttonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    buttonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    buttonImageView.widthAnchor.constraint(equalToConstant: imageViewSize.width).isActive = true
    buttonImageView.heightAnchor.constraint(equalToConstant: imageViewSize.height).isActive = true
    
    self.bringSubviewToFront(buttonImageView)
  }
  
  public func setupImage(_ image: UIImage, enabled: Bool) {
    
    let colors = contentType.screeAcentGradientColorSet
    let disableColors = [theme.helperTitleTextColor.cgColor, theme.helperTitleTextColor.cgColor]
    
    buttonImageView.image = image.tintedWithLinearGradientColors(colorsArr: enabled ? colors.reversed() : disableColors)
  }
}
