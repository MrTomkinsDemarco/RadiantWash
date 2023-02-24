//
//  SettingsSection.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation
import UIKit

struct SettingsSection {
  
  let cells: [SettingsModel]
  let headerTitle: String?
  let headerHeight: CGFloat?
  
  init(cells: [SettingsModel], headerTitle: String? = nil, headetHeight: CGFloat? = nil) {
    self.cells = cells
    self.headerTitle = headerTitle
    self.headerHeight = headetHeight
  }
}
