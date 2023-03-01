//
//  SingleContactsGroupOperationsMediator.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

class SingleContactsGroupOperationMediator {
  
  class var instance: SingleContactsGroupOperationMediator {
    struct Static {
      static let instance: SingleContactsGroupOperationMediator = SingleContactsGroupOperationMediator()
    }
    return Static.instance
  }
  
  private var listener: SingleContactsGroupOperationsListener?
  private init() {}
  
  func setListener(listener: SingleContactsGroupOperationsListener) {
    self.listener = listener
  }
  
  func didMergeContacts(in section: Int) {
    listener?.didMergeContacts(in: section)
  }
  
  func didDeleteFullContactsGroup(in section: Int) {
    listener?.didDeleteFullContactsGroup(in: section)
  }
}
