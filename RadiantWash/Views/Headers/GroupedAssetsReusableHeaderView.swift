//
//  GroupedAssetsReusableHeaderView.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

class GroupedAssetsReusableHeaderView: UICollectionReusableView {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var currentAssetsDate: UILabel!
  @IBOutlet weak var deleteSelectedButton: CustomButtonWithImage!
  @IBOutlet weak var selectAllButton: CustomButton!
  
  public var indexPath: IndexPath?
  public var onSelectAll: (() -> Void)?
  public var onDeleteSelected: (() -> Void)?
  
  public var mediaContentType: MediaContentType = .none
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    currentAssetsDate.text = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  @IBAction func didTapDeleteSelectedAssetsActionButton(_ sender: CustomButtonWithImage) {
    deleteSelectedButton.animateButtonTransform()
    onDeleteSelected?()
  }
  
  @IBAction func didTapSelectAllActionButton(_ sender: CustomButton) {
    selectAllButton.animateButtonTransform()
    onSelectAll?()
  }
}

extension GroupedAssetsReusableHeaderView: Themeble {
  
  public func setupUI() {
    
    let deletedText = LocalizationService.Buttons.getButtonTitle(of: .deleteSelected).uppercased()
    let image = I.systemItems.defaultItems.trashBin
    deleteSelectedButton.contentType = mediaContentType
    selectAllButton.contentType = mediaContentType
    deleteSelectedButton.setupMainButton(text: deletedText, image: image)
    
    deleteSelectedButton.setButtonFont(FontManager.collectionElementsFont(of: .buttons))
    currentAssetsDate.font = FontManager.collectionElementsFont(of: .title)
    currentAssetsDate.textColor = theme.helperTitleTextColor
  }
  
  public func handleSelectableAsstes(to select: Bool) {
    
    let handledImage = !select ? I.systemItems.selectItems.circleMark : I.systemItems.selectItems.roundedCheckMark
    selectAllButton.setupImage(handledImage, enabled: select)
  }
  
  public func handleDeleteAssets(to select: Bool) {
    
    deleteSelectedButton.setupAppearance(for: select)
    deleteSelectedButton.isEnabled = select
  }
  
  public func setGroupDate(_ date: Date?) {
    
    if let date = date {
      let headerTitle = Date().convertDateFormatterFromDate(date: date, format: C.dateFormat.monthDateYear)
      currentAssetsDate.text = headerTitle
    } else {
      currentAssetsDate.text = "-"
    }
  }
  
  public func setupAppearance() {}
}
