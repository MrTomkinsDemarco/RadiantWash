//
//  AdvertisementController.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit
import GoogleMobileAds

class AdvertisementController: UIViewController {
  
  @IBOutlet weak var advertisementView: UIView!
  @IBOutlet weak var advertisementHightConstraint: NSLayoutConstraint!
  @IBOutlet weak var advertisementBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
  
  private var subscriptionManager = SubscriptionManager.instance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupHandleAdvertisement()
    setupAppearance()
    setupNavigation()
    addSubscriptionChangeObserver()
    setupObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
}

extension AdvertisementController: SubscriptionObserver {
  
  private func setupHandleAdvertisement() {
    
    switch subscriptionManager.applicationDevelopmentSubscriptionStatus {
    case .production:
      self.productionSetup()
    case .premiumSimulated, .lifeTimeSimulated:
      self.advertisementHandler(status: .hiden)
    case .limitedSimulated:
      self.advertisementHandler(status: .active)
    }
  }
  
  private func productionSetup() {
  
    let status: AdvertisementStatus = subscriptionManager.getPurchasePremium() ? .hiden : .active
    status == .active ? self.setupAdvertisemenetBanner() : ()
    self.advertisementHandler(status: status)
    
    Network.theyLive { status in
      switch status {
      case .connedcted:
        SubscriptionManager.instance.purchasePremiumHandler { status in
          Utils.UI {
            switch status {
            case .lifetime, .purchasedPremium:
              if Advertisement.manager.advertisementBannerStatus != .hiden {
                self.advertisementHandler(status: .hiden)
              }
            case .nonPurchased:
              if Advertisement.manager.advertisementBannerStatus != .active {
                self.setupAdvertisemenetBanner()
                self.advertisementHandler(status: .active)
              }
            }
          }
        }
      case .unreachable:
        self.advertisementHandler(status: .hiden)
      }
    }
  }
  
  func setupAdvertisemenetBanner() {
    
    let size = GADAdSizeFullWidthPortraitWithHeight(50)
    var advertisementBannerView: GADBannerView!
    advertisementBannerView = GADBannerView(adSize: size)
    advertisementBannerView.adUnitID = Advertisement.manager.getUnitID(for: .production)
    advertisementBannerView.tag = Advertisement.manager.advertimentBannerTag
    advertisementBannerView.delegate = self
    advertisementBannerView.rootViewController = self
    advertisementBannerView.load(GADRequest())
    self.advertisementView.addSubview(advertisementBannerView)
  }
  
  func subscriptionDidChange() {
    self.setupHandleAdvertisement()
  }
  
  @objc func networkStatusDidChange() {
    self.setupHandleAdvertisement()
  }
}

extension AdvertisementController: Themeble {
  
  private func setupUI() {}
  
  func setupAppearance() {
    self.view.backgroundColor = theme.backgroundColor
    self.advertisementView.backgroundColor = theme.backgroundColor
  }
  
  func setupNavigation() {
    self.navigationController?.updateNavigationColors()
  }
  
  func setupObserver() {
    U.notificationCenter.addObserver(self, selector: #selector(networkStatusDidChange), name: .ConnectivityDidChange, object: nil)
  }
}

extension AdvertisementController {
  
  private func advertisementHandler(status: AdvertisementStatus) {
    
    Advertisement.manager.advertisementBannerStatus = status
    
    var advertisemntContaineHeight: CGFloat {
      switch status {
      case .active:
        return 45 + U.bottomSafeAreaHeight
      case .hiden:
        return 0
      }
    }
    
    self.advertisementHightConstraint.constant = advertisemntContaineHeight
    
    if status == .hiden {
      DispatchQueue.main.async {
        if let view = self.advertisementView.viewWithTag(Advertisement.manager.advertimentBannerTag) {
          view.removeFromSuperview()
        }
      }
    }
    
    DispatchQueue.main.async {
      
      UIView.animate(withDuration: 0.3) {
        //      self.view.layoutIfNeeded()
        self.advertisementView.layoutIfNeeded()
      } completion: { _ in }
    }
  }
}

extension AdvertisementController: GADBannerViewDelegate {
  
  func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
    print("bannerViewDidReceiveAd")
  }
  
  func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
    print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
  }
  
  func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
    print("bannerViewDidRecordImpression")
  }
  
  func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
    print("bannerViewWillPresentScreen")
  }
  
  func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
    print("bannerViewWillDIsmissScreen")
  }
  
  func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
    print("bannerViewDidDismissScreen")
  }
}
