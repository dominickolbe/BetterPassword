//
//  Better_PasswordApp.swift
//  Better Password
//
//  Created by Dominic Kolbe on 13/01/2022.
//

import SwiftUI

@main
struct MainApp: App {
  
  @StateObject var viewModel: ViewModel = ViewModel()
  
  var body: some Scene {
    
    WindowGroup {
      ContentView()
        .environmentObject(viewModel)
    }
    
  }
}

