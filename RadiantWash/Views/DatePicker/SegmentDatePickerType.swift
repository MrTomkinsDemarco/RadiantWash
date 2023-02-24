//
//  SegmentDatePickerType.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import Foundation

enum SegmentDatePickerType: String {
  
  case year = "y"
  case month = "M"
  case date = "d"
  case dateTime = "yMdShm"
  case yearMonth = "yM"
  case monthYear = "My"
  case custom = ""
  
  var description: String {
    return self.rawValue
  }
}
