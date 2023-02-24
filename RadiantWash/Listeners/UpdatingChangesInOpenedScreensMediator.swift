//
//  UpdatingChangesInOpenedScreensMediator.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

class UpdatingChangesInOpenedScreensMediator {
  
  class var instance: UpdatingChangesInOpenedScreensMediator {
    struct Static {
      static let instance: UpdatingChangesInOpenedScreensMediator = UpdatingChangesInOpenedScreensMediator()
    }
    return Static.instance
  }
  
  private var listener: UpdatingChangesInOpenedScreensListeners?
  private init() {}
  
  func setListener(listener: UpdatingChangesInOpenedScreensListeners) {
    self.listener = listener
  }
  
  func updatingChangedScreenShots() {
    listener?.getUpdatingScreenShots()
  }
  
  func updatingChangedSelfies() {
    listener?.getUpdatingSelfies()
  }
}
