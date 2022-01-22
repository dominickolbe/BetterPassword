//
//  AppSettings.swift
//  Better Password
//
//  Created by Dominic Kolbe on 22/01/2022.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
  static let shared = AppSettings()
  @AppStorage(Constants.STORAGE_KEY.APP_SETTINGS_COLOR_THEME) var currentTheme: Theme = .dark
}

enum Theme: Int {
  case light
  case dark
  
  var colorScheme: ColorScheme {
    switch self {
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }
}
