//
//  PhotoCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 23.02.2023.
//

import UIKit
import Photos

protocol PhotoCellDelegate {
  func didShowFullScreenPHasset(at cell: PhotoCell)
  func didSelect(cell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
  
  @IBOutlet weak var baseView: UIView!
  
  @IBOutlet weak var selectableView: UIView!
  @IBOutlet weak var circleSelectThumbView: UIView!
  @IBOutlet weak var bulbview: UIView!
  
  @IBOutlet weak var photoThumbnailImageView: UIImageView!
  @IBOutlet weak var photoCheckmarkImageView: UIImageView!
  @IBOutlet weak var buttonView: UIButton!
  @IBOutlet weak var bestView: UIView!
  @IBOutlet weak var bestLabel: UILabel!
  
  @IBOutlet weak var videoAssetDurationView: UIView!
  @IBOutlet weak var videoAssetDurationTextLabel: UILabel!
  
  @IBOutlet weak var playPhassetImageView: UIImageView!
  @IBOutlet weak var selectCellButtonWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var selectCellButtonHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var reuseTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var reuseLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var reuseTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var reuseBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var videoDurationViewWidthConstraint: NSLayoutConstraint!
  
  @IBOutlet var thumbnailViewOffsetConstraint: [NSLayoutConstraint]!
  
  private var selectButtonSize = AppDimensions.CollectionItemSize.cellSelectRectangleSize
  public var collectionType: CollectionType = .none
  public var indexPath: IndexPath?
  public var cellMediaType: PhotoMediaType = .none
  public var cellContentType: MediaContentType = .none
  private var imageManager: PHCachingImageManager?
  private var imageRequestID: PHImageRequestID?
  
  public var carouselCollectionCellIsPlaying: Bool = false {
    didSet {
      setupDidPlaying()
    }
  }
  
  var delegate: PhotoCellDelegate?
  var requestedAssetIdentifier: NSNumber?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    photoCheckmarkImageView.image = I.systemElementsItems.circleBox
    unload()
  }
  
  override var isSelected: Bool {
    didSet {
      self.checkIsSelected()
    }
  }
  
  public func setupUI() {
    
    setCorner(6)
    contentView.setCorner(8)
    
    bestView.setCorner(11)
    bestLabel.font = .systemFont(ofSize: 10, weight: .bold)
    
    baseView.setCorner(14)
    photoThumbnailImageView.setCorner(10)
    photoThumbnailImageView.contentMode = .scaleAspectFill
    
    circleSelectThumbView.rounded()
    bulbview.rounded()
    
    photoCheckmarkImageView.image = I.systemElementsItems.circleBox
    videoAssetDurationView.setCorner(6)
    setupLayout()
    
    switch cellMediaType {
    case .similarPhotos, .duplicatedPhotos, .duplicatedVideos, .similarVideos, .similarSelfies:
      reuseTopConstraint.constant = 6
      reuseBottomConstraint.constant = 6
      reuseLeadingConstraint.constant = 6
      reuseTrailingConstraint.constant = 6
      baseView.layoutIfNeeded()
    case .locationPhoto:
      buttonView.isHidden = true
    default:
      debugPrint("")
    }
  }
  
  private func setupLayout() {
    
    switch collectionType {
    case .grouped:
      indexPath?.row == 0 ? defaultOffset() : getOffset()
    case .carousel:
      getOffset()
    default:
      defaultOffset()
    }
  }
  
  private func getOffset() {
    
    switch Screen.size {
    case .small:
      self.setupOffset(4)
    case .medium:
      self.setupOffset(5)
    case .plus:
      self.setupOffset(6)
    default:
      self.defaultOffset()
    }
  }
  
  private func defaultOffset() {
    self.setupOffset(7)
  }
  
  private func setupOffset(_ offset: CGFloat) {
    
    self.thumbnailViewOffsetConstraint.forEach {
      $0.constant = offset
    }
  }
  
  public func setupSelectButton(by contentType: PhotoMediaType, isBatchSelect: Bool = false, isNewConpress: Bool = false) {
    
    switch contentType {
    case .duplicatedVideos, .similarVideos, .similarPhotos, .duplicatedPhotos, .similarSelfies:
      if indexPath?.row != 0 {
        setupBestView(availible: false)
        setupSelectable(availible: true)
      } else {
        setupSelectable(availible: false)
        setupBestView(availible: true)
        setupBestView()
      }
    case .compress:
      setupBestView(availible: false)
      setupBestViewForNewPHasset(availible: isNewConpress)
      setupSelectable(availible: isBatchSelect)
    default:
      setupBestView(availible: false)
      setupSelectable(availible: true)
    }
    buttonView.layoutIfNeeded()
  }
  
  private func setupDidPlaying() {
    
    guard self.cellContentType == .userVideo else { return }
    playPhassetImageView.animateButtonTransform()
    
    UIView.animate(withDuration: 2, delay: 0) {
      self.playPhassetImageView.image = self.carouselCollectionCellIsPlaying ? I.player.templatePause : I.player.templatePlay
    } completion: { _ in
      U.delay(self.carouselCollectionCellIsPlaying ? 1 : 0) {
        self.playPhassetImageView.isHidden = self.carouselCollectionCellIsPlaying
      }
    }
  }
  
