//
//  ContentBannerCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 24.02.2023.
//

import UIKit

class ContentBannerCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var reuseImageView: UIImageView!
  @IBOutlet weak var titleContainerStackView: UIStackView!
  @IBOutlet weak var descriptionContainerStackView: UIStackView!
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var subtitleTextLabel: UILabel!
  @IBOutlet weak var descriptionTitleTextLabel: UILabel!
  @IBOutlet weak var descriptionSubtitleTextLabel: UILabel!
  @IBOutlet var descriptionTextLabelsCollection: [UILabel]!
  @IBOutlet weak var helperImageViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var helperImageViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var helperImageViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var helperImageViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var helperImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  private func setupUI() {
    
    selectionStyle = .none
    baseView.setCorner(14)
    titleTextLabel.textAlignment = .left
    subtitleTextLabel.textAlignment = .left
    descriptionTitleTextLabel.textAlignment = .right
    descriptionSubtitleTextLabel.textAlignment = .right
    titleTextLabel.font = FontManager.bannerFont(of: .title)
    subtitleTextLabel.font = FontManager.bannerFont(of: .subititle)
    descriptionTitleTextLabel.font = FontManager.bannerFont(of: .descriptionTitle)
  }
  
  public func setup(content: PhotoMediaType) {
    
    let info = content.bannerInfo.info[content]!
    
    let gradientColors = info.gradientColors.compactMap({$0.cgColor})
    
    let gradientLayer = Utils.Manager.getGradientLayer(bounds: descriptionSubtitleTextLabel.bounds,
                                                       colors: gradientColors,
                                                       startPoint: .topLeft, endPoint: .bottomRight)
    let gradientColor = Utils.Manager.gradientColor(bounds: descriptionSubtitleTextLabel.bounds, gradientLayer: gradientLayer)
    let firstSubtitleAttributes: [NSAttributedString.Key : Any] = [.font: FontManager.bannerFont(of: .descriptionFirstTitle),
                                                                   .foregroundColor: gradientColor!]
    let secondSubtitleAttributes: [NSAttributedString.Key : Any] = [.font: FontManager.bannerFont(of: .descriptionSecontTitle),
                                                                    .foregroundColor: gradientColor!]
    let attributedString = NSMutableAttributedString(string: info.descriptionFirstPartSubtitle, attributes: firstSubtitleAttributes)
    attributedString.append(NSAttributedString(string: " ", attributes: secondSubtitleAttributes))
    attributedString.append(NSAttributedString(string: info.descriptionSecondPartSubtitle, attributes: secondSubtitleAttributes))
    
    descriptionSubtitleTextLabel.attributedText = attributedString
    
    var titleGradientStartPoint: CAGradientPoint {
      switch content {
      case .locationPhoto:
        return .topCenter
      case .compress:
        return .topLeft
      case .backup:
        return .topLeft
      default:
        return .topLeft
      }
    }
    
    var titleGradientEndPoint: CAGradientPoint {
      switch content {
      case .locationPhoto:
        return .bottomCenter
      case .compress:
        return .bottomRight
      case .backup:
        return .bottomRight
      default:
        return .bottomRight
      }
    }
    
    let gradientLayerTitle = Utils.Manager.getGradientLayer(bounds: descriptionTitleTextLabel.bounds,
                                                            colors: gradientColors,
                                                            startPoint: titleGradientStartPoint, endPoint: titleGradientEndPoint)
    let gradientTitleColor = Utils.Manager.gradientColor(bounds: descriptionTitleTextLabel.bounds, gradientLayer: gradientLayerTitle)
    descriptionTitleTextLabel.textColor = gradientTitleColor
    titleTextLabel.text = info.title
    subtitleTextLabel.text = info.subtitle
    descriptionTitleTextLabel.text = info.descriptionTitle
    descriptionTextLabelsCollection.forEach {
      $0.layer.applyShadow(color: theme.bottomShadowColor, alpha: 0.6, x: 6, y: 6, blur: 12, spread: 0)
    }
    
    reuseImageView.image = info.infoImage
    helperImageView.image = info.helperImage
    helperImageView.contentMode = .scaleToFill
    
    switch content {
    case .locationPhoto:
      setupHelperImage(target: AppDimensions.HelperBanner.offsetHelperImageSize, image: info.helperImage)
      helperImageViewTrailingConstraint.constant = 25
      helperImageViewBottomConstraint.constant = -10
    case .compress:
      setupHelperImage(target: AppDimensions.HelperBanner.cornerHelperImageSize, image: info.helperImage)
      helperImageViewTrailingConstraint.constant = 0
    case .backup:
      setupHelperImage(target: AppDimensions.HelperBanner.offsetHelperImageSize, image: info.helperImage)
      helperImageViewTrailingConstraint.constant = 15
    default:
      return
    }
  }
  
  private func setupHelperImage(target: CGFloat, image: UIImage) {
    
    let targetSize = CGSize(width: target, height: target)
    let helperImageSize = image.getPreservingAspectRationScaleImageSize(from: targetSize)
    helperImageViewWidthConstraint.constant = helperImageSize.width
    helperImageViewHeightConstraint.constant = helperImageSize.height
  }
}

extension ContentBannerCell: Themeble {
  
  func setupAppearance() {
    
    baseView.backgroundColor = Theme.light.cellBackGroundColor
    reuseImageView.tintColor = theme.cellShadowBackgroundColor
    titleTextLabel.textColor = theme.titleTextColor
    subtitleTextLabel.textColor = theme.subTitleTextColor
  }
}
