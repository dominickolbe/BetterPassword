//
//  ModelData.swift
//  Better Password
//
//  Created by Dominic Kolbe on 14/01/2022.
//

import Foundation

class ViewModel: ObservableObject {
  
  @Published var password: String;
  
  @Published var totalLength: Double;
  @Published var numbersLength: Double;
  @Published var symbolsLength: Double;
  @Published var ambiguousCharactersExclude = true
  
  @Published var totalMinLength: Double;
  @Published var totalMaxLength: Double;
  
  @Published var showToast = false
  
  
  init() {
    
    password = ""
    
    totalLength = Double(Constants.DEFAULTS.TOTAL_LENGTH)
    numbersLength = Double(Constants.DEFAULTS.NUMBERS_LENGTH)
    symbolsLength = Double(Constants.DEFAULTS.SYMBOLS_LENGTH)
    
    totalMinLength = Double(Constants.DEFAULTS.TOTAL_MIN_LENGTH)
    totalMaxLength = Double(Constants.DEFAULTS.TOTAL_MAX_LENGTH)
    
    // TODO
    generate()
  }
  
  func generate() {
    
    var value = "";
    
    if ((numbersLength + symbolsLength) < totalLength) {
      value = Constants.Crypto.generate(of: totalLength - numbersLength - symbolsLength, in: Constants.Crypto.lowercaseCharacters+Constants.Crypto.uppercaseCharacters)
    }
    
    let numbers = Constants.Crypto.generate(of: numbersLength, in: Constants.Crypto.numbers)
    let symbols = Constants.Crypto.generate(
      of: symbolsLength,
      in: (ambiguousCharactersExclude == false ? Constants.Crypto.symbols+Constants.Crypto.ambiguousCharacters : Constants.Crypto.symbols)
    )
    
    value += numbers + symbols
    
    var secretArr = Array(value)
    
    let shuffleCount = Int.random(in: 1..<42)
    
    for _ in 1...shuffleCount {
      secretArr.shuffle()
    }
    
    password = String(secretArr)
    
  }
  
  func reset() {
    totalLength = Double(Constants.DEFAULTS.TOTAL_LENGTH)
    numbersLength = Double(Constants.DEFAULTS.NUMBERS_LENGTH)
    symbolsLength = Double(Constants.DEFAULTS.SYMBOLS_LENGTH)
    
    totalMinLength = Double(Constants.DEFAULTS.TOTAL_MIN_LENGTH)
    totalMaxLength = Double(Constants.DEFAULTS.TOTAL_MAX_LENGTH)
    
    // TODO
    generate()
  }
  
  
}
