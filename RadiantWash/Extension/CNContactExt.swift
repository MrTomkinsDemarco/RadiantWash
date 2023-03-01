//
//  CNContactExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Contacts

extension CNContact {
  
  func fieldStatus() -> Int {
    return self.emailAddresses.count + self.phoneNumbers.count + (self.givenName.isEmpty ? 0 : 1) + (self.familyName.isEmpty ? 0 : 1) + (self.middleName.isEmpty ? 0 : 1)
  }
}

extension CNContactVCardSerialization {
  
  class func dataWithImage(contacts: [CNContact]) throws -> Data {
    var text: String = ""
    for contact in contacts {
      let data = try CNContactVCardSerialization.data(with: [contact])
      var str = String(data: data, encoding: .utf8)!
      
      if let imageData = contact.thumbnailImageData {
        let base64 = imageData.base64EncodedString()
        str = str.replacingOccurrences(of: "END:VCARD", with: "PHOTO;ENCODING=b;TYPE=JPEG:\(base64)\nEND:VCARD")
      }
      text = text.appending(str)
    }
    return text.data(using: .utf8)!
  }
}
