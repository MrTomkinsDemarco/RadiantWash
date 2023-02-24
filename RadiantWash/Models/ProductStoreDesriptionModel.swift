//
//  ProductStoreDesriptionModel.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation

class ProductStoreDesriptionModel {

  var productName: String
  var productPrice: String
  var productPeriod: String
  var description: String
  var id: String

  init(name: String, price: String, period: String, description: String, id: String) {
    self.productName = name
    self.productPrice = price
    self.productPeriod = period
    self.description = description
    self.id = id
  }
}
