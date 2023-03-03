//
//  CompressionSettingsCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit
import Photos

class CompressionSettingsCell: UITableViewCell {
  
  @IBOutlet weak var reuseImageView: UIImageView!
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var subtitleTetLabel: UILabel!
  
  private var videoManager = VideoCompressionManager.insstance
  
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
    
    checkSelected()
  }
  
  private func setupUI() {
    
    self.selectionStyle = .none
    self.baseView.setCorner(14)
    
    self.titleTextLabel.font = FontManager.contentTypeFont(of: .title)
    self.subtitleTetLabel.font = FontManager.contentTypeFont(of: .subtitle)
  }
  
  private func superPrepareForReuse() {
    
    self.reuseImageView.image = nil
    self.titleTextLabel.text = nil
    self.subtitleTetLabel.text = nil
  }
  
  public func setup(model: ComprssionModel, phasset: PHAsset?) {
    
    titleTextLabel.text = model.compressionTitle
    
    if let phasset = phasset {
      if model == .custom(fps: 0, bitrate: 0, scale: .zero) {
        let configuration = model.getCustomCongfiguration()
        let resolution = model.getVideoResolution(from: configuration.scaleResolution, isPortrait: phasset.isPortrait)
        let fps = model.getFPS(from: configuration.fps)
        
        let origin = CGSize(width: CGFloat(phasset.pixelWidth), height: CGFloat(phasset.pixelHeight))
        let size = videoManager.calculateFutureConvertedSize(from: phasset.isPortrait ? resolution.resolutionSizePortrait : resolution.resolutionSize , originalSize: origin)
        
        let originResolutionStringText = U.getReadableResulotion(from: size)
        subtitleTetLabel.text = "\(originResolutionStringText), \(fps.name)"
      } else {
        let origin = CGSize(width: phasset.pixelWidth, height: phasset.pixelHeight)
        let size = videoManager.calculateSize(with: model, originalSize: origin)
        let calculatedFutureSize = VideoCompressionManager.insstance.calculateFutureConvertedSize(from: size, originalSize: origin)
        let readableSize = U.getReadableResulotion(from: calculatedFutureSize)
        let originResolutionStringText = readableSize
        subtitleTetLabel.text = "\(originResolutionStringText), \(Int(model.preSavedValues.fps)) FPS"
      }
    } else {
      subtitleTetLabel.text = model.compressionSubtitle
    }
  }
  
  private func checkSelected() {
    
    let selectedImage = self.isSelected ? I.personalisation.video.selected : I.personalisation.video.unselected
    reuseImageView.image = selectedImage
  }
}

extension CompressionSettingsCell: Themeble {
  
  func setupAppearance() {
    
    self.backgroundColor = Theme.light.cellBackGroundColor
    self.tintColor = Theme.light.bottomShadowColor
    titleTextLabel.textColor = theme.titleTextColor
    subtitleTetLabel.textColor = theme.subTitleTextColor
  }
}
