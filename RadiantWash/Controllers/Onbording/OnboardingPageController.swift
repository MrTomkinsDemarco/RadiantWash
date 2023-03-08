//
//  OnboardingPageController.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit
import Lottie

class OnboardingPageController: UIViewController {
  
  @IBOutlet weak var animationView: LottieAnimationView!
  @IBOutlet weak var thumbnailView: UIImageView!
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var subtitleTextLabel: UILabel!
  @IBOutlet weak var thumbnailsCenterConstraint: NSLayoutConstraint!
  @IBOutlet weak var thumbnailWidthConstraint: NSLayoutConstraint!
  
  public var delegate: OnboardingControllDelegate?
  
  var onboarding: Onboarding?
  var sceneTitle: String?
  var currentIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupOnboarding()
    setupUI()
    setupAppearance()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    animationView.play()
    delegate?.didUpdatePageIndicator(with: self.currentIndex)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    animationView.stop()
  }
  
  private func setupUI() {
    
    animationView.isHidden = true
    
    titleTextLabel.font = FontManager.onboardingFont(of: .title)
    subtitleTextLabel.font = FontManager.onboardingFont(of: .subtitle)
    
    titleTextLabel.textAlignment = .center
    subtitleTextLabel.textAlignment = .center
    
    switch Screen.size {
      
    case .small:
      thumbnailWidthConstraint = thumbnailWidthConstraint.setMultiplier(multiplier: 0.7)
      thumbnailsCenterConstraint = thumbnailsCenterConstraint.setMultiplier(multiplier: 0.5)
    case .medium:
      thumbnailWidthConstraint = thumbnailWidthConstraint.setMultiplier(multiplier: 0.7)
      thumbnailsCenterConstraint = thumbnailsCenterConstraint.setMultiplier(multiplier: 0.5)
    case .plus:
      thumbnailsCenterConstraint = thumbnailsCenterConstraint.setMultiplier(multiplier: 0.6)
    default:
      thumbnailsCenterConstraint = thumbnailsCenterConstraint.setMultiplier(multiplier: 0.75)
    }
  }
  
  private func setupOnboarding() {
    
    guard let onboarding = onboarding else { return }
    
    if let index = Onboarding.allCases.firstIndex(of: onboarding) {
      self.currentIndex = index
    }
    
    sceneTitle = onboarding.rawValue
    titleTextLabel.text = onboarding.title
    subtitleTextLabel.text = onboarding.description
    animationView.animation = LottieAnimation.named(onboarding.animationName)
    animationView.loopMode = .loop
    animationView.backgroundBehavior = .pauseAndRestore
    
    thumbnailView.image = onboarding.thumbnail
  }
}

extension OnboardingPageController: Themeble {
  
  func setupAppearance() {
    
    self.view.backgroundColor = .clear
    titleTextLabel.textColor = theme.titleTextColor
    subtitleTextLabel.textColor = theme.onboardingSubTitleTextColor
  }
}
