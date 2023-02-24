//
//  ContactModel.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation
import Contacts

enum ContactModel {
  
  case fullName(String)
  case thumbnailImageData(UIImage)
  case phoneNumbers(CNLabeledValue<CNPhoneNumber>)
  case emailAddresses(CNLabeledValue<NSString>)
  case urlAddresses(CNLabeledValue<NSString>)
  case action
  
  var heightForRow: CGFloat {
    switch self {
    case .thumbnailImageData(_):
      return 200
    default:
      return AppDimensions.ContenTypeCells.heightOfRowOfMediaContentType
    }
  }
}
