//
//  GroupContactCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit
import Contacts

protocol GroupContactSelectableDelegate: AnyObject {
  func didSelecMeregeSection(at index: Int, completionHandler: @escaping (_ isSeletable: Bool) -> Void)
}

class GroupContactCell: UITableViewCell {
  
  @IBOutlet weak var reuseImageView: UIImageView!
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var contactTitleTextLabel: UILabel!
  @IBOutlet weak var contactSubtitleTextLabel: UILabel!
  @IBOutlet weak var selectableButton: UIButton!
  @IBOutlet weak var topBaseViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomBaseViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var selectableContactImageView: UIImageView!
  @IBOutlet weak var selectableContactImageViewWidthConstraint: NSLayoutConstraint!
  
  private var customSeparator = UIView()
  private let helperSeparatorView = UIView()
  
  private var isFirstRowInSection: Bool = false
  private var isLastRowInSection: Bool = false
  
  private var isSelectableSection: Bool = false
  
  public var delegate: GroupContactSelectableDelegate?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.superPrepareForReuse()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  private func setupUI() {
    
    selectionStyle = .none
    contactTitleTextLabel.font = FontManager.contactsFont(of: .cellTitle)
    contactSubtitleTextLabel.font = FontManager.contactsFont(of: .cellSubtitle)
    selectableContactImageViewWidthConstraint.constant = AppDimensions.ContactsController.Collection.selectableGoupAssetViewWidth
    separatorInset.left = 20
  }
  
  private func superPrepareForReuse() {
    
    isSelected = false
    
    contactTitleTextLabel.text = nil
    contactSubtitleTextLabel.text = nil
    selectableContactImageView.image = nil
    
    customSeparator.removeFromSuperview()
    helperSeparatorView.removeFromSuperview()
    
    topBaseViewConstraint.constant = 0
    bottomBaseViewConstraint.constant = 0
  }
  
//  public func setupCustomSeparator() {
//
//    self.baseView.addSubview(customSeparator)
//    customSeparator.translatesAutoresizingMaskIntoConstraints = false
//
//    customSeparator.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 23).isActive = true
//    customSeparator.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -23).isActive = true
//    customSeparator.heightAnchor.constraint(equalToConstant: 3).isActive = true
//    customSeparator.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 0).isActive = true
//
//    customSeparator.addSubview(helperSeparatorView)
//    helperSeparatorView.translatesAutoresizingMaskIntoConstraints = false
//
//    helperSeparatorView.leadingAnchor.constraint(equalTo: customSeparator.leadingAnchor).isActive = true
//    helperSeparatorView.trailingAnchor.constraint(equalTo: customSeparator.trailingAnchor).isActive = true
//    helperSeparatorView.bottomAnchor.constraint(equalTo: customSeparator.bottomAnchor).isActive = true
//    helperSeparatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
//  }
  
  public func updateCell(_ contact: CNContact, rowPosition: RowPosition, sectionIndex: Int, isSelected: Bool) {
    
    self.tag = sectionIndex
    self.isSelectableSection = isSelected
    self.setup(contact: contact)
    
    switch rowPosition {
    case .top:
      self.setupBestContactMerge(isShow: true)
//      self.setupCustomSeparator()
    case .middle:
      self.setupBestContactMerge(isShow: false)
//      self.setupCustomSeparator()
    default:
      self.setupBestContactMerge(isShow: false)
    }
  }
  
  private func setup(contact: CNContact) {
    
    let contactFullName = CNContactFormatter.string(from: contact, style: .fullName)
    
    contactTitleTextLabel.text = contactFullName
    
    let numbers = contact.phoneNumbers.map({$0.value.stringValue})
    
    contactSubtitleTextLabel.text = numbers.joined(separator: numbers.count > 1 ? ", " : "")
    
    if let imageData = contact.thumbnailImageData, let image = UIImage(data: imageData) {
      reuseImageView.image = image
    } else {
      reuseImageView.image = I.personalisation.contacts.contactPhoto
    }
  }
  
  private func setupBestContactMerge(isShow: Bool) {
    
    selectableButton.isEnabled = isShow
    
    if isShow {
      selectableContactImageView.image = self.isSelectableSection ? I.personalisation.contacts.sectionSelect : I.personalisation.contacts.deselectContact
      selectableContactImageView.isHidden = false
    } else {
      selectableContactImageView.image = nil
      selectableContactImageView.isHidden = true
    }
  }
  
  private func checkSelection() {
    
    guard selectableButton.isEnabled else { return }
    
    self.isSelectableSection = !self.isSelectableSection
    setupBestContactMerge(isShow: true)
  }
  
  @IBAction func didTapSelectSection(_ sender: Any) {
    delegate?.didSelecMeregeSection(at: tag, completionHandler: { isSeletable in
      guard isSeletable else { return }
      self.checkSelection()
    })
  }
}

extension GroupContactCell: Themeble {
  
  func setupAppearance() {
    
    self.backgroundColor = Theme.light.cellBackGroundColor
    self.tintColor = Theme.light.bottomShadowColor
    
    baseView.backgroundColor = .clear
    
    contactTitleTextLabel.textColor = theme.titleTextColor
    contactSubtitleTextLabel.textColor = theme.contactsTintColor
    
    customSeparator.backgroundColor = theme.separatorMainColor
    helperSeparatorView.backgroundColor = theme.separatorHelperColor
  }
}
