//
//  Better_PasswordApp.swift
//  Better Password
//
//  Created by Dominic Kolbe on 13/01/2022.
//

import SwiftUI

@main
struct BetterPasswordApp: App {
  
  @StateObject var viewModel: GeneratorViewModel = GeneratorViewModel()
  
  var body: some Scene {
    WindowGroup {
      GeneratorView()
        .environmentObject(viewModel)
//      TODO: iPad and macOS
//        .frame(minWidth: 200, maxWidth: 500)
    }
  }
}

