//
//  FileFormats.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

enum ExportContactsAvailibleFormat {
  
  case vcf
  case csv
  case none
  
  var formatRowValue: String {
    switch self {
    case .vcf:
      return "VCF"
    case .csv:
      return "CSV"
    default:
      return "hello chao"
    }
  }
}
