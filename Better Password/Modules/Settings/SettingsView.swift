//
//  SettingsView.swift
//  Better Password
//
//  Created by Dominic Kolbe on 20/01/2022.
//

import SwiftUI
import StoreKit


struct SettingsView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  func version() -> String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    return "\(version) (\(build))"
  }
  
  var body: some View {
    NavigationView {
      List {
        Section(
          header: Text("ABOUT"),
          footer:  Button(action: {
            if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
          }) {
            Label("WRITE_REVIEW", systemImage: "square.and.pencil")
              .accentColor(.accentColor)
          }
            .padding(.top)
        ) {
          HStack {
            Text("APP_VERSION")
            Spacer()
            Text(version())
              .foregroundColor(.gray)
              .font(.callout)
          }
        }
      }
      .navigationTitle(Text("SETTINGS"))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("DONE", action: {
            self.presentationMode.wrappedValue.dismiss()
          })
        }
      }
      .accentColor(.accentColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    Group{
      SettingsView()
        .preferredColorScheme(.dark)
        .environment(\.locale, .init(identifier: "en"))
      SettingsView()
        .preferredColorScheme(.light)
        .environment(\.locale, .init(identifier: "de"))
    }
  }
}
