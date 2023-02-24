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
