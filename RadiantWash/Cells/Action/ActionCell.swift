//
//  ActionCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

enum CellActionButton {
  
  case deleteContact
  
  var font: UIFont {
    switch self {
    case .deleteContact:
      return FontManager.contentTypeFont(of: .title)
    }
  }
  
  var title: String {
    switch self {
    case .deleteContact:
      return LocalizationService.Buttons.getButtonTitle(of: .delete)
    }
  }
  
  var tintColor: UIColor {
    switch self {
    case .deleteContact:
      return .red
    }
  }
}

protocol ActionTableCellDelegate {
  func didTapActionButton(at cell: ActionCell)
}

class ActionCell: UITableViewCell {
  
  @IBOutlet weak var actionButton: UIButton!
  
  public var delegate: ActionTableCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.selectionStyle = .none
  }
  
  public func setupButton(with button: CellActionButton) {
    
    actionButton.titleLabel?.font = button.font
    actionButton.tintColor = button.tintColor
    actionButton.setTitle(button.title, for: .normal)
  }
  
  @IBAction func didTapActionButtoon(_ sender: Any) {
    actionButton.animateButtonTransform()
    delegate?.didTapActionButton(at: self)
  }
}
