//
//  GroupedContactsHeaderView.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

protocol GroupedHeadersButtonDelegate: AnyObject {
  
  func didTapDeleteGroupActionButton(_ tag: Int?)
  func didTapMergeGroupActionButton(_ tag: Int?)
}

class GroupedContactsHeaderView: UITableViewHeaderFooterView {
  
  @IBOutlet weak var headerTitleTextLabel: UILabel!
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var mergeButton: CustomMergeButton!
  
  var delegate: GroupedHeadersButtonDelegate?
  
  var index: Int?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureView()
    updateColors()
    setupActionButtons()
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
  }
  
  public func configure(_ title: String, index: Int) {
    
    headerTitleTextLabel.text = title.containsAlphabets ? title : title.removeWhitespace()
    self.index = index
  }
  
  private func configureView() {
    deleteButton.setImage(I.personalisation.contacts.deleteContact, for: .normal)
    mergeButton.didset(righty: I.personalisation.contacts.mergeContact, with: LocalizationService.Buttons.getButtonTitle(of: .merge).uppercased())
    mergeButton.titleLabel!.font = FontManager.contactsFont(of: .headerButonFont)
    headerTitleTextLabel.font = FontManager.contactsFont(of: .headetTitle)
  }
  
  private func updateColors() {
    
    mergeButton.setTitleColor(theme.contactsTintColor, for: .normal)
    headerTitleTextLabel.textColor = theme.sectionTitleTextColor
    deleteButton.backgroundColor = .clear
  }
  
  private func setupActionButtons() {
    
    deleteButton.addTarget(self, action: #selector(didTapDeleteSelectedGroup), for: .touchUpInside)
    mergeButton.addTarget(self, action: #selector(didTapMergeCurrentSectionGroup), for: .touchUpInside)
  }
  
  @objc func didTapDeleteSelectedGroup() {
    delegate?.didTapDeleteGroupActionButton(index)
  }
  
  @objc func didTapMergeCurrentSectionGroup() {
    delegate?.didTapMergeGroupActionButton(index)
  }
}
