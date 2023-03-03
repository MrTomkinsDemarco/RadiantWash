//
//  ContentTypeCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit
import Photos

protocol ContentTypeCellDelegate {
  func setCancelProcessOperaion(for cell: ContentTypeCell)
}

class ContentTypeCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var rightArrowImageView: UIImageView!
  @IBOutlet weak var contentImageView: UIImageView!
  @IBOutlet weak var contentTypeTextLabel: UILabel!
  @IBOutlet weak var contentSubtitleTextLabel: UILabel!
  @IBOutlet weak var horizontalProgressView: HorizontalProgressBar!
  @IBOutlet weak var operationActionButton: UIButton!
  
  public var delegate: ContentTypeCellDelegate?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    superPrepareForReuse()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  func setupUI() {
    
    selectionStyle = .none
    separatorInset.left = 20 + 30 + 20
    rightArrowImageView.isHidden = true
    self.operationActionButton.isEnabled = false
    contentTypeTextLabel.font = FontManager.contentTypeFont(of: .title)
    contentSubtitleTextLabel.font = FontManager.contentTypeFont(of: .subtitle)
  }
  
  private func superPrepareForReuse() {
    
    contentTypeTextLabel.text = nil
    contentSubtitleTextLabel.text = nil
    
    horizontalProgressView.progress = 0
    horizontalProgressView.setNeedsDisplay()
    contentImageView.image = nil
    rightArrowImageView.isHidden = true
  }
  
  public func handleSelectedDeletedPHassets(content type: MediaContentType, isCompleted: Bool, isSelected: Bool) {
    
    let processingCellImage = isSelected ? type.selectableAssetsCheckMark : isCompleted ? type.imageOfRows : type.unAbleImageOfRows
    self.contentImageView.image = processingCellImage
  }
  
  public func setupDataSettings(with settings: SettingsModel) {
    
    self.contentTypeTextLabel.text = settings.settingsTitle
    self.contentImageView.image = settings.settingsImages
    self.contentSubtitleTextLabel.isHidden = true
  }
  
  @IBAction func stopOperationActionButton(_ sender: Any) {
    delegate?.setCancelProcessOperaion(for: self)
  }
}

extension ContentTypeCell {
    
    /**
     - `deepCleanCellConfigure`use for default cell config
     - `handleDeepCellState` use in deep cleaning part for show selected checkmark for clean or state
    */
  
  public func setupDataSingleClean(with model: SingleCleanStateModel, mediaType: PhotoMediaType = .none, indexPath: IndexPath, for groupProcessing: Bool) {
    
    let mainTitle = model.mediaType.contenType.getCellTitle(index: indexPath.row)
    self.contentTypeTextLabel.text = mainTitle
    
    let subTitle = model.cleanState.getTitle(by: model.mediaType, files: model.resultCount, selected: 0, progress: model.cleanProgress)
    contentSubtitleTextLabel.text = subTitle
    
    self.handleSingleCellState(with: model.cleanState, model: model, for: groupProcessing)
  }
  
  public func setupDataDeepClean(with model: DeepCleanStateModel, mediaType: PhotoMediaType = .none, indexPath: IndexPath) {
  
    let mainTitle = model.mediaType.contenType.getDeepCellTitle(index: indexPath.row)
    self.contentTypeTextLabel.text = mainTitle
    
    let subTitle = model.cleanState.getTitle(by: model.mediaType, files: model.resultsCount, selected: model.selectedContentCount(), progress: model.deepCleanProgress)
    contentSubtitleTextLabel.text = subTitle
    
    self.handleDeepCellState(with: model.cleanState, model: model)
  }
  
  private func handleDeepCellState(with state: ProcessingProgressOperationState, model: DeepCleanStateModel) {
    
    let selectedImage = model.mediaType.contenType.selectableAssetsCheckMark
    let disabledImage = model.mediaType.contenType.unAbleImageOfRows
    let activeImage = model.mediaType.contenType.imageOfRows
    let processingImage = model.mediaType.contenType.processingImageOfRows
    
    self.horizontalProgressView.state = model.cleanState
    
    switch model.cleanState {
      case .sleeping:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = disabledImage
        self.resetProgress()
      case .prepare:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.resetProgress()
      case .analyzing:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.resetProgress()
      case .compare:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.setProgress(model.deepCleanProgress)
      case .progress:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.setProgress(model.deepCleanProgress)
      case .result:
        self.handleRightArrowState(false)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = activeImage
        self.setProgress(100)
      case .complete:
        self.handleRightArrowState(!model.isEmpty)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = model.isEmpty ? disabledImage : activeImage
        self.resetProgress()
      case .empty:
        self.handleRightArrowState(false)
      self.contentImageView.image = disabledImage
//        self.reuseShadowRoundedView.hideIndicator()
        self.resetProgress()
      case .selected:
        self.handleRightArrowState(model.isEmpty)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = selectedImage
        self.resetProgress()
    }
  }
  
