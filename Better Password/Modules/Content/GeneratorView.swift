//
//  GeneratorView.swift
//  Better Password
//
//  Created by Dominic Kolbe on 13/01/2022.
//

import SwiftUI
import Foundation
import AlertToast

struct GeneratorView: View {
  
  @EnvironmentObject var viewModel: GeneratorViewModel
  
  @State private var showingSheet = false
  
  // MARK: - UI
  
  var body: some View {
    
    NavigationView {
      
      List {
        
        // MARK: - SECRET
        
        Section(header: Text("GENERATED_PASSWORD")) {
          Button {
            Utils.Clipboard.set(value: viewModel.password)
            viewModel.showToast.toggle()
          } label: {
            Text(viewModel.password)
              .font(
                .system(size: 18, weight: .medium, design: .monospaced)
              )
              .lineSpacing(8)
              .frame(maxWidth: .infinity, alignment: .center)
              .foregroundColor(Color(UIColor.label))
              .minimumScaleFactor(0.01)
              .lineLimit(1)
              .multilineTextAlignment(.center)
              .padding(.top, 8)
              .padding(.bottom, 8)
              .transition(.opacity)
              .id("SecretText" + viewModel.password)
          }
          
        }
        
        // MARK: - SLIDER
        
        Section(header: Text("LENGTH")) {
          HStack {
            Slider(
              value: $viewModel.options.totalLength,
              in: viewModel.options.minLength...viewModel.options.maxLength,
              step: 1
            )
            Text(String(format: "%.0f", viewModel.options.totalLength))
              .font(.system(size: 18, weight: .bold, design: .monospaced))
              .padding(.leading, 8)
              .padding(.trailing, 8)
              .frame(minWidth: 40, alignment: .trailing)
          }
        }
        
        // MARK: - OPTIONS
        
        Section(header: Text("OPTIONS")) {
          
          Stepper(
            value: $viewModel.options.numbersLength,
            in: 0...(viewModel.options.maxLength / 2),
            step: 1
          ) {
            HStack {
              Text("MINIMUM_NUMBERS")
              Spacer()
              Text(String(format: "%.0f", viewModel.options.numbersLength))
                .padding(.trailing, 8)
            }
          }
          
          
          Stepper(
            value: $viewModel.options.symbolsLength,
            in: 0...(viewModel.options.maxLength / 2),
            step: 1
          ) {
            HStack {
              Text("SPECIAL_CHARACTERS")
              Spacer()
              Text(String(format: "%.0f", viewModel.options.symbolsLength))
                .padding(.trailing, 8)
            }
          }
          
          
          Toggle("EXCLUDE_AMBIGUOUS_CHARACTERS", isOn: $viewModel.options.excludeAmbiguousCharacters)
          
        }
        
        // MARK: - BUTTON
        
        Section() {
          Button {
            withAnimation(.easeInOut(duration: 0.2)) {
              viewModel.generate()
            }
            
          } label: {
            Text("BUTTON_GENERATE")
              .font(.system(size: 18, weight: .bold, design: .default))
              .foregroundColor(Color(UIColor.label))
              .frame(maxWidth: .infinity)
              .padding(.top, 8)
              .padding(.bottom, 8)
          }
          
        }
        
        // MARK: - END
        
        Section() {
          Button {
            viewModel.reset()
          } label: {
            Text("RESET")
              .frame(maxWidth: .infinity)
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.red)
          }
        }
        
        // MARK: - END
        
      }
      .navigationBarTitleDisplayMode(.inline)
      .sheet(isPresented: $showingSheet) {
        SettingsView()
      }
      .toolbar {
        ToolbarItemGroup(placement: .principal) {
          HStack {
            Image(systemName: "scribble")
            Text("Pssst.")
              .font(.system(size: 28, weight: .bold, design: .default))
          }
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {
            showingSheet.toggle()
          }) {
            Label("Settings", systemImage: "gear")
          }
        }
      }
      .accentColor(Color(UIColor.label))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .toast(isPresenting: $viewModel.showToast){
      AlertToast(
        displayMode: .hud,
        type: .regular,
        title: "ALERT_PASSWORD_COPY"
      )
    }
  }
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group{
      GeneratorView()
        .environmentObject(GeneratorViewModel())
        .preferredColorScheme(.dark)
        .environment(\.locale, .init(identifier: "en"))
      GeneratorView()
        .environmentObject(GeneratorViewModel())
        .preferredColorScheme(.light)
        .environment(\.locale, .init(identifier: "de"))
    }
  }
}
