//
//  SegueManager.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit
import SwiftMessages

class ShowDatePickerLowerDateSelectorController: SwiftMessagesSegue {
    
    override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .bottomMessage)
        dimMode = .gray(interactive: false)
        messageView.configureNoDropShadow()
    }
}

class ShowDatePickerUpperDateSelectorController: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureNoDropShadow()
  }
}

class ShowExportContactsControllerSegue: SwiftMessagesSegue {
    
    override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .bottomMessage)
        dimMode = .gray(interactive: false)
        messageView.configureNoDropShadow()
    }
}

class ShowVideoSizeSelectorControllerSegue: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureDropShadow()
  }
}

class ShowVideoCompressionCustomSettingsSelectorControllerSegue: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureDropShadow()
  }
}


class ShowLifeTimeControllerSegue: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureNoDropShadow()
  }
}

class ShowContactsBackupControllerSegue: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureNoDropShadow()
  }
}

class ShowLocationInfoControllerSegue: SwiftMessagesSegue {
  
  override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
    super.init(identifier: identifier, source: source, destination: destination)
    configure(layout: .bottomMessage)
    dimMode = .gray(interactive: false)
    messageView.configureNoDropShadow()
  }
}
