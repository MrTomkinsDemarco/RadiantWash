//
//  CustomButtonWithImage.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import UIKit

class CustomButtonWithImage: UIButton {
  
  var buttonImageView = UIImageView()
  
  public var buttonImageSize: CGSize = CGSize(width: 20, height: 24)
  public var helperRightSpacing: CGFloat = 5
  public var contentType: MediaContentType = .none
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.removeCornersSublayers()
    setupImage()
  }
  
  private func setupImage() {
    
    self.addSubview(buttonImageView)
    buttonImageView.translatesAutoresizingMaskIntoConstraints = false
    
    buttonImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -helperRightSpacing).isActive = true
    self.titleEdgeInsets.right += buttonImageSize.width
    buttonImageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: helperRightSpacing).isActive = true
    buttonImageView.widthAnchor.constraint(equalToConstant: buttonImageSize.width).isActive = true
    buttonImageView.heightAnchor.constraint(equalToConstant: buttonImageSize.height).isActive = true
    buttonImageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor).isActive = true
    
    if let buttonTiteTextLabel = self.titleLabel {
      self.bringSubviewToFront(buttonTiteTextLabel)
    }
    
    self.bringSubviewToFront(buttonImageView)
  }
  
  public func setupMainButton(text: String, image: UIImage) {
    
    buttonImageView.image = image
    self.setTitle(text, for: .normal)
    self.sizeToFit()
  }
  
  public func setButtonFont(_ uiFont: UIFont?) {
    if let font = uiFont {
      self.titleLabel?.font = font
    } else {
      self.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
    }
  }
  
  public func setupAppearance(for enabled: Bool) {
    
    self.backgroundColor = .clear
    
    let colors = contentType.screeAcentGradientColorSet
    let disableColors = [theme.helperTitleTextColor.cgColor, theme.helperTitleTextColor.cgColor]
    
    let gradient = Utils.Manager.getGradientLayer(bounds: self.bounds, colors: enabled ? colors: disableColors.reversed())
    self.setTitleColor(Utils.Manager.gradientColor(bounds: self.bounds, gradientLayer: gradient), for: .normal)
    
    if let image = buttonImageView.image {
      buttonImageView.image = image.tintedWithLinearGradientColors(colorsArr: enabled ? colors.reversed() : disableColors)
    }
  }
}
