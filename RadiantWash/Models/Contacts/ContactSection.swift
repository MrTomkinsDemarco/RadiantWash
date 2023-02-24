//
//  ContactSection.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation

struct ContactSection {
  
  let contactModelFields: [ContactModel]
  let headerTitle: String?
  let headerHeight: CGFloat?
  
  init(contactModelFields: [ContactModel], headerTitle: String?, headerHeight: CGFloat?) {
    self.contactModelFields = contactModelFields
    self.headerTitle = headerTitle
    self.headerHeight = headerHeight
  }
}
