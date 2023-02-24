//
//  Gradient.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import UIKit

public enum CAGradientPoint {
  
  case topLeft
  case centerLeft
  case bottomLeft
  case topCenter
  case center
  case bottomCenter
  case topRight
  case centerRight
  case bottomRight
  
  var point: CGPoint {
    switch self {
    case .topLeft:
      return CGPoint(x: 0, y: 0)
    case .centerLeft:
      return CGPoint(x: 0, y: 0.5)
    case .bottomLeft:
      return CGPoint(x: 0, y: 1.0)
    case .topCenter:
      return CGPoint(x: 0.5, y: 0)
    case .center:
      return CGPoint(x: 0.5, y: 0.5)
    case .bottomCenter:
      return CGPoint(x: 0.5, y: 1.0)
    case .topRight:
      return CGPoint(x: 1.0, y: 0.0)
    case .centerRight:
      return CGPoint(x: 1.0, y: 0.5)
    case .bottomRight:
      return CGPoint(x: 1.0, y: 1.0)
    }
  }
}

extension CAGradientLayer {
  
  convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
    self.init()
    self.frame.origin = CGPoint.zero
    self.startPoint = start.point
    self.endPoint = end.point
    self.colors = colors
    self.locations = (0..<colors.count).map(NSNumber.init)
    self.type = type
  }
}

extension UIView {
  
  func layerGradient(startPoint: CAGradientPoint, endPoint: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
    let gradient = CAGradientLayer(start: startPoint, end: endPoint, colors: colors, type: type)
    gradient.frame.size = self.frame.size
    gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    self.layer.insertSublayer(gradient, at: 0)
  }
}
