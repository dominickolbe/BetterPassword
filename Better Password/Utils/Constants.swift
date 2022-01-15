//
//  Constants.swift
//  Better Password
//
//  Created by Dominic Kolbe on 14/01/2022.
//

import Foundation

struct Constants {
  
  struct DEFAULTS {
    static let TOTAL_LENGTH = 16
    static let NUMBERS_LENGTH = 4
    static let SYMBOLS_LENGTH = 4
    
    static let TOTAL_MIN_LENGTH = 4
    static let TOTAL_MAX_LENGTH = 64
  }
  
  struct Crypto {
    static let uppercaseCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let lowercaseCharacters = "abcdefghijklmnopqrstuvwxyz"
    static let numbers = "0123456789"
    static let symbols = "!?@#$%^&*"
    static let ambiguousCharacters = "\"'()+,-./:;<=>[\\]_`{|}~"
    
    static func generate(of length: Double, in chars: String) -> String {
      return String((0..<Int(length)).compactMap{ _ in chars.randomElement() })
    }
  }
  
}
