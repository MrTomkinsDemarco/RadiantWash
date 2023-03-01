//
//  PermissionTableViewCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit

class PermissionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var permissionImageView: UIImageView!
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var subtitleTextLabel: UILabel!
  @IBOutlet weak var permissionButton: UIButton!
  private var subtitleCustomLabel = UILabel()
  
  public var permission: Permission?
  public var delegate: PermissionsActionsDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    subtitleTextLabel.isHidden = true
    subtitleCustomLabel.text = nil
    subtitleTextLabel.text = nil
  }
  
  @IBAction func didTapChangePermissionActionButton(_ sender: Any) {
    
    permissionButton.animateButtonTransform()
    delegate?.permissionActionChange(at: self)
  }
}

extension PermissionTableViewCell {
  
  public func configure(with permission: Permission) {
    
    setupUI()
    setupAppearance()
    
    self.permission = permission
    self.setButtonState(for: permission)
    permissionImageView.image = permission.permissionImage
    titleTextLabel.font = FontManager.permissionFont(of: .title)
    titleTextLabel.text = permission.permissionName
    
    subtitleTextLabel.lineBreakMode = .byWordWrapping
    
    if Screen.size == .small {
      subtitleTextLabel.isHidden = true
      subtitleCustomLabel.text = permission.permissionDescription
      subtitleCustomLabel.numberOfLines = 0
      subtitleTextLabel.textAlignment = .justified
      baseView.addSubview(subtitleCustomLabel)
      subtitleCustomLabel.translatesAutoresizingMaskIntoConstraints = false
      subtitleCustomLabel.leadingAnchor.constraint(equalTo: titleTextLabel.leadingAnchor).isActive = true
      subtitleCustomLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20).isActive = true
      subtitleCustomLabel.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: -20).isActive = true
      subtitleCustomLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 10).isActive = true
      
      subtitleCustomLabel.layoutIfNeeded()
    } else {
      subtitleTextLabel.isHidden = false
      subtitleTextLabel.text = permission.permissionDescription
    }
  }
  
  public func setButtonState(for permission: Permission) {
    
    permissionButton.setTitle(permission.buttonTitle, for: .normal)
    permissionButton.setTitleColor(permission.buttonTitleColor, for: .normal)
  }
}

extension PermissionTableViewCell: Themeble {
  
  private func setupUI() {
    
    selectionStyle = .none
    separatorInset.left = 20 + 30 + 20
    baseView.setCorner(14)
    subtitleTextLabel.font = FontManager.permissionFont(of: .subtitle)
    subtitleCustomLabel.font = FontManager.permissionFont(of: .subtitle)
    permissionButton.titleLabel?.font = FontManager.permissionFont(of: .permissionButton)
    subtitleTextLabel.sizeToFit()
  }
  
  func setupAppearance() {
    
    baseView.backgroundColor = .clear
    backgroundColor = Theme.light.cellBackGroundColor
    tintColor = Theme.light.bottomShadowColor
    titleTextLabel.textColor = theme.titleTextColor
    subtitleTextLabel.textColor = theme.subTitleTextColor
    subtitleCustomLabel.textColor = theme.subTitleTextColor
  }
}
