//
//  CurrentSubscriptionCell.swift
//  RadiantWash
//
//  Created by Mac Mini on 24.02.2023.
//

import UIKit

protocol CurrentSubscriptionChangeDelegate {
  func didTapChangeSubscription()
}

class CurrentSubscriptionCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var subtitleTextLabel: UILabel!
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var actionButton: GradientButton!
  @IBOutlet weak var changePlanView: UIView!
  
  var delegate: CurrentSubscriptionChangeDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupTitle()
    setupAppearance()
  }
  
  private func setupUI() {
    
    self.selectionStyle = .none
    
    if SettingsManager.subscripton.currentSubscriptionID == Subscriptions.lifeTime.rawValue {
      setupExpireDateSubtitle(with: Localization.Settings.Title.lifeTime, islifeTimeSubscription: true)
      changePlanView.isHidden = true
    } else {
      setupExpireDateSubtitle(with: SettingsManager.subscripton.currentExprireSubscriptionDate, islifeTimeSubscription: false)
    }
    thumbnailImageView.image = Images.subsctiption.crown!
    
    actionButton.buttonTitle = LocalizationService.Buttons.getButtonTitle(of: .changePlan)
    actionButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
    actionButton.buttonImage = I.systemItems.defaultItems.refresh
    actionButton.primaryShadowsIsActive = false
    actionButton.setupGradientActive = true
    actionButton.gradientColors = theme.changeSubscriptionbuttonGradientColors
  }
  
  private func setupTitle() {
    
    guard titleLabel.bounds != .zero else { return }
    
    let titleString = Localization.Subscription.Premium.alreadyPremium.components(separatedBy: " ")
    let firstPartTitle = titleString.first
    let secondPartTitle = titleString.last
    let colors = theme.bunneTitleGradienColors.compactMap({$0.cgColor})
    if let firstPartTitle = firstPartTitle, let secondPartTitle = secondPartTitle {
      let gradientLayer = Utils.Manager.getGradientLayer(bounds: titleLabel.bounds, colors: colors, startPoint: .topLeft, endPoint: .bottomRight)
      let gradientColors = Utils.Manager.gradientColor(bounds: titleLabel.bounds, gradientLayer: gradientLayer)
      let attributes: [NSAttributedString.Key: Any] = [.font: FontManager.subscriptionFont(of: .premimBannerTitle), .foregroundColor: gradientColors!]
      let partAttributes: [NSAttributedString.Key: Any] = [.font: FontManager.subscriptionFont(of: .premimBannerTitle), .foregroundColor: theme.titleTextColor]
      let attrubutedString: NSMutableAttributedString = .init(string: firstPartTitle, attributes: attributes)
      attrubutedString.append(NSAttributedString(string: " "))
      attrubutedString.append(NSAttributedString(string: secondPartTitle, attributes: partAttributes))
      titleLabel.attributedText = attrubutedString
    }
  }
  
  private func setupExpireDateSubtitle(with text: String, islifeTimeSubscription: Bool) {
    
    let date = text.replacingOccurrences(of: "\\", with: "/")
    
    let dateAttributes: [NSAttributedString.Key: Any] = [.font: FontManager.subscriptionFont(of: .premiumBannerDateSubtitle), .foregroundColor: theme.premiumSubtitleTextColor]
    let expireDateAttributes: [NSAttributedString.Key: Any] = [.font: FontManager.subscriptionFont(of: .permiumBannerSubtitle), .foregroundColor: theme.premiumSubtitleTextColor]
    
    var attributedString: NSMutableAttributedString {
      if islifeTimeSubscription {
        let string = NSMutableAttributedString(string: Localization.Subscription.Premium.currentSubscription, attributes: expireDateAttributes)
        string.append(NSAttributedString(string: " "))
        string.append(NSAttributedString(string: text, attributes: dateAttributes))
        return string
      } else {
        let string = NSMutableAttributedString(string: Localization.Subscription.Premium.expireSubscription, attributes: expireDateAttributes)
        string.append(NSAttributedString(string: " "))
        string.append(NSAttributedString(string: date, attributes: dateAttributes))
        return string
      }
    }
    
    debugPrint(attributedString)
    subtitleTextLabel.attributedText = attributedString
  }
  
  public func setup(model: CurrentSubscriptionModel) {
    
    switch model.subscription {
      
    case .lifeTime:
      setupExpireDateSubtitle(with: Localization.Settings.Title.lifeTime, islifeTimeSubscription: true)
    default:
      setupExpireDateSubtitle(with: model.expireDate, islifeTimeSubscription: false)
    }
  }
  
  @IBAction func didTapActionButton(_ sender: Any) {
    delegate?.didTapChangeSubscription()
  }
}

extension CurrentSubscriptionCell: Themeble {
  
  func setupAppearance() {
    
    backgroundColor = Theme.light.cellBackGroundColor
    thumbnailImageView.tintColor = theme.cellShadowBackgroundColor
    actionButton.setTitleColor(theme.activeTitleTextColor, for: .normal)
    actionButton.buttonTintColor = theme.activeTitleTextColor
  }
}
