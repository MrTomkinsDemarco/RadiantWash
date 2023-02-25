//
//  SortingType.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit

enum SortingType: CaseIterable {
  case date
  case size
  case dimension
  case edit
  case duration
  
  var descriptorKey: SortingDesriptionKey {
    switch self {
    case .date:
      return .creationDate
    case .size:
      return .fileSize
    case .dimension:
      return .pixelDimension
    case .edit:
      return .modificationDate
    case .duration:
      return .duration
    }
  }
  
  var title: String {
    return LocalizationService.Menu.getSortingTitle(of: self)
  }
  
  var image: UIImage {
    return Images.getSortingImage(of: self)
  }
}
