//
//  Constants.swift
//  Better Password
//
//  Created by Dominic Kolbe on 14/01/2022.
//

import Foundation

struct Constants {
  
  struct STORAGE_KEY {
    static let OPTIONS = "OPTION_KEY"
    static let PASSWORD = "PASSWORD_KEY"
  }
  
  struct DEFAULT_OPTIONS {
    static let TOTAL_LENGTH = 16
    static let NUMBERS_LENGTH = 4
    static let SYMBOLS_LENGTH = 4
    
    static let TOTAL_MIN_LENGTH = 4
    static let TOTAL_MAX_LENGTH = 64
    
    static let EXCLUDE_AMBIGUOUS_CHARACTERS = true
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
  
  //  DIMENSIONS
  
  struct DIMENSIONS {
    static let MAX_WIDTH_IPAD: Double = 768.0
  }
  
  static let CONTACT_ADDRESS = "dev@domnc.app"
  static let PRIVACY_URL = "https://privacy.domnc.app"
  
}
