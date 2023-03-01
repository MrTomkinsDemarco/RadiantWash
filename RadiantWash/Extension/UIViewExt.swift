//
//  UIViewExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

public extension UIView {

  private static let kLayerNameGradientBorder = "GradientBorderLayer"

  func gradientBorder(width: CGFloat,
            colors: [UIColor],
            startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
            andRoundCornersWithRadius cornerRadius: CGFloat = 0) {

    let existingBorder = gradientBorderLayer()
    let border = existingBorder ?? CAGradientLayer()
    border.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,
                width: bounds.size.width + width, height: bounds.size.height + width)
    
    border.colors = colors.map { return $0.cgColor }
    border.startPoint = startPoint
    border.endPoint = endPoint

    let mask = CAShapeLayer()
    let maskRect = CGRect(x: bounds.origin.x + width / 2, y: bounds.origin.y + width / 2,
                width: bounds.size.width - width, height: bounds.size.height - width)
    mask.path = UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius).cgPath
    mask.fillColor = UIColor.clear.cgColor
    mask.strokeColor = UIColor.white.cgColor
    mask.lineWidth = width

    border.mask = mask

    let exists = (existingBorder != nil)
    if !exists {
      layer.addSublayer(border)
    }
  }
  private func gradientBorderLayer() -> CAGradientLayer? {
    let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
    if borderLayers?.count ?? 0 > 1 {
      fatalError()
    }
    return borderLayers?.first as? CAGradientLayer
  }
}

extension UIView {
  
  func animateButtonTransform() {
    
    UIView.animate(withDuration: 0.1) {
      self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    } completion: { _ in
      UIView.animate(withDuration: 0.1) {
        self.transform = CGAffineTransform.identity
      } completion: { _ in }
    }
  }
  
  func setupForShadow(shadowColor: UIColor = .black,
                      cornerRadius: CGFloat = 6,
                      shadowOffcet: CGSize = CGSize(width: 7, height: 7),
                      shadowOpacity: Float = 0.2,
                      shadowRadius: CGFloat = 5) {
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = false
    self.layer.shadowColor = shadowColor.cgColor
    self.layer.shadowOpacity =  shadowOpacity
    self.layer.shadowOffset = shadowOffcet
    self.layer.shadowRadius = shadowRadius
    self.isOpaque = true
  }
  
  func setupForSimpleBlurView(blur style: UIBlurEffect.Style) {
    
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.insertSubview(blurEffectView, at: 0)
  }
  
  func setCorner(_ radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
  
  func rounded() {
    layer.cornerRadius = frame.height / 2
    layer.masksToBounds = true
  }
  
  func cornerSelectRadiusView(corners: UIRectCorner, radius: CGFloat) {
    
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
    let border = UIView()
    border.backgroundColor = color
    border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
    addSubview(border)
  }
  
  func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
    let border = UIView()
    border.backgroundColor = color
    border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
    addSubview(border)
  }
  
  func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
    let border = UIView()
    border.backgroundColor = color
    border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
    border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
    addSubview(border)
  }
  
  func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
    let border = UIView()
    border.backgroundColor = color
    border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
    border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
    addSubview(border)
  }
  
  func setBorder(radius: CGFloat, color: UIColor, width: CGFloat) {
    self.layer.cornerRadius = radius
    layer.borderWidth = width
    layer.borderColor = color.cgColor
    self.clipsToBounds = true
  }
  
  func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
    return recursiveSubviews.compactMap { $0 as? T }
  }
  
  var recursiveSubviews: [UIView] {
    return subviews + subviews.flatMap { $0.recursiveSubviews }
  }
}
