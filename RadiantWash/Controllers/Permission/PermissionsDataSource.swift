//
//  PermissionsDataSource.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

protocol PermissionsActionsDelegate {
  func permissionActionChange(at cell: PermissionCell)
  func didTapContinueButton()
}

class PermissionsDataSource: NSObject {
  
  public var permissionViewModel: PermissionViewModel
  public var permissionActionDidChange: ((_ cell: PermissionCell,_ permission: Permission) -> Void) = {_, _ in}
  public var handleContinueButton: (() -> Void) = {}
  public var fromRootViewController: Bool = true
  
  init(permissionViewModel: PermissionViewModel) {
    self.permissionViewModel = permissionViewModel
  }
}

extension PermissionsDataSource: PermissionsActionsDelegate {
  
  func didTapContinueButton() {
    self.handleContinueButton()
  }
  
  func permissionActionChange(at cell: PermissionCell) {
    
    guard let permission = cell.permission else { return }
    self.permissionActionDidChange(cell, permission)
  }
}

extension PermissionsDataSource {
  
  private func setupPermission(cell: PermissionCell, at indexPath: IndexPath) {
    let permission = self.permissionViewModel.getPermission(at: indexPath)
    cell.delegate = self
    cell.setup(permission: permission)
  }
  
  private func setupPermissionBanner(cell: PermissionBannerCell, at indexPath: IndexPath) {
    cell.setup()
  }
  
  private func setupPermissionContinue(cell: PermissionContinueCell, at indexPath: IndexPath) {
    cell.setupUI()
    cell.setupAppearance()
    cell.delegate = self
  }
}

extension PermissionsDataSource: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.permissionViewModel.numbersOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.permissionViewModel.numbersOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if !fromRootViewController {
      let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cells.permissionCell, for: indexPath) as! PermissionCell
      self.setupPermission(cell: cell, at: indexPath)
      return cell
    } else {
      switch indexPath.section {
      case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cells.permissionBannerCell, for: indexPath) as! PermissionBannerCell
        self.setupPermissionBanner(cell: cell, at: indexPath)
        return cell
      case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cells.permissionCell, for: indexPath) as! PermissionCell
        self.setupPermission(cell: cell, at: indexPath)
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cells.permissionContinueCell, for: indexPath) as! PermissionContinueCell
        self.setupPermissionContinue(cell: cell, at: indexPath)
        return cell
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let type = permissionViewModel.getPermission(at: indexPath)
    return AppDimensions.PermissionsCell.getHeightOfRow(at: type.permissionType)
  }
}
