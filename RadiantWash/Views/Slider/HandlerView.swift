//
//  HandlerView.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import UIKit

class HandlerView: UIView {
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitFrame = bounds.insetBy(dx: -20, dy: -20)
    return hitFrame.contains(point) ? self : nil
  }
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let hitFrame = bounds.insetBy(dx: -20, dy: -20)
    return hitFrame.contains(point)
  }
}
