//
//  UpdateMediaStoreSizeDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

protocol UpdateMediaStoreSizeDelegate {
  func didStartUpdatingMediaSpace(photo: Int64?, video: Int64?)
}
