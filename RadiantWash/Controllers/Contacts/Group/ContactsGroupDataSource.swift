//
//  ContactsGroupDataSource.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

enum RowPosition {
  case top
  case middle
  case bottom
  case none
}

protocol ContactsGroupDataSourceDelegate {
  func  groupSelectLimiteExceededStatus()
}

class ContactsGroupDataSource: NSObject {
  
  public var contactGroupListViewModel: ContactGroupListViewModel
  
  public var selectedSections: [Int] = []
  public var contentType: PhotoMediaType = .none
  
  public var delegate: ContactsGroupDataSourceDelegate?
  
  init(viewModel: ContactGroupListViewModel) {
    self.contactGroupListViewModel = viewModel
  }
  
  private func setupData(cell: GroupContactCell, at indexPath: IndexPath, with position: RowPosition) {
    
    guard let contact = contactGroupListViewModel.getContact(at: indexPath) else { return }
    
    let isSelected = checkIfSelectedSecetion(at: indexPath.section)
    
    cell.delegate = self
    cell.updateCell(contact, rowPosition: position, sectionIndex: indexPath.section, isSelected: isSelected)
  }
  
  private func setupHeader(view: GroupedContactsHeaderView, at section: Int) {
    let group = self.contactGroupListViewModel.groupSection[section]
    
    switch contentType {
    case .duplicatedContacts:
      let countryCode = group.countryIdentifier.countryCode
      let region = group.countryIdentifier.region
      
      if countryCode != "", let country = U.locale.localizedString(forRegionCode: region) {
        let futureText = "+ \(countryCode) (\(country))"
        view.configure(futureText, index: section)
      } else {
        view.configure("-", index: section)
      }
    case .duplicatedPhoneNumbers, .duplicatedEmails:
      view.configure(group.name, index: section)
    default:
      return
    }
  }
  
  private func setupPosition(from indexPath: IndexPath, numberOfRows: Int) -> RowPosition {
    
    if indexPath.row == 0 {
      return .top
    } else if indexPath.row + 1 < numberOfRows {
      return .middle
    } else if indexPath.row + 1 == numberOfRows {
      return .bottom
    } else {
      return .none
    }
  }
}

extension ContactsGroupDataSource: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.contactGroupListViewModel.numbersOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contactGroupListViewModel.numbersOfRows(at: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cells.groupContactCell, for: indexPath) as! GroupContactCell
    
    let rowPosition = self.setupPosition(from: indexPath, numberOfRows: tableView.numberOfRows(inSection: indexPath.section))
    
    self.setupData(cell: cell, at: indexPath, with: rowPosition)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: C.identifiers.views.contactGroupHeader) as! GroupedContactsHeaderView
    view.delegate = self
    setupHeader(view: view, at: section)
    
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let rowPosition = self.setupPosition(from: indexPath, numberOfRows: tableView.numberOfRows(inSection: indexPath.section))
    
    switch rowPosition {
    case .top:
      return 130
    case .middle:
      return 110
    case .bottom:
      return 130
    case .none:
      return 110
    }
  }
}

extension ContactsGroupDataSource: GroupContactSelectableDelegate {
  
  func didSelecMeregeSection(at index: Int, completionHandler: @escaping (_ isSeletable: Bool) -> Void) {
    
    if self.selectedSections.contains(index) {
      self.selectedSections.removeAll(index)
      completionHandler(true)
      U.notificationCenter.post(name: .mergeContactsSelectionDidChange, object: nil)
    } else {
      SubscriptionManager.instance.purchasePremiumHandler { status in
        switch status {
        case .lifetime, .purchasedPremium:
          selectedSections.append(index)
          completionHandler(true)
          U.notificationCenter.post(name: .mergeContactsSelectionDidChange, object: nil)
        case .nonPurchased:
          if selectedSections.count == LimitAccessType.selectAllContactsGroups.selectAllLimit {
            self.delegate?.groupSelectLimiteExceededStatus()
            completionHandler(false)
          } else {
            selectedSections.append(index)
            completionHandler(true)
            U.notificationCenter.post(name: .mergeContactsSelectionDidChange, object: nil)
          }
        }
      }
    }
  }
  
  private func checkIfSelectedSecetion(at index: Int) -> Bool {
    
    return selectedSections.contains(index)
  }
}

extension ContactsGroupDataSource: GroupedHeadersButtonDelegate {
  
  func didTapDeleteGroupActionButton(_ tag: Int?) {
    
    guard let indexOfSection = tag else { return }
    
    SingleContactsGroupOperationMediator.instance.didDeleteFullContactsGroup(in: indexOfSection)
  }
  
  func didTapMergeGroupActionButton(_ tag: Int?) {
    
    guard let indexOfSection = tag else { return }
    
    SingleContactsGroupOperationMediator.instance.didMergeContacts(in: indexOfSection)
  }
}