  public func loadThumbnail(_ asset: PHAsset, imageManager: PHCachingImageManager, size: CGSize) {
    
    unload()
    
    self.imageManager = imageManager
    
    let options = PhotoManager.shared.requestOptions
    
    imageRequestID = imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options, resultHandler: { image, info in
      
      if let index = self.indexPath, self.tag == index.section * 1000 + index.row {
        if let loadedImage = image {
          self.photoThumbnailImageView.image = loadedImage
        }
      } else {
        self.photoThumbnailImageView.image = nil
      }
    })
    
    playPhassetImageView.image = I.player.templatePlay
    playPhassetImageView.alpha = 0.8
    
    switch cellMediaType {
    case .duplicatedVideos, .similarVideos:
      if asset.mediaType == .video {
        let duration = CMTime(seconds: asset.duration, preferredTimescale: 1000000)
        videoAssetDurationTextLabel.text = duration.durationText
        setupDurationView(isAvailible: true)
        setupPlayButtonView(isAvailible: true)
      }
    case .duplicatedPhotos, .similarPhotos, .similarSelfies, .similarLivePhotos:
      setupDurationView(isAvailible: false)
      setupPlayButtonView(isAvailible: false)
    case .singleScreenRecordings, .singleRecentlyDeletedVideos, .singleLargeVideos, .compress:
      if asset.mediaType == .video {
        let duration = CMTime(seconds: asset.duration, preferredTimescale: 1000000)
        setupDurationView(isAvailible: true)
        videoAssetDurationTextLabel.text = duration.durationText
        setupPlayButtonView(isAvailible: true)
      }
    default:
      setupDurationView(isAvailible: false)
      setupPlayButtonView(isAvailible: false)
    }
  }
  
  private func setupDurationView(isAvailible: Bool) {
    
    videoAssetDurationTextLabel.isHidden = !isAvailible
    videoAssetDurationView.isHidden = !isAvailible
    baseView.layoutIfNeeded()
    
    videoDurationViewWidthConstraint.constant = {
      let containerWidth = baseView.frame.width
      if isAvailible {
        switch collectionType {
        case .carousel:
          return containerWidth / 2.5
        case .grouped:
          return containerWidth / (indexPath?.row == 0 ? 3 : 2)
        case .single:
          switch self.cellMediaType {
          case .singleScreenRecordings:
            return containerWidth / 2.4
          case .singleLargeVideos:
            return containerWidth / 4
          default:
            return containerWidth / 4
          }
        default:
          return 0
        }
      } else {
        return 0
      }
    }()
  }
  
  private func setupPlayButtonView(isAvailible: Bool) {
    
    playPhassetImageView.isHidden = !isAvailible
  }
  
  public func setupBestView(availible: Bool = false) {
    
    bestLabel.text = Localization.Main.Subtitles.best.uppercased()
    bestView.isHidden = !availible
  }
  
  private func setupBestViewForNewPHasset(availible: Bool = false) {
    
    bestLabel.text = Localization.Main.Subtitles.new.uppercased()
    availible ? setupBestView() : ()
    bestView.isHidden = !availible
  }
  
  public func setupBestView() {
    
    let bestViewGradientMask: CAGradientLayer = CAGradientLayer()
    bestViewGradientMask.frame = CGRect(x: 0, y: 0, width: bestView.frame.width, height: bestView.frame.height)
    bestViewGradientMask.colors = self.cellContentType.screeAcentGradientColorSet
    bestViewGradientMask.startPoint = CGPoint(x: 0.0, y: 0.0)
    bestViewGradientMask.endPoint = CGPoint(x: 0.0, y: 1.0)
    bestView.layer.addSublayer(bestViewGradientMask)
    bestView.bringSubviewToFront(bestLabel)
  }
  
  public func setupSelectable(availible: Bool = true) {
    
    selectableView.isHidden = !availible
    selectCellButtonWidthConstraint.constant = availible ? selectButtonSize : 0
    selectCellButtonHeightConstraint.constant = availible ? selectButtonSize : 0
  }
  
  public func unload() {
    
    photoThumbnailImageView.image = nil
    
    if imageRequestID != nil && imageManager != nil {
      imageManager!.cancelImageRequest(imageRequestID!)
    }
    
    imageRequestID = nil
    imageManager = nil
  }
  
  public func checkIsSelected() {
    
    photoCheckmarkImageView.image = self.isSelected ? cellContentType.selectableAssetsCheckMark : nil
  }
  
  @IBAction func didTapShowPHassetActionButton(_ sender: Any) {
    delegate?.didShowFullScreenPHasset(at: self)
  }
  
  @IBAction func didTapSetSelectedCellActionButton(_ sender: Any) {
    delegate?.didSelect(cell: self)
  }
}

extension PhotoCell: Themeble {
  
  func setupAppearance() {
    
    baseView.backgroundColor = theme.backgroundColor
    photoCheckmarkImageView.tintColor = theme.accentBackgroundColor
    playPhassetImageView.tintColor = theme.backgroundColor
    
    bestLabel.textColor  = theme.activeTitleTextColor
    videoAssetDurationView.backgroundColor = theme.subTitleTextColor
    videoAssetDurationTextLabel.textColor = theme.activeTitleTextColor
    videoAssetDurationTextLabel.font = .systemFont(ofSize: 10, weight: .bold)
    videoAssetDurationTextLabel.adjustsFontSizeToFitWidth = true
    videoAssetDurationTextLabel.minimumScaleFactor = 0.2
    videoAssetDurationTextLabel.textAlignment = .center
    videoAssetDurationTextLabel.baselineAdjustment = .alignCenters
    circleSelectThumbView.backgroundColor = theme.cellBackGroundColor
    bulbview.backgroundColor = cellContentType.screenAcentTintColor
  }
}
