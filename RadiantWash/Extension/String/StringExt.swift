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
  
  func chopSuffix(_ count: Int = 1) -> String {
    if count >= 0 && count <= self.count {
      let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
      return String(self[..<indexEndOfText])
    }
    return ""
  }
}

extension String {
  
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
