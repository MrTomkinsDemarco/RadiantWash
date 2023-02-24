//
//  StoryBoarded.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

protocol Storyboarded {}

extension Storyboarded where Self: UIViewController {
  
  static func instantiate(type: PresentedControllerType) -> Self {
    let storyboard = UIStoryboard(name: type.storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: type.viewControllerIdentifier) as! Self
  }
}
