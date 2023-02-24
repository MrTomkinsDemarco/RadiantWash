//
//  StringExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension String {
  
  func image(of size: CGFloat) -> UIImage? {
    
    let nsString = (self as NSString)
    let font = UIFont.systemFont(ofSize: size) // you can change your font size here
    let stringAttributes = [NSAttributedString.Key.font: font]
    let imageSize = nsString.size(withAttributes: stringAttributes)
    
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
    UIColor.clear.set() // clear background
    UIRectFill(CGRect(origin: CGPoint(), size: imageSize)) // set rect size
    nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
    let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
    UIGraphicsEndImageContext() //  end image context
    
    return image ?? UIImage()
  }
  
  func replace(string:String, replacement:String) -> String {
    return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
  }
  
  func removeWhitespace() -> String {
    return self.replace(string: " ", replacement: "")
  }
  
  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    let start = index(startIndex, offsetBy: r.lowerBound)
    let end = index(startIndex, offsetBy: r.upperBound)
    let range: Range<Index> = start..<end
    return String(self[range])
  }
  
  var containsAlphabets: Bool {
    //Checks if all the characters inside the string are alphabets
    let set = CharacterSet.letters
    return self.utf16.contains {
      guard let unicode = UnicodeScalar($0) else { return false }
      return set.contains(unicode)
    }
  }
  
  func removeNonNumeric() -> String {
    return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
  }
  
  func containsNumbers() -> Bool {
    let numberRegEx  = ".*[0-9]+.*"
    let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    return testCase.evaluate(with: self)
  }
  
  func containsAlphaNumeric() -> Bool {
    let alphaNumericRegEx = ".*[^A-Za-z0-9].*"
    let predicateCase = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
    return predicateCase.evaluate(with: self)
  }
  
  func contains(find: String) -> Bool{
    return self.range(of: find) != nil
  }
  
  func containsIgnoringCase(find: String) -> Bool{
    return self.range(of: find, options: .caseInsensitive) != nil
  }
  
  func getSeconds() -> Int {
    let components = self.components(separatedBy: ":")
    var seconds = 0
    var multiplies = [1]
    if components.count > 1 {
      multiplies.insert(60, at:0)
      if components.count > 2 {
        multiplies.insert(60 * 60, at:0)
      }
    }
    for index in 0..<components.count {
      if let s = Int(components[index]) {
        seconds += s * multiplies[index]
      }
    }
    return seconds
  }
  
  static func fromSeconds(_ seconds: Int) -> String {
    let hours = Swift.max(0, seconds / 3600)
    let minutes = Swift.max(0, (seconds % 3600) / 60)
    let seconds = Swift.max(0, (seconds % 3600) % 60)
    var ret = String(format: "0:%02d", seconds)
    if minutes > 0 {
      ret = String(format: "%d:%02d", minutes, seconds)
      if hours > 0 {
        ret = String(format: "%d:%02d:%02d", hours, minutes, seconds)
      }
    }
    return ret
  }
  
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }
  
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.width)
  }
  
  func localizedWith(count: Int) -> String {
    return String.localizedStringWithFormat(NSLocalizedString(self, comment: ""), count)
  }
  
  func chopPrefix(_ count: Int = 1) -> String {
    if count >= 0 && count <= self.count {
      let indexStartOfText = self.index(self.startIndex, offsetBy: count)
      return String(self[indexStartOfText...])
    }
    return ""
  }
  
  func chopSuffix(_ count: Int = 1) -> String {
    if count >= 0 && count <= self.count {
      let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
      return String(self[..<indexEndOfText])
    }
    return ""
  }
}

protocol AttributedStringComponent {
  
  var text: String { get }
  func getAttributes() -> [NSAttributedString.Key: Any]?
}

extension String: AttributedStringComponent {
  
  var text: String { self }
  func getAttributes() -> [NSAttributedString.Key: Any]? { return nil }
}

extension String {
  
  func toAttributed(with attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString {
    .init(string: self, attributes: attributes)
  }
}

extension NSAttributedString: AttributedStringComponent {
  
  var text: String { string }
  
  func getAttributes() -> [Key: Any]? {
    if string.isEmpty { return nil }
    var range = NSRange(location: 0, length: string.count)
    return attributes(at: 0, effectiveRange: &range)
  }
}

extension NSAttributedString {
  
  convenience init?(from attributedStringComponents: [AttributedStringComponent],
                    defaultAttributes: [NSAttributedString.Key: Any],
                    joinedSeparator: String = " ") {
    switch attributedStringComponents.count {
    case 0: return nil
    default:
      var joinedString = ""
      typealias SttributedStringComponentDescriptor = ([NSAttributedString.Key: Any], NSRange)
      let sttributedStringComponents = attributedStringComponents.enumerated().flatMap { (index, component) -> [SttributedStringComponentDescriptor] in
        var components = [SttributedStringComponentDescriptor]()
        if index != 0 {
          components.append((defaultAttributes,
                             NSRange(location: joinedString.count, length: joinedSeparator.count)))
          joinedString += joinedSeparator
        }
        components.append((component.getAttributes() ?? defaultAttributes,
                           NSRange(location: joinedString.count, length: component.text.count)))
        joinedString += component.text
        return components
      }
      
      let attributedString = NSMutableAttributedString(string: joinedString)
      sttributedStringComponents.forEach { attributedString.addAttributes($0, range: $1) }
      self.init(attributedString: attributedString)
    }
  }
}

extension String {
  
  func NSDateConverter(format: String) -> NSDate {
    let dateFormatter = DateFormatter()
    let callendar = Calendar.current
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = callendar.timeZone
    
    if let date = dateFormatter.date(from: self) as NSDate? {
      return date
    } else {
      
      let time = convertDateFormatter(fromFormat: format, toFormat: format + " a", self)
      return dateFormatter.date(from: time)! as NSDate
    }
  }
  
  
  func convertDateFormatter(fromFormat:String,toFormat:String,_ dateString: String) -> String{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = fromFormat
    let date = formatter.date(from: dateString)
    formatter.dateFormat = toFormat
    return  date != nil ? formatter.string(from: date!) : ""
  }
  
  func replacingStringAndConvertToIntegerForImage() -> Int {
    if let integer = Int(self.replacingOccurrences(of: "image", with: "")) {
      return integer
    } else {
      return 0
    }
  }
}
