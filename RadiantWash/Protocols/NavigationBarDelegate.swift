//
//  NavigationBarDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

protocol StartingNavigationBarDelegate: AnyObject {
  
  func didTapLeftBarButtonItem(_ sender: UIButton)
  func didTapRightBarButtonItem(_ sender: UIButton)
}

protocol NavigationBarDelegate: AnyObject {
  
  func didTapLeftBarButton(_ sender: UIButton)
  func didTapRightBarButton(_ sender: UIButton)
}

protocol PremiumNavigationBarDelegate: AnyObject {
  
  func didTapLeftBarButton(_ sender: UIButton)
  func didTapRightBarButton(_ sender: UIButton)
}
