//
//  Options.swift
//  Better Password
//
//  Created by Dominic Kolbe on 15/01/2022.
//

import Foundation

struct Options: Codable {
  
  var totalLength: Double
  var minLength: Double
  var maxLength: Double
  
  var numbersLength: Double
  var symbolsLength: Double
  
  var excludeAmbiguousCharacters: Bool
  
  init (
    totalLength: Double,
    minLength: Double,
    maxLength: Double,
    numbersLength: Double,
    symbolsLength: Double,
    excludeAmbiguousCharacters: Bool
  ) {
    self.totalLength = totalLength
    self.minLength = minLength
    self.maxLength = maxLength
    self.numbersLength = numbersLength
    self.symbolsLength = symbolsLength
    self.excludeAmbiguousCharacters = excludeAmbiguousCharacters
  }
  
}
