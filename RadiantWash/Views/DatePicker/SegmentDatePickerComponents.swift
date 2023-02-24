//
//  SegmentDatePickerComponents.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import Foundation

enum SegmentDatePickerComponents: Character {
  
  case invalid = "i"
  case year = "y"
  case month = "M"
  case day = "d"
  case hour = "h"
  case minute = "m"
  case space = "S"
}

enum DateComponent: Int {
  case month
  case year
}
