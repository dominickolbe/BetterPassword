//
//  GeneratorViewModel.swift
//  Better Password
//
//  Created by Dominic Kolbe on 15/01/2022.
//

import Foundation

class GeneratorViewModel: ObservableObject {

  @Published var password: String = parsePassword() {
    didSet {
      UserDefaults.standard.set(password, forKey: Constants.STORAGE_KEY.PASSWORD)
    }
  }

  @Published var options: Options = parseOptions() {
    didSet {
      if let encodedData = try? JSONEncoder().encode(options) {
        UserDefaults.standard.set(encodedData, forKey: Constants.STORAGE_KEY.OPTIONS)
      }
    }
  }

  @Published var showToast = false

  init() {
    if password.isEmpty {
      generate()
    }
  }

  func generate() {

    var value = ""

    if (options.numbersLength + options.symbolsLength) < options.totalLength {
      value = Constants.Crypto.generate(
        of: options.totalLength - options.numbersLength - options.symbolsLength,
        in: Constants.Crypto.lowercaseCharacters + Constants.Crypto.uppercaseCharacters)
    }

    let numbers = Constants.Crypto.generate(of: options.numbersLength, in: Constants.Crypto.numbers)
    let symbols = Constants.Crypto.generate(
      of: options.symbolsLength,
      in: (options.excludeAmbiguousCharacters == false
        ? Constants.Crypto.symbols + Constants.Crypto.ambiguousCharacters
        : Constants.Crypto.symbols)
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
    options = GeneratorViewModel.getNewOptions()
    generate()
  }

  static func parsePassword() -> String {
    if let string = UserDefaults.standard.string(forKey: Constants.STORAGE_KEY.PASSWORD) {
      return string
    }
    return ""
  }

  static func parseOptions() -> Options {
    guard
      let data = UserDefaults.standard.data(forKey: Constants.STORAGE_KEY.OPTIONS),
      let options = try? JSONDecoder().decode(Options.self, from: data)
    else {
      return getNewOptions()
    }
    return options
  }

  static func getNewOptions() -> Options {
    return Options(
      totalLength: Double(Constants.DEFAULT_OPTIONS.TOTAL_LENGTH),
      minLength: Double(Constants.DEFAULT_OPTIONS.TOTAL_MIN_LENGTH),
      maxLength: Double(Constants.DEFAULT_OPTIONS.TOTAL_MAX_LENGTH),
      numbersLength: Double(Constants.DEFAULT_OPTIONS.NUMBERS_LENGTH),
      symbolsLength: Double(Constants.DEFAULT_OPTIONS.SYMBOLS_LENGTH),
      excludeAmbiguousCharacters: (Constants.DEFAULT_OPTIONS.EXCLUDE_AMBIGUOUS_CHARACTERS)
    )
  }

}
