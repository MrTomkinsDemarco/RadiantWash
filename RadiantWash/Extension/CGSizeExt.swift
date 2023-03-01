//
//  CGSizeExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

public extension CGSize {
  
  func toPixel() -> CGSize {
    let scale = UIScreen.main.scale
    return CGSize(width: self.width * scale, height: self.height * scale)
  }
}

extension CGSize {
  
  func videoResolutionSize() -> VideoCGSize {
    
    let originSize = CGSize(width: -1, height: -1)
    let widthSize = CGSize(width: self.width, height: -1)
    let heightSize = CGSize(width: -1, height: self.height)
    
    switch self {
    case originSize:
      return .origin
    case widthSize:
      return .width
    case heightSize:
      return .height
    default:
      return .origin
    }
  }
}
