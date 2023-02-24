//
//  UINavigationControllerExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UINavigationController {
  
  func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
    pushViewController(viewController, animated: animated)
    
    if animated, let coordinator = transitionCoordinator {
      coordinator.animate(alongsideTransition: nil) { _ in
        completion()
      }
    } else {
      completion()
    }
  }
  
  func popViewController(animated: Bool, completion: @escaping () -> Void) {
    popViewController(animated: animated)
    
    if animated, let coordinator = transitionCoordinator {
      coordinator.animate(alongsideTransition: nil) { _ in
        completion()
      }
    } else {
      completion()
    }
  }
}
