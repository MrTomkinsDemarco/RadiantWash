//
//  UIButtonExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UIButton {
  
  func underline() {
    
    guard let text = self.titleLabel?.text else { return }
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
    self.setAttributedTitle(attributedString, for: .normal)
  }
  
  func addLeftImageWithFixLeft(spacing: CGFloat, size: CGSize, image: UIImage, tintColor: UIColor? = nil) {
    self.setImage(nil, for: .normal)
    removePreviousImage()
    removeCenterImage()
    addImageWithFix(spacing: spacing, isLeft: true, imageWidth: size.width, imageHeight: size.height, image: image, tintColor: tintColor)
  }
  
  func addRighttImageWithFixRight(spacing: CGFloat, size: CGSize, image: UIImage, tintColor: UIColor? = nil) {
    self.setImage(nil, for: .normal)
    removePreviousImage()
    removeCenterImage()
    addImageWithFix(spacing: spacing, isLeft: false, imageWidth: size.width, imageHeight: size.height, image: image, tintColor: tintColor)
  }
  
  func addLeftImage(image: UIImage, size: CGSize, spacing: CGFloat, tintColor: UIColor? = nil) {
    removePreviousImage()
    removeCenterImage()
    addImage(image: image, imageWidth: size.width, imageHeight: size.height, spacing: spacing, isLeft: true, tintColor: tintColor)
  }
  
  
  func addRightImage(image: UIImage, size: CGSize, spacing: CGFloat, tintColor: UIColor? = nil) {
    removePreviousImage()
    removeCenterImage()
    addImage(image: image, imageWidth: size.width, imageHeight: size.height, spacing: spacing, isLeft: false, tintColor: tintColor)
  }
  
  func addCenterImage(image: UIImage, imageWidth: CGFloat, imageHeight: CGFloat, spacing: CGFloat = 0, tintColor: UIColor? = nil) {
    
    self.setImage(nil, for: .normal)
    
    for subview in self.subviews {
      if let view = subview as? UIImageView {
        view.removeFromSuperview()
      }
    }
    
    
    let imageView = UIImageView(image: image)
    imageView.tag = 100500
    
    if let color = tintColor {
      imageView.tintColor = color
    }
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(imageView)
    
    imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
    imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: spacing).isActive = true
    imageView.layoutIfNeeded()
  }
  
  
  private func addImage(image: UIImage, imageWidth: CGFloat, imageHeight: CGFloat, spacing: CGFloat, isLeft: Bool, tintColor: UIColor? = nil) {
    
    let imageViewTag = 66613
    removePreviousImageView(with: imageViewTag)
    
    let imageView = UIImageView(image: image)
    imageView.tag = imageViewTag
    
    if let color = tintColor {
      imageView.tintColor = color
    }
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(imageView)
    
    if isLeft {
      titleEdgeInsets.left += imageWidth
      imageView.trailingAnchor.constraint(equalTo: self.titleLabel!.leadingAnchor, constant: -spacing).isActive = true
    } else {
      titleEdgeInsets.right += imageWidth
      imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: spacing).isActive = true
    }
    
    imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
  }
  
  private func addImageWithFix(spacing: CGFloat, isLeft: Bool, imageWidth: CGFloat, imageHeight: CGFloat, image: UIImage, tintColor: UIColor? = nil) {
    
    let imageView = UIImageView(image: image)
    imageView.tag = 66613
    
    if let color = tintColor {
      imageView.tintColor = color
    }
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(imageView)
    
    if isLeft {
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing).isActive = true
    } else {
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing).isActive = true
    }
    
    imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
  }
  
  public func hideTemporaryImage(_ hide: Bool) {
    
    if let imageView = self.subviews.first(where: {$0.tag == 66613}) as? UIImageView {
      imageView.isHidden = hide
    }
  }
  
  public func removePreviousImage() {
    
    if let imageView = self.subviews.first(where: {$0.tag == 66613}) as? UIImageView {
      imageView.removeFromSuperview()
    }
  }
  
  public func removeCenterImage() {
    
    if let imageView = self.subviews.first(where: {$0.tag == 100500}) as? UIImageView {
      imageView.removeFromSuperview()
    }
  }
  
  private func removePreviousImageView(with tag: Int) {
    if let imageView = self.subviews.first(where: {$0.tag == tag}) as? UIImageView {
      imageView.removeFromSuperview()
    }
  }
  
  public func removeButtonImages() {
    self.setImage(nil, for: .normal)
    self.subviews.forEach {
      if let _ = $0 as? UIImageView {
        $0.removeFromSuperview()
      }
    }
  }
  
  func setTitleWithoutAnimation(title: String?) {
    
    UIView.performWithoutAnimation {
      setTitle(title, for: .normal)
      layoutIfNeeded()
    }
  }
  
  public func animateProgress() {
    
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.fromValue = 0
    animation.toValue =  Double.pi * 2.0
    animation.duration = 2
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    if let imageView = self.subviews.first(where: {$0.tag == 66613}) {
      imageView.layer.add(animation, forKey: "spin")
    }
  }
  
  public func removeAnimateProgress() {
    
    if let imageView = self.subviews.first(where: {$0.tag == 66613}) {
      imageView.layer.removeAnimation(forKey: "spin")
    }
  }
}
