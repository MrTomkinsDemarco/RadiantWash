//
//  GroupSelectableAssetsDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

protocol GroupSelectableAssetsDelegate: AnyObject {
  func didSelect(selectedIndexPath: [IndexPath], phassetsGroups: [PhassetGroup])
}
