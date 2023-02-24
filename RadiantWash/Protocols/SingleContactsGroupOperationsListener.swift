//
//  SingleContactsGroupOperationsListener.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

protocol SingleContactsGroupOperationsListener {
  func didMergeContacts(in section: Int)
  func didDeleteFullContactsGroup(in section: Int)
  func didRefactorContactsGroup(in section: Int, with indexPath: IndexPath)
}
