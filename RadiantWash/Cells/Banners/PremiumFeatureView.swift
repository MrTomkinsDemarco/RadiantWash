//
//  PremiumFeatureView.swift
//  RadiantWash
//
//  Created by Mac Mini on 24.02.2023.
//

import UIKit

class PremiumFeatureView: UIView {
  
  private var contentImageView = UIImageView()
  private var titleTextLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
  private func setupView() {
    
    self.addSubview(contentImageView)
    contentImageView.translatesAutoresizingMaskIntoConstraints = false
    contentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    contentImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    contentImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    contentImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
    self.addSubview(titleTextLabel)
    titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
    titleTextLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10).isActive  = true
    titleTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    titleTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    titleTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    
    contentImageView.layoutIfNeeded()
    contentImageView.setNeedsLayout()
  }
  
  public func configureView(from feature: PremiumFeature, isSettingsSize: Bool = false) {
    
    contentImageView.image = feature.thumbnail
    contentImageView.tintColor = theme.cellShadowBackgroundColor
    
    var titleText: String {
      let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
      let components = feature.title.components(separatedBy: chararacterSet)
      let words = components.filter { !$0.isEmpty }
      let wordsCount = words.count
      var title = ""
      if wordsCount == 2 {
        return feature.title.replacingOccurrences(of: " ", with: "\n")
      } else if wordsCount == 3 {
        for (index, word) in words.enumerated() {
          if index == 2 {
            title.append("\n")
            title.append(word)
          } else {
            title.append(word)
            title.append(" ")
          }
        }
        return title
      }
      return title
    }
    
    titleTextLabel.text = titleText
    titleTextLabel.font = .systemFont(ofSize: 10, weight: .medium)
    titleTextLabel.textColor = theme.titleTextColor
    titleTextLabel.lineBreakMode = .byWordWrapping
    titleTextLabel.numberOfLines = 2
  }
  
  
  public func configureLifeTimeFeatures(from feature: PremiumFeature) {
    
    contentImageView.image = feature.thumbnail
    
    titleTextLabel.text = feature.title
    titleTextLabel.font = .systemFont(ofSize: 13, weight: .medium)
    titleTextLabel.textColor = theme.titleTextColor
    titleTextLabel.lineBreakMode = .byWordWrapping
    titleTextLabel.numberOfLines = 2
  }
}
