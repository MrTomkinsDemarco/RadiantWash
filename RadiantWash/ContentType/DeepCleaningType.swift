//
//  DeepCleaningType.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum DeepCleaningType {
  
  case prepareCleaning
  case photoCleaning
  case contactsEmptyCleaning
  case contactsMergeCleaning
  case contactsDeleteCleaning
  
  var progressTitle: String {
    return LocalizationService.DeepClean.getProgressTitle(of: self)
  }
}
