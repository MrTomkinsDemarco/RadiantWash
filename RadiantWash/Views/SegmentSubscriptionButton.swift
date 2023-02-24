//
//  SegmentSubscriptionButton.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import UIKit

class SegmentSubscriptionButton: UIView {
  
  private var segmentButton = UIButton()
  
  private var titleTextLabel = UILabel()
  private var priceTextLabel = TitleLabel()
  private var descriptionTextLabel = TitleLabel()
  
  public var isRed = false
  
  private var gradeintColors: [UIColor] = []
  
  private var index: Int = 0
  var delegate: SegmentSubscriptionButtonDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }

  private func setupView() {
    
    segmentButton.addTarget(self, action: #selector(segmentDidSelect), for: .touchUpInside)
    titleTextLabel.textAlignment = .center
    priceTextLabel.textAlignment = .center
    descriptionTextLabel.textAlignment = .center
    priceTextLabel.numberOfLines = 2
    descriptionTextLabel.textAlignment = .center
    descriptionTextLabel.numberOfLines = 2
    descriptionTextLabel.lineBreakMode = .byWordWrapping
    
    switch Screen.size {
      case .small:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
      case .medium:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .plus:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .large:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .modern:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .pro:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .max:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .madMax:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
      case .proMax:
        descriptionTextLabel.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
    }
  }
  
  public func setupTitleFont(font: UIFont) {
    self.titleTextLabel.font = font
  }
  
  public func setupPriceFont(font: UIFont?) {
    if let font = font {
      self.priceTextLabel.font = font
    }
  }
  
  public func setupDescription(font: UIFont) {
    self.descriptionTextLabel.font = font
  }
  
  public func setupTitleColor(color: UIColor) {
    self.titleTextLabel.textColor = color
  }
  
  public func setupPriceColor(color: UIColor) {
    self.priceTextLabel.textColor = color
  }
  
  public func setupPriceGradient(colors: [UIColor], font: UIFont) {
    self.gradeintColors = colors
    self.priceTextLabel.font = font
    self.gradientSetup()
  }
  
  public func setupDescriptionColor(color: UIColor) {
    self.descriptionTextLabel.textColor = color
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.backgroundColor = .clear
    
    self.labelsStackSetup()
    self.setupButton()
    self.gradientSetup()
  }
  
  public func gradientSetup() {
    
    if !gradeintColors.isEmpty {
      if let price = self.priceTextLabel.text, let font = self.priceTextLabel.font {
        self.priceTextLabel.layoutIfNeeded()
        self.priceTextLabel.addGradientText(string: price, with: gradeintColors, font: font)
      }
    }
  }
  
  private func setupButton() {
    segmentButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    self.addSubview(segmentButton)
    
    segmentButton.translatesAutoresizingMaskIntoConstraints = false
    segmentButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    segmentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    segmentButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    segmentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  private func labelsStackSetup() {

    let stackView = UIStackView(arrangedSubviews: [titleTextLabel, priceTextLabel, descriptionTextLabel])
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    self.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    stackView.layoutIfNeeded()
  }
  
  public func configure(model: ProductStoreDesriptionModel, index: Int) {
    
    self.index = index
    self.titleTextLabel.text = model.productName.uppercased()
    self.priceTextLabel.text = model.productPrice + "\n" + model.productPeriod
    self.descriptionTextLabel.text = model.description
  }
  
  @objc func segmentDidSelect() {
    delegate?.indexSelect(index: self.index)
  }
}
