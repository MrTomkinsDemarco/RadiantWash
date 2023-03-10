//
//  CustomMergeButton.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import UIKit

class CustomMergeButton: UIButton {
  
  public var imageSize: CGSize = CGSize(width: 24, height: 18)
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.backgroundColor = .clear
    configureButton()
  }
  
  private func configureButton() {
    
    self.clipsToBounds = true
    self.layer.cornerRadius = 10
  }
  
  public func didset(lefty image: UIImage, with title: String) {
    
    addLeftImage(image: image, size: self.imageSize, spacing: 5)
    setTitle(title, for: .normal)
  }
  
  public func didset(righty image: UIImage, with title: String) {
    
    addRightImage(image: image, size: self.imageSize, spacing: 5)
    setTitle(title, for: .normal)
  }
}
