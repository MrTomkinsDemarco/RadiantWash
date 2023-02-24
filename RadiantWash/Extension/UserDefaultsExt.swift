//
//  UserDefaultsExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

extension UserDefaults {
  
  func set(date: Date?, forKey key: String) {
    self.set(date, forKey: key)
  }
  
  func getDate(forKey key: String) -> Date? {
    return self.value(forKey: key) as? Date
  }
}
