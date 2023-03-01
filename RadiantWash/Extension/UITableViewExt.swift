//
//  UITableViewExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UITableView {
  
  func reloadRowWithoutAnimation(at indexPath: IndexPath) {
    DispatchQueue.main.async {
      UIView.performWithoutAnimation {
        self.reloadRows(at: [indexPath], with: .none)
      }
    }
  }
  
  func reloadDataWithoutAnimation() {
    DispatchQueue.main.async {
      UIView.performWithoutAnimation {
        self.reloadData()
      }
    }
  }
}
