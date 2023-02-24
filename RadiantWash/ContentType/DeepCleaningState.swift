//
//  DeepCleaningState.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum DeepCleaningState {
  
  case redyForStartingCleaning
  case willStartCleaning
  case didCleaning
  case willAvailibleDelete
  case canclel
}

enum DeepCleanButtonState {
  
  case startDeepClen
  case startAnalyzing
  case stopAnalyzing
  case startCleaning
}
