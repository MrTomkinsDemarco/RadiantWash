//
//  ContactsBackupUpdateListener.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

protocol ContactsBackupUpdateListener {
  func didUpdateStatus(_ status: ContactsBackupStatus)
  func didUpdateProgress(with name: String, progress: CGFloat)
}