  private func handleSingleCellState(with state: ProcessingProgressOperationState, model: SingleCleanStateModel, for groupProcessing: Bool) {
    
    let selectedImage = model.mediaType.contenType.selectableAssetsCheckMark
    let disabledImage = model.mediaType.contenType.unAbleImageOfRows
    let activeImage = model.mediaType.contenType.imageOfRows
    let processingImage = model.mediaType.contenType.processingImageOfRows
    
    self.horizontalProgressView.state = model.cleanState
    self.handleTouchOperationCell(for: model, contentType: model.mediaType.contenType, for: groupProcessing)
    switch model.cleanState {
      case .sleeping:
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = disabledImage
        self.resetProgress()
      case .prepare:
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.resetProgress()
      case .analyzing:
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.resetProgress()
      case .compare:
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.setProgress(model.cleanProgress)
      case .progress:
//        self.reuseShadowRoundedView.showIndicator()
      self.contentImageView.image = processingImage
        self.setProgress(model.cleanProgress)
      case .result:
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = activeImage
        self.setProgress(100)
      case .complete:
        self.handleRightArrowState(!model.isEmpty)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = model.isEmpty ? disabledImage : activeImage
        self.resetProgress()
      case .empty:
      self.contentImageView.image = disabledImage
//        self.reuseShadowRoundedView.hideIndicator()
        self.resetProgress()
      case .selected:
        self.handleRightArrowState(model.isEmpty)
//        self.reuseShadowRoundedView.hideIndicator()
      self.contentImageView.image = selectedImage
        self.resetProgress()
    }
  }
}

extension ContentTypeCell {
  
  public func resetProgress() {
    self.horizontalProgressView.resetProgressLayer()
  }
  
  private func setProgress(_ progress: CGFloat) {
    self.horizontalProgressView.progress = progress / 100
    self.horizontalProgressView.layoutIfNeeded()
  }
  
  private func completedProgress() {
    self.horizontalProgressView.progress = 0
    self.horizontalProgressView.layoutIfNeeded()
    self.resetProgress()
  }
  
  private func handleRightArrowState(_ show: Bool) {
    self.rightArrowImageView.isHidden = !show
  }
  
  private func handleTouchOperationCell(for model: SingleCleanStateModel, contentType: MediaContentType, for groupProcessing: Bool) {
    let state = model.cleanState
    switch state {
      case .complete, .selected:
        self.rightArrowImageView.isHidden = model.isEmpty
        self.rightArrowImageView.image = I.systemItems.navigationBarItems.forward
        self.operationActionButton.isEnabled = false
        self.rightArrowImageView.transform = .identity
      case .sleeping, .empty, .compare:
        self.rightArrowImageView.isHidden = true
        self.rightArrowImageView.image = nil
        self.operationActionButton.isEnabled = false
        self.rightArrowImageView.transform = .identity
      case .prepare, .analyzing, .progress:
        guard !groupProcessing else { return}
        self.operationActionButton.isEnabled = true
        self.rightArrowImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.rightArrowImageView.isHidden = false
        self.rightArrowImageView.image = I.systemItems.navigationBarItems.stopMagic
        self.rightArrowImageView.tintColor = contentType.screenAcentTintColor
      case .result:
        self.rightArrowImageView.transform = .identity
        self.operationActionButton.isEnabled = false
        self.rightArrowImageView.isHidden = false
        self.rightArrowImageView.image = I.systemItems.navigationBarItems.forward
        self.rightArrowImageView.tintColor = nil
    }
  }
}

extension ContentTypeCell: Themeble {
  
  func setupAppearance() {
    self.backgroundColor = Theme.light.cellBackGroundColor
    self.tintColor = Theme.light.bottomShadowColor
    contentTypeTextLabel.textColor = theme.titleTextColor
    contentSubtitleTextLabel.textColor = theme.subTitleTextColor
    horizontalProgressView.progressColor = theme.progressBackgroundColor
  }
}
