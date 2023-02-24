//
//  DeepCleanCompleteStateHandler.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum DeepCleanCompleteStateHandler {
  
  case successfull
  case canceled
  
  var description: AlertDescription {
    return LocalizationService.Alert.DeepClean.deepCleanCompleted(for: self)
  }
  
  static func alertHandler(for state: DeepCleanCompleteStateHandler, completionHandler: (() -> Void)? = nil) {
    AlertManager.showDeepCleanProcessing(with: state) {
      completionHandler?()
    }
  }
}
