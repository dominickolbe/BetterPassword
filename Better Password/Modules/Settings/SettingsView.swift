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
  @ObservedObject var appSettings = AppSettings.shared
  
  let dictionary = Bundle.main.infoDictionary!
  
  func formatVersion() -> String {
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    return "v\(version) (\(build))"
  }
  
  func formatFooter() -> String {
    let name = dictionary["CFBundleName"] as! String
    return "\(name). stay safe. @ domnc."
  }
  
  var body: some View {
    NavigationView {
      List {
        
        Section(
          header: Text("APPARENCE")
        ) {
          Picker("APPARENCE", selection: appSettings.$currentTheme) {
            Text("APPARENCE_LIGHT").tag(Theme.light)
            Text("APPARENCE_DARK").tag(Theme.dark)
          }.pickerStyle(.segmented)
        }
        
        Section(
          header: Text("ABOUT")
        ) {
          Button(action: {
            if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene)
            }
          }) {
            HStack {
              Text("WRITE_REVIEW")
                .foregroundColor(Color(UIColor.label))
              Spacer()
              Image(systemName: "star.bubble")
                .foregroundColor(Color(UIColor.label))
            }
          }
          HStack {
            Link(
              "CONTACT",
              destination: URL(string: "mailto:\(Constants.CONTACT_ADDRESS)")!
            )
              .foregroundColor(Color(UIColor.label))
            Spacer()
            Image(systemName: "envelope")
              .foregroundColor(Color(UIColor.label))
          }
          HStack {
            Link(
              "PRIVACY",
              destination: URL(string: Constants.PRIVACY_URL)!
            )
              .foregroundColor(Color(UIColor.label))
            Spacer()
            Image(systemName: "eye")
              .foregroundColor(Color(UIColor.label))
          }
        }
        
        Section(
          footer: Text(formatFooter())
            .padding(.top)
        ) {
          HStack {
            Text("APP_VERSION")
            Spacer()
            Text(formatVersion())
              .font(.system(size: 14, design: .monospaced))
              .foregroundColor(.gray)
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
