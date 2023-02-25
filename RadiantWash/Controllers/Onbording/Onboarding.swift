//
//  Onboarding.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

enum Onboarding: CaseIterable {
  
  case photo
  case video
  case contacts
  
  var rawValue: String {
    switch self {
    case .photo:
      return Constants.identifiers.onboarding.photo
    case .video:
      return Constants.identifiers.onboarding.video
    case .contacts:
      return Constants.identifiers.onboarding.contacts
    }
  }
  
  var title: String {
    switch self {
    case .photo:
      return Localization.Onboarding.Title.photo
    case .video:
      return Localization.Onboarding.Title.video
    case .contacts:
      return Localization.Onboarding.Title.contacts
    }
  }
  
  var description: String {
    switch self {
    case .photo:
      return Localization.Onboarding.Description.photo
    case .video:
      return Localization.Onboarding.Description.video
    case .contacts:
      return Localization.Onboarding.Description.contacts
    }
  }
  
  var animationName: String {
    switch self {
    case .photo:
      return Images.onboardingAnimation.photo
    case .video:
      return Images.onboardingAnimation.video
    case .contacts:
      return Images.onboardingAnimation.contacts
    }
  }
  
  var thumbnail: UIImage {
    switch self {
    case .photo:
      return Images.onboarding.photo
    case .video:
      return Images.onboarding.video
    case .contacts:
      return Images.onboarding.contacts
    }
  }
}
