//
//  UIImageExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UIImage {
  
  func tintedWithLinearGradientColors(colorsArr: [CGColor]) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    
    guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
    context.translateBy(x: 0, y: self.size.height)
    context.scaleBy(x: 1, y: -1)
    
    context.setBlendMode(.normal)
    let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    
      // Create gradient
    let colors = colorsArr as CFArray
    let space = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)
    
      // Apply gradient
    context.clip(to: rect, mask: self.cgImage!)
    context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: self.size.height), options: .drawsAfterEndLocation)
    let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return gradientImage!
  }
  
  func tintedGradient(colors: [CGColor], start: CoordinateSide, end: CoordinateSide) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    
    guard let context = UIGraphicsGetCurrentContext(), let image = self.cgImage else { return UIImage() }
    
    let width = self.size.width
    let height = self.size.height
    
    context.translateBy(x: .zero, y: height)
    context.scaleBy(x: 1, y: -1)
    context.setBlendMode(.normal)
    let rect = CGRect(x: 0, y: 0, width: width, height: height)
    let colorsArray = colors as CFArray
    let space = CGColorSpaceCreateDeviceRGB()
    
    guard let gradient = CGGradient(colorsSpace: space, colors: colorsArray, locations: nil) else { return UIImage() }
    context.clip(to: rect, mask: image)
  
    var startPoint: CGPoint {
      switch start {
        case .topLeft:    return .init(x: .zero, y: height)
        case .top:         return .init(x: width / 2, y: height)
        case .topRight:   return .init(x: width, y: height)
        case .right:         return .init(x: width, y: height / 2)
        case .bottomRight:   return .init(x: width, y: .zero)
        case .bottom:        return .init(x: width / 2, y: .zero)
        case .bottomLeft:   return .zero
        case .left:         return .init(x: .zero, y: height / 2)
      }
    }
    
    var endPoint: CGPoint {
      switch end {
        case .topLeft:    return .init(x: .zero, y: height)
        case .top:         return .init(x: width / 2, y: height)
        case .topRight:   return .init(x: width, y: height)
        case .right:         return .init(x: width, y: height / 2)
        case .bottomRight:   return .init(x: width, y: .zero)
        case .bottom:        return .init(x: width / 2, y: .zero)
        case .bottomLeft:   return .zero
        case .left:         return .init(x: .zero, y: height / 2)
      }
    }
  
    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
    let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return gradientImage ?? UIImage()
  }
}

extension UIImage {
  
  public func setShadow(blur: CGFloat = 6, offset: CGSize, color: UIColor, alpha: CGFloat) -> UIImage {
    
    let shadowRect = CGRect(
      x: offset.width - blur,
      y: offset.height - blur,
      width: size.width + blur * 2,
      height: size.height + blur * 2
    )
    
    UIGraphicsBeginImageContextWithOptions(
      CGSize(
        width: max(shadowRect.maxX, size.width) - min(shadowRect.minX, 0),
        height: max(shadowRect.maxY, size.height) - min(shadowRect.minY, 0)
      ),
      false, 0
    )
    
    let context = UIGraphicsGetCurrentContext()!
    
    context.setShadow(
      offset: offset,
      blur: blur,
      color: color.cgColor
    )
  
    draw(
      in: CGRect(
        x: max(0, -shadowRect.origin.x),
        y: max(0, -shadowRect.origin.y),
        width: size.width,
        height: size.height
      )
    )
    
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    
    UIGraphicsEndImageContext()
    return image
    
  }
  
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
  
  func getPreservingAspectRationScaleImageSize(from targerSize: CGSize) -> CGSize {
    let widthRatio = targerSize.width / size.width
    let heigtRatio = targerSize.height / size.height
    let scale = min(widthRatio, heigtRatio)
    return CGSize(width: size.width * scale, height: size.height * scale)
  }
  
  func renderScalePreservingAspectRatio(from targerSize: CGSize) -> UIImage {
    let widthRation = targerSize.width / size.width
    let heightRation = targerSize.height / size.height
    let scale = min(widthRation, heightRation)
    let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
    let renderer = UIGraphicsImageRenderer(size: scaledSize)
    let rect = CGRect(origin: .zero, size: scaledSize)
    let image = renderer.image { _ in
      self.draw(in: rect)
    }
    return image
  }
  
  func rotated(by degrees: CGFloat) -> UIImage {
    let radians : CGFloat = degrees * CGFloat(.pi / 180.0)
    let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
    let t = CGAffineTransform(rotationAngle: radians)
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    UIGraphicsBeginImageContextWithOptions(rotatedSize, false, self.scale)
    defer { UIGraphicsEndImageContext() }
    guard let bitmap = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else {
      return self
    }
    bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
    bitmap.rotate(by: radians)
    bitmap.scaleBy(x: 1.0, y: -1.0)
    bitmap.draw(cgImage, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
      return self
    }
    return newImage
    }
}

extension UIImage {
  
  enum ContentMode {
    case contentFill
    case contentAspectFill
    case contentAspectFit
  }
  
  func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
    let aspectWidth = size.width / self.size.width
    let aspectHeight = size.height / self.size.height
    
    switch contentMode {
    case .contentFill:
      return resize(withSize: size)
    case .contentAspectFit:
      let aspectRatio = min(aspectWidth, aspectHeight)
      return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
    case .contentAspectFill:
      let aspectRatio = max(aspectWidth, aspectHeight)
      return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
    }
  }
  
  private func resize(withSize size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
