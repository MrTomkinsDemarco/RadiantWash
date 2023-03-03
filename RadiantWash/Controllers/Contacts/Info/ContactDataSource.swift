//
//  ContactDataSource.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

class ContactDataSource: NSObject {
  
  private var contactViewModel: ContactViewModel
  
  public var didTapSelectDeleteContact: (() -> Void) = {}
  
  init(viewModel: ContactViewModel) {
    self.contactViewModel = viewModel
  }
}

extension ContactDataSource {
  
  private func configureThumbnail(_ cell: ContactThumbnailCell, at indexPath: IndexPath) {
    
    let field = self.contactViewModel.getContactModel(at: indexPath)
    cell.setup(model: field)
  }
  
  private func setup(_ cell: ContactInfoCell, at indexPath: IndexPath) {
    
    let field = self.contactViewModel.getContactModel(at: indexPath)
    cell.setup(model: field)
  }
}

extension ContactDataSource: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.contactViewModel.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contactViewModel.numberOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifiers.cells.contactThumbnail, for: indexPath) as! ContactThumbnailCell
      self.configureThumbnail(cell, at: indexPath)
      return cell
    case self.contactViewModel.numberOfSections() - 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifiers.cells.actionCell, for: indexPath) as! ActionCell
      cell.delegate = self
      cell.setupButton(with: .deleteContact)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifiers.cells.contactInfo, for: indexPath) as! ContactInfoCell
      self.setup(cell, at: indexPath)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.contactViewModel.getHeaderTitle(in: section)
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header = view as! UITableViewHeaderFooterView
    header.contentView.backgroundColor = ThemeManager.theme.backgroundColor
    header.contentView.alpha = 0.8
    header.textLabel?.textColor = ThemeManager.theme.sectionTitleTextColor
    header.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.contactViewModel.getHeightForRow(at: indexPath)
  }
}

extension ContactDataSource: ActionTableCellDelegate {
  
  func didTapActionButton(at cell: ActionCell) {
    self.didTapSelectDeleteContact()
  }
}
