//
//  CGFloatExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension CGFloat {
  
  var cleanValue: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)//
  }
}
