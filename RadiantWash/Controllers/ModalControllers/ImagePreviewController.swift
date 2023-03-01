//
//  ImagePreviewController.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

class ImagePreviewController: UIViewController {
  
  private let imageView = UIImageView()
  
  override func loadView() {
    view = imageView
  }
  
  init(item: UIImage) {
    super.init(nibName: nil, bundle: nil)
    
    imageView.rounded()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .red
    imageView.image = item
    
    preferredContentSize = CGSize(width: 200, height: 200)
    self.view.backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
