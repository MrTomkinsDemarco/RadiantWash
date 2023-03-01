//
//  UILabelExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UILabel {
  
  func setTitleWithoutAnimation(title: String) {
    UIView.performWithoutAnimation {
      text = title
      layoutIfNeeded()
    }
  }
  
  func setMargins(margin: CGFloat = 10) {
    if let textString = self.text {
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.firstLineHeadIndent = margin
      paragraphStyle.headIndent = margin
      paragraphStyle.tailIndent = -margin
      let attributedString = NSMutableAttributedString(string: textString)
      attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
      attributedText = attributedString
    }
  }
  
  func leftMargin(margin: CGFloat = 10) {
    if let textString = self.text {
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.firstLineHeadIndent = margin
      paragraphStyle.headIndent = margin
      paragraphStyle.alignment = .left
      let attributedString = NSMutableAttributedString(string: textString)
      attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
      attributedText = attributedString
    }
  }
  
  func rightMargin(margin: CGFloat = 10) {
    if let textString = self.text {
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.tailIndent = -margin
      paragraphStyle.alignment = .right
      let attributedString = NSMutableAttributedString(string: textString)
      attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
      attributedText = attributedString
    }
  }
  
  var maxNumberOfLines: Int {
    let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
    let text = (self.text ?? "") as NSString
    let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as UIFont], context: nil).height
    let lineHeight = font.lineHeight
    return Int(ceil(textHeight / lineHeight))
  }
}
