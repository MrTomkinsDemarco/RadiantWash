//
//  ApplicationStartupState+Web.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

enum WebLink {
  
  case privacy
  case terms
  case contact
  
  var url: URL {
    switch self {
      case .privacy:
        return URL(string: Constants.web.policy)!
      case .terms:
        return URL(string: Constants.web.terms)!
      case .contact:
        return URL(string: Constants.web.contact)!
    }
  }
  
  var title: String {
    switch self {
      case .privacy:
        return Localization.Settings.Title.privacy
      case .terms:
        return Localization.Settings.Title.terms
      case .contact:
        return Localization.Settings.Title.support
    }
  }
}

extension ApplicationCoordinator {
  
  public func showWebLink(of webLink: WebLink, from viewController: UIViewController?, navigationController: UINavigationController?, presentedtype: PresentedType) {
    
    let webController = WebController.instantiate(type: .web)
    webController.coordinator = self
    webController.presentationType = presentedtype
    webController.url = webLink.url
    webController.title = webLink.title
    
    switch presentedtype {
      case .push:
        navigationController?.pushViewController(webController, animated: true)
      case .present:
        webController.modalPresentationStyle = .fullScreen
        viewController?.present(webController, animated: true)
    }
  }
  
  public func closeWeb(controller: WebController, navigation: UINavigationController?) {
    
    switch controller.presentationType {
      case .present:
        controller.dismiss(animated: true)
      case .push:
        navigation?.popViewController(animated: true)
    }
  }
}
