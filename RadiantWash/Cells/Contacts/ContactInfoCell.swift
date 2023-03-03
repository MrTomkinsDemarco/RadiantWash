//
//  ContactInfoCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit
import Contacts

class ContactInfoCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  
  @IBOutlet weak var fieldTitleTextLabel: UILabel!
  @IBOutlet weak var fieldValueTextLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  private func setupUI() {
    
    selectionStyle = .none
    baseView.setCorner(14)
    
    fieldValueTextLabel.font = FontManager.contentTypeFont(of: .title)
    fieldTitleTextLabel.font = FontManager.contentTypeFont(of: .subtitle)
  }
  
  public func setup(model: ContactModel) {
    
    switch model {
    case .fullName(let name):
      fieldTitleTextLabel.isHidden = true
      fieldValueTextLabel.text = name
    case .phoneNumbers(let phoneNumber):
      if let label = phoneNumber.label {
        let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
        fieldTitleTextLabel.text = localizedLabel
      } else {
        fieldTitleTextLabel.text = Localization.Main.Subtitles.phone
      }
      
      fieldValueTextLabel.text = phoneNumber.value.stringValue
    case .emailAddresses(let emailAddress):
      if let label = emailAddress.label {
        let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
        fieldTitleTextLabel.text = localizedLabel
      } else {
        fieldTitleTextLabel.text = Localization.Main.Subtitles.email
      }
      fieldValueTextLabel.text = emailAddress.value as String
    case .urlAddresses(let url):
      fieldTitleTextLabel.text = url.label ?? Localization.Main.Subtitles.url
      fieldValueTextLabel.text = url.value as String
    default:
      return
    }
  }
}

extension ContactInfoCell: Themeble {
  
  func setupAppearance() {
    
    fieldValueTextLabel.textColor = theme.titleTextColor
    fieldTitleTextLabel.textColor = theme.subTitleTextColor
  }
}
