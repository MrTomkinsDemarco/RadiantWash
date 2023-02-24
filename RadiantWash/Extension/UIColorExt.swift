//
//  UIColorExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UIColor {
  
  func colorFromHexString (_ hex: String) -> UIColor {
    
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  func toHex() -> String {
    
    let cgColorInRGB = cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil)!
    let colorRef = cgColorInRGB.components
    let r = colorRef?[0] ?? 0
    let g = colorRef?[1] ?? 0
    let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
    let a = cgColor.alpha
    
    var color = String(
      format: "#%02lX%02lX%02lX",
      lroundf(Float(r * 255)),
      lroundf(Float(g * 255)),
      lroundf(Float(b * 255))
    )
    
    if a < 1 {
      color += String(format: "%02lX", lroundf(Float(a * 255)))
    }
    color.removeFirst()
    return color.lowercased()
  }
}

//
extension UIColor {

    public convenience init(hex: String) {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let red: CGFloat = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue: CGFloat = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha: CGFloat = CGFloat(1.0)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
        return
    }
}
