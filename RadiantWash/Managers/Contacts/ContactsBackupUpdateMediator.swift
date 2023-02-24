//
//  ContactsBackupUpdateMediator.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

class ContactsBackupUpdateMediator {
  
  class var instance: ContactsBackupUpdateMediator {
    struct Static {
      static let instance: ContactsBackupUpdateMediator = ContactsBackupUpdateMediator()
    }
    return Static.instance
  }
  
  private var listener: ContactsBackupUpdateListener?
  private init() {}
  
  func setListener(listener: ContactsBackupUpdateListener) {
    self.listener = listener
  }

  func updateStatus(with status: ContactsBackupStatus) {
    listener?.didUpdateStatus(status)
  }
  
  func updateProgres(with name: String, currentIndex: Int, total files: Int) {
    let progress = CGFloat(Double(currentIndex) / Double(files))
    listener?.didUpdateProgress(with: name, progress: progress)
  }
}
