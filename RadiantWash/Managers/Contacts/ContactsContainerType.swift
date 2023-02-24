//
//  ContactsContainerType.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum ContactsContainerType {
  case none
  case card
  case adressBook
  case contacts
  
  var rawValue: String? {
    switch self {
    case .none:
      return nil
    case .card:
      return C.contacts.contactsContainer.card
    case .adressBook:
      return C.contacts.contactsContainer.addressBook
    case .contacts:
      return C.contacts.contactsContainer.contancts
    }
  }
}
