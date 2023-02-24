//
//  DatePickerStringComponents.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import Foundation

class DatePickerStringComponents {
  
  struct picketType {
    static let year = "y"
    static let month = "M"
    static let date = "d"
    static let dateTime = "yMdShm"
    static let yearMonth = "yM"
    static let monthYear = "My"
    static let custom = ""
  }
  
  struct components {
    static let invalid = "i"
    static let year = "y"
    static let month = "M"
    static let day = "d"
    static let hour = "h"
    static let minute = "m"
    static let space = "S"
  }
  
  struct dateFormatter {
    static let month = "MMMM"
    static let year = "y"
  }
}
