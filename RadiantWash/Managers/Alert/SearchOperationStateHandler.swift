//
//  SearchOperationStateHandler.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum SearchOperationStateHandler {
  
  case resetDeepCleanSearch
  case resetSingleCleanSearch
  case resetSmartSingleCleanSearch
  case resetDeepCleanDelete
  case resetDeepCleanResults
  
  var description: AlertDescription {
    return LocalizationService.Alert.CleanOperationState.operationDescription(for: self)
  }
  
  static func alertHandler(for state: SearchOperationStateHandler, completionHandler: @escaping () -> Void) {
    AlertManager.showOperationProcessing(with: state) {
      completionHandler()
    }
  }
}
