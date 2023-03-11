//
//  StartingNavigationBar.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

class StartingNavigationBar: UIView {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var leftBarButton: UIButton!
  @IBOutlet weak var rightBarButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var topShevronView: UIView!
  @IBOutlet weak var leftButtonSizeHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightButtonHeightConstraint: NSLayoutConstraint!
  
  var delegate: StartingNavigationBarDelegate?
  
  var topShevronEnable: Bool = false {
    didSet {
      shevronSetup()
    }
  }
  
  public var buttonSize = AppDimensions.NavigationBar.startingNavigationBarButtonSize {
    didSet {
      self.setButtonsSize(buttonSize)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.configure()
    self.actionButtonsSetup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.commonInit()
  }
  
  private func commonInit() {
    
    U.mainBundle.loadNibNamed(C.identifiers.navigation.main, owner: self, options: nil)
  }
  
  private func configure() {
    
    topShevronView.isHidden = !topShevronEnable
    containerView.backgroundColor = .clear
    backgroundColor = .clear
    addSubview(self.containerView)
    containerView.frame = self.bounds
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    titleLabel.textColor = theme.titleTextColor
    titleLabel.font = FontManager.navigationBarFont(of: .title)
    
    setButtonsSize(buttonSize)
  }
  
  private func shevronSetup() {
    
    topShevronView.isHidden = !topShevronEnable
    topShevronView.setCorner(3)
    topShevronView.backgroundColor = theme.topShevronBackgroundColor
  }
  
  public func setUpNavigation(title: String?, leftImage: UIImage? = nil, rightImage: UIImage? = nil, targetImageScaleFactor: CGFloat = 0.5) {
    
    let targetSize: CGSize = CGSize(width: buttonSize * targetImageScaleFactor, height: buttonSize * targetImageScaleFactor)
    
    var leftImageSize: CGSize {
      if let leftImage = leftImage {
        return leftImage.getPreservingAspectRationScaleImageSize(from: targetSize)
      } else {
        return .zero
      }
    }
    
    var rightImageSzie: CGSize {
      if let rightImage = rightImage {
        return rightImage.getPreservingAspectRationScaleImageSize(from: targetSize)
      } else {
        return .zero
      }
    }
    
    if let title = title {
      titleLabel.isHidden = false
      titleLabel.text = title
    } else {
      titleLabel.isHidden = true
    }
    
    if let rightImage = rightImage {
      rightBarButton.isHidden = false
      rightBarButton.addCenterImage(image: rightImage, imageWidth: rightImageSzie.width, imageHeight: rightImageSzie.height)
    } else {
      rightBarButton.isHidden = true
    }
    
    if let leftImage = leftImage {
      leftBarButton.isHidden = false
      leftBarButton.addCenterImage(image: leftImage, imageWidth: leftImageSize.width, imageHeight: leftImageSize.height)
    } else {
      leftBarButton.isHidden = true
    }
  }
  
  public func setButtonsSize(_ height: CGFloat) {
    leftButtonSizeHeightConstraint.constant = height
    rightButtonHeightConstraint.constant = height
  }
  
  private func actionButtonsSetup() {
    
    leftBarButton.addTarget(self, action: #selector(didTapLeftBarButton(sender:)), for: .touchUpInside)
    rightBarButton.addTarget(self, action: #selector(didTapRightBarButton(sender:)), for: .touchUpInside)
  }
  
  @objc func didTapLeftBarButton(sender: UIButton) {
    self.leftBarButton.animateButtonTransform()
    delegate?.didTapLeftBarButtonItem(sender)
  }
  
  @objc func didTapRightBarButton(sender: UIButton) {
    self.rightBarButton.animateButtonTransform()
    delegate?.didTapRightBarButtonItem(sender)
  }
}
