//
//  ContactCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit
import Contacts

class ContactCell: UITableViewCell {
  
  @IBOutlet weak var reuseImageView: UIImageView!
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var contactTitleTextLabel: UILabel!
  @IBOutlet weak var contactSubtitleTextLabel: UILabel!
  @IBOutlet weak var topBaseViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomBaseViewConstraint: NSLayoutConstraint!
  
  private var contact: CNContact?
  
  public var isEditingMode: Bool = false
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    superPrepareForReuse()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if isEditingMode {
      setupSelectedContact()
    }
  }
  
  private func superPrepareForReuse() {
    
    accessoryType = .none
    contactTitleTextLabel.text = nil
    contactSubtitleTextLabel.text = nil
    reuseImageView.image = nil
  }
  
  private func setupUI() {
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = .clear
    selectedBackgroundView = backgroundView
  }
  
  public func updateCell(_ contact: CNContact, contentType: PhotoMediaType) {
    
    self.contact = contact
    self.checkSelectableMode(contact: contact)
    switch contentType {
    case .allContacts:
      setupAllCell(contact: contact)
    case .emptyContacts:
      setupEmptyCell(contact: contact)
    default:
      return
    }
  }
  
  public func checkSelectableMode(contact: CNContact) {
    
    isEditingMode ? self.setupSelectedContact() : self.setupImage(contact)
  }
  
  private func setupAllCell(contact: CNContact) {
    
    let contactFullName = CNContactFormatter.string(from: contact, style: .fullName)
    let numbers = contact.phoneNumbers.map({$0.value.stringValue})
    let emails = contact.emailAddresses.map({$0.value as String})
    
    if contactFullName == nil {
      if numbers.isEmpty {
        if emails.count == 0 {
          setupData(type: .wholeEmpty, textData: Localization.Main.ProcessingState.ByEmptyState.missingAll)
        } else {
          setupData(type: .onlyEmail, textData: emails.joined(separator: emails.count > 1 ? ", " : ""))
        }
      } else {
        setupData(type: .onlyPhone, textData: numbers.joined(separator: numbers.count > 1 ? ", " : ""))
      }
    } else {
      if let contactFullName = contactFullName {
        setupData(type: .none, textData: contactFullName)
      }
    }
  }
  
  private func setupData(type: ContactasCleaningType, textData: String) {
    
    switch type {
    case .wholeEmpty:
      
      contactTitleTextLabel.text = "-"
      contactSubtitleTextLabel.isHidden = true
      contactTitleTextLabel.font = FontManager.contactsFont(of: .missingTitle)
      contactTitleTextLabel.textColor = theme.subTitleTextColor
    case .onlyEmail:
      contactTitleTextLabel.text = "-"
      contactTitleTextLabel.textColor = theme.titleTextColor
      contactTitleTextLabel.font = FontManager.contactsFont(of: .cellTitle)
      
      contactSubtitleTextLabel.text = textData
      contactSubtitleTextLabel.textColor = theme.subTitleTextColor
      contactSubtitleTextLabel.font = FontManager.contactsFont(of: .missongSubtitle)
      contactSubtitleTextLabel.isHidden = false
      
    default:
      contactTitleTextLabel.text = textData
      contactSubtitleTextLabel.isHidden = true
      contactTitleTextLabel.textColor = theme.titleTextColor
      contactTitleTextLabel.font = FontManager.contactsFont(of: .cellTitle)
    }
  }
  
  private func setupEmptyCell(contact: CNContact) {
    
    let contactFullName = CNContactFormatter.string(from: contact, style: .fullName)
    let numbers = contact.phoneNumbers.map({$0.value.stringValue})
    let emails = contact.emailAddresses.map({$0.value as String})
    
    if contactFullName != nil {
      contactTitleTextLabel.text = contactFullName
      contactTitleTextLabel.font = FontManager.contactsFont(of: .cellTitle)
      contactTitleTextLabel.textColor = theme.titleTextColor
      
      if numbers.isEmpty {
        contactSubtitleTextLabel.font = FontManager.contactsFont(of: .missongSubtitle)
        contactSubtitleTextLabel.textColor = theme.subTitleTextColor
        if emails.isEmpty {
          contactSubtitleTextLabel.text = Localization.Main.ProcessingState.ByEmptyState.missingNumber
        } else {
          contactSubtitleTextLabel.text = emails.joined(separator: emails.count > 1 ? ", " : "")
        }
      }
    } else if numbers.count != 0 {
      contactTitleTextLabel.text = Localization.Main.ProcessingState.ByEmptyState.missingName
      contactTitleTextLabel.font = FontManager.contactsFont(of: .missingTitle)
      contactTitleTextLabel.textColor = theme.subTitleTextColor
      
      contactSubtitleTextLabel.text = numbers.joined(separator: numbers.count > 1 ? ", " : "")
      contactSubtitleTextLabel.font = FontManager.contactsFont(of: .cellSubtitle)
      contactSubtitleTextLabel.textColor = theme.titleTextColor
    } else if emails.count != 0 {
      contactTitleTextLabel.text = emails.joined(separator: numbers.count > 1 ? ", " : "")
      contactTitleTextLabel.font = FontManager.contactsFont(of: .cellTitle)
      contactTitleTextLabel.textColor = theme.titleTextColor
      
      contactSubtitleTextLabel.text = Localization.Main.ProcessingState.ByEmptyState.missingAll
      contactSubtitleTextLabel.font = FontManager.contactsFont(of: .missongSubtitle)
      contactSubtitleTextLabel.textColor = theme.subTitleTextColor
    } else {
      contactSubtitleTextLabel.isHidden = true
      contactTitleTextLabel.font = FontManager.contactsFont(of: .missingTitle)
      contactTitleTextLabel.text = Localization.Main.ProcessingState.ByEmptyState.missingAll
      contactTitleTextLabel.textColor = theme.subTitleTextColor
    }
  }
  
  private func setupSelectedContact() {
    
    if isSelected {
      reuseImageView.image = I.personalisation.contacts.selectContact
    } else {
      reuseImageView.image = I.personalisation.contacts.deselectContact
    }
  }
  
  private func setupImage(_ contact: CNContact) {
    
    if contact.imageDataAvailable {
      if let imageData = contact.thumbnailImageData, let image = UIImage(data: imageData) {
        reuseImageView.image = image
      }
    } else {
      reuseImageView.image = I.personalisation.contacts.contactPhoto
    }
  }
}

extension ContactCell: Themeble {
  
  func setupAppearance() {
    
    baseView.backgroundColor = .clear
  }
}
